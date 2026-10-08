# Kubernetes Storage, HPA, and Probes

This session covers Kubernetes volume types and persistent storage, then walks through a CPU-based Horizontal Pod Autoscaler (HPA) exercise and a small PVC-backed web application with health probes.

## Contents

- [Kubernetes storage concepts](#kubernetes-storage-concepts)
- [Prerequisites](#prerequisites)
- [Mini-project: PVC-backed web page with probes](#mini-project-pvc-backed-web-page-with-probes)
- [HPA hands-on](#hpa-hands-on)
- [Cleanup](#cleanup)

## Kubernetes storage concepts

Containers have an ephemeral writable layer: data written there is lost when that container is replaced. Kubernetes volumes provide storage with a lifecycle and sharing behavior defined by the volume type.

### `emptyDir`

An `emptyDir` is created when a Pod is assigned to a node. Containers in that Pod can mount and share it. The data remains for the life of the Pod, including a container restart, but is deleted when the Pod is removed.

Use it for temporary scratch space, caches, or files shared between sidecars. It is not durable storage.

```yaml
volumes:
  - name: work
    emptyDir: {}
containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "echo hello > /work/message.txt; sleep 3600"]
    volumeMounts:
      - name: work
        mountPath: /work
```

`emptyDir: { medium: Memory }` uses memory-backed storage (tmpfs); account for its memory usage when setting Pod resource limits.

### `hostPath`

A `hostPath` mounts a path from the node's filesystem into a Pod. It can be useful for node agents that need access to host files, but it ties the workload to node filesystem layout and can expose host data. Pods scheduled on different nodes may see different contents. Avoid it for ordinary application persistence and do not assume a directory exists unless it is created or the volume type creates it.

```yaml
volumes:
  - name: node-data
    hostPath:
      path: /var/lib/my-app
      type: DirectoryOrCreate
containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "echo hello >> /data/example.txt; sleep 3600"]
    volumeMounts:
      - name: node-data
        mountPath: /data
```

This path is on the Kubernetes node, not necessarily on the machine where `kubectl` is run. For managed clusters, local development clusters, and multi-node applications, prefer a PersistentVolumeClaim backed by suitable storage.

### PersistentVolume (PV)

A PersistentVolume is a cluster storage resource. It represents storage provisioned by an administrator or provisioned dynamically by a StorageClass. A PV's lifecycle is independent of an individual Pod.

Example of a **static, local demonstration PV** (the path must exist on the eligible Linux node; do not use this as a portable production storage design):

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: demo-local-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data
    type: DirectoryOrCreate
```

### PersistentVolumeClaim (PVC)

A PersistentVolumeClaim is an application's request for storage. Kubernetes binds it to a compatible PV based on requested size, access mode, and StorageClass. Pods normally mount the PVC rather than referring directly to a PV.

Example claim matching the static PV above:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-local-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  resources:
    requests:
      storage: 1Gi
```

`ReadWriteOnce` generally means read-write mounting from one node at a time; it does not necessarily mean only one Pod can use the volume. Supported access modes and sharing behavior depend on the storage driver.

### StorageClass

A StorageClass describes a storage type and the provisioner and parameters used to create it. Cluster administrators commonly install one or more classes, such as standard block or network file storage. Inspect the classes available in your cluster:

```powershell
kubectl get storageclass
kubectl describe storageclass <storage-class-name>
```

The mini-project PVC below intentionally omits `storageClassName`, asking Kubernetes to use the cluster's default StorageClass. If the cluster has no default class, set `storageClassName` to one shown by `kubectl get storageclass`.

### Dynamic provisioning

With dynamic provisioning, a PVC requesting a StorageClass causes its provisioner/CSI driver to create a matching PV automatically. This avoids pre-creating PVs by hand. The claim can stay `Pending` if there is no matching class, no default class, or the provisioner cannot create the requested storage.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  # Optional: choose an installed class explicitly.
  # storageClassName: <storage-class-name>
```

After applying a claim, check `kubectl get pvc` and `kubectl describe pvc app-data`. A dynamically provisioned claim normally leads to a PV being created and bound; deleting the claim's PV or reclaiming its backing storage depends on the StorageClass/PV reclaim policy.

## Prerequisites

- A working Kubernetes cluster and `kubectl` configured to use it.
- A default StorageClass (or a class selected in `mini-project.yml`) for the storage mini-project.
- A working Metrics Server for `kubectl top` and HPA resource metrics.
- Permission to create Deployments, Services, HPAs, and PVCs in the current namespace.

Check the context and cluster prerequisites before applying anything:

```powershell
kubectl config current-context
kubectl get nodes
kubectl get storageclass
kubectl top nodes
```

If `kubectl top nodes` reports that Metrics Server is unavailable, install/enable Metrics Server using the instructions for your cluster provider before continuing. HPA scaling and `kubectl top pods` need metrics to be available.

**Screenshot placeholder — cluster/context and available StorageClass**

![TODO: Add a screenshot showing the current context, Ready nodes, and StorageClass output](screenshots/01-cluster-and-storageclass.png)

## Mini-project: PVC-backed web page with probes

`mini-project.yml` deploys a small Nginx site. A dynamically provisioned PVC stores its page; an init container creates the page only when it is not already present. The main container has startup, readiness, and liveness probes.

From this folder, run:

```powershell
kubectl apply -f .\mini-project.yml
kubectl get pvc
kubectl get pods -l app=storage-demo -w
```

Wait for the PVC to show `Bound` and the Pod to show `1/1 Running`. Stop watching with **Ctrl+C**. If the PVC remains `Pending`, check `kubectl describe pvc storage-demo-data` and select an available StorageClass in `mini-project.yml`.

Inspect the storage and health checks:

```powershell
kubectl get pv
kubectl describe pvc storage-demo-data
kubectl describe pod -l app=storage-demo
kubectl get pods -l app=storage-demo
```

Port-forward the Service in one PowerShell window:

```powershell
kubectl port-forward service/storage-demo 8080:80
```

In another PowerShell window, open `http://localhost:8080`:

```powershell
Start-Process http://localhost:8080
```

To demonstrate that the HTML file is stored on the claim, replace it, delete the Pod, wait for its replacement, then refresh the browser:

```powershell
kubectl exec deployment/storage-demo -- sh -c "echo '<h1>Persisted on the PVC</h1>' > /usr/share/nginx/html/index.html"
kubectl delete pod -l app=storage-demo
kubectl get pods -l app=storage-demo -w
```

Stop watching with **Ctrl+C**, then refresh the page. The init container leaves an existing file untouched, so the edited page should survive Pod replacement.

**Screenshot placeholder — PVC bound and web Pod ready**

![TODO: Add a screenshot showing the Bound PVC and Ready storage-demo Pod](screenshots/02-pvc-and-ready-pod.png)

**Screenshot placeholder — application page before and after Pod replacement**

![TODO: Add a browser screenshot showing the PVC-backed page after the Pod was recreated](screenshots/03-persistent-web-page.png)

**Screenshot placeholder — probe status**

![TODO: Add a terminal screenshot of kubectl describe pod showing startup, readiness, and liveness probe details](screenshots/04-probe-status.png)

## HPA hands-on

The provided `hpa.yml` deploys the CPU-intensive `registry.k8s.io/hpa-example` sample application, exposes it through a Service, and defines an autoscaling/v2 HPA. It targets 50% average CPU utilization with a CPU request of 100m per Pod. `load-generator.yml` continuously requests the application to create CPU load.

### 1. Deploy the application and HPA

```powershell
kubectl apply -f .\hpa.yml
kubectl get deployment,service,hpa
kubectl get pods -l run=php-apache
kubectl get hpa
```

Wait until the application Pod is `Running` and the HPA has a CPU metric value (not `<unknown>`):

```powershell
kubectl get hpa --watch
```

Stop watching with **Ctrl+C**. If CPU remains `<unknown>`, check Metrics Server and allow time for the first metrics sample.

**Screenshot placeholder — application and HPA deployed before load**

![TODO: Add a terminal screenshot showing the php-apache Pod, Service, and HPA before load](screenshots/05-hpa-before-load.png)

### 2. Deploy the load generator

```powershell
kubectl apply -f .\load-generator.yml
kubectl get pods
```

The load-generator Pod continuously calls the `php-apache` Service. Confirm it is `Running`.

**Screenshot placeholder — load generator running**

![TODO: Add a terminal screenshot showing the load-generator Pod running](screenshots/06-load-generator-running.png)

### 3. Observe CPU and scaling

Allow a few metrics collection intervals for the HPA to react, then run:

```powershell
kubectl get hpa
kubectl get pods
kubectl top pods
kubectl describe hpa php-apache
```

For live observation, open separate PowerShell windows and run:

```powershell
kubectl get hpa --watch
```

```powershell
kubectl get pods --watch
```

Stop each watch with **Ctrl+C**. HPA scaling is not instantaneous; the displayed CPU percentage is relative to the CPU request, and replica counts change after the controller observes sufficient metrics. `kubectl top pods` should show CPU usage increasing while the load generator is active.

**Screenshot placeholder — CPU utilization under load**

![TODO: Add a terminal screenshot of kubectl top pods while the load generator is active](screenshots/07-cpu-under-load.png)

**Screenshot placeholder — HPA scaling and event details**

![TODO: Add a terminal screenshot showing kubectl get hpa and kubectl describe hpa php-apache with increased replicas](screenshots/08-hpa-scale-up.png)

**Screenshot placeholder — additional Pods created**

![TODO: Add a terminal screenshot of kubectl get pods showing multiple php-apache Pods](screenshots/09-pods-scaled-up.png)

### 4. Stop the load and observe scale-down

```powershell
kubectl delete -f .\load-generator.yml
kubectl get hpa --watch
```

The HPA may take several minutes to scale back down, and its stabilization window can delay scale-down. Stop watching with **Ctrl+C** after replica counts decrease.

**Screenshot placeholder — HPA after load stops**

![TODO: Add a terminal screenshot showing the HPA replica count decreasing after load-generator deletion](screenshots/10-hpa-scale-down.png)

### Example output to record

Actual values depend on the cluster and timing. Capture your own command output in the screenshots above; do not use these illustrative values as evidence.

```text
NAME         REFERENCE               TARGETS    MINPODS   MAXPODS   REPLICAS
php-apache   Deployment/php-apache   180%/50%   1         10        4
```

```text
NAME                          READY   STATUS    RESTARTS
php-apache-<suffix>           1/1     Running   0
php-apache-<another-suffix>   1/1     Running   0
load-generator-<suffix>       1/1     Running   0
```

## Cleanup

Remove the HPA exercise resources and mini-project when finished. The PVC deletion can also delete its dynamically provisioned backing storage, depending on the StorageClass reclaim policy; back up anything you need before deleting it.

```powershell
kubectl delete -f .\load-generator.yml --ignore-not-found
kubectl delete -f .\hpa.yml --ignore-not-found
kubectl delete -f .\mini-project.yml --ignore-not-found
```

## Screenshot checklist

Save your screenshots in a `screenshots` subfolder next to this README, using the filenames in the placeholders above. From this assignment folder, create the directory in PowerShell with:

```powershell
New-Item -ItemType Directory -Force .\screenshots
```

Replace each placeholder image with the real screenshot at the same path. Capture readable terminal output (including the command where useful), and avoid showing credentials or other sensitive information.
