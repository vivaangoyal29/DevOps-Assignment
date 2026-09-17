````markdown
# Kubernetes Architecture Guide

Kubernetes is an open-source platform for managing containerized workloads and services. A Kubernetes **cluster** consists of a **Control Plane** and one or more **Worker Nodes**.

---

## 🏗️ High-Level Architecture

```text
                Kubernetes Cluster
                       │
          ┌────────────┴────────────┐
          │                         │
     Control Plane             Worker Nodes
          │                         │
    ┌─────┼─────┐              ┌────┼────┐
    │     │     │              │    │    │
 API   etcd  Scheduler      Kubelet Proxy Runtime
 Server                     │
                            ▼
                           Pods
````

### Control Plane

The **Control Plane** manages the overall state of the cluster and makes decisions such as scheduling Pods.

### Worker Nodes

**Worker Nodes** run the actual application workloads inside **Pods**.

---

## 🧠 Control Plane Components

### 1. `kube-apiserver`

The **API Server** is the main entry point to Kubernetes.

* Exposes the Kubernetes API.
* Validates API requests.
* Allows `kubectl` and other components to communicate with the cluster.

```text
kubectl → kube-apiserver → Kubernetes
```

### 2. `etcd`

`etcd` is a distributed key-value store that stores Kubernetes cluster state and configuration.

Examples:

* Pods
* Deployments
* Services
* Secrets
* Nodes

### 3. `kube-scheduler`

The scheduler decides **which worker node should run a Pod**.

It considers factors such as:

* CPU and memory
* Node availability
* Affinity/anti-affinity
* Other scheduling constraints

### 4. `kube-controller-manager`

Runs controllers that continuously ensure the **actual state** matches the **desired state**.

For example:

```text
Desired: 3 Pods
Actual:  2 Pods
       ↓
Controller creates another Pod
```

Common controllers include:

* Node Controller
* Job Controller
* EndpointSlice Controller
* ServiceAccount Controller

### 5. `cloud-controller-manager`

Handles cloud-provider-specific operations such as:

* Load balancers
* Cloud networking
* Cloud node management

---

## 💻 Worker Node Components

### 1. `kubelet`

The **kubelet** runs on every worker node and ensures that the containers defined in Pods are running and healthy.

```text
kubelet → Container Runtime → Containers
```

### 2. `kube-proxy`

`kube-proxy` maintains network rules that allow traffic to reach Pods through Kubernetes Services.

### 3. Container Runtime

The container runtime is responsible for actually running containers.

Examples:

* `containerd`
* `CRI-O`

---

## 🔄 How Everything Works Together

When you run:

```bash
kubectl apply -f deployment.yaml
```

The basic flow is:

```text
kubectl
   ↓
API Server
   ↓
etcd
   ↓
Controllers
   ↓
Scheduler
   ↓
Worker Node
   ↓
kubelet
   ↓
Container Runtime
   ↓
Pod
```

---

## 📚 Quick Summary

| Component                  | Responsibility             |
| -------------------------- | -------------------------- |
| `kube-apiserver`           | Kubernetes API             |
| `etcd`                     | Stores cluster state       |
| `kube-scheduler`           | Assigns Pods to nodes      |
| `kube-controller-manager`  | Maintains desired state    |
| `cloud-controller-manager` | Cloud-specific operations  |
| `kubelet`                  | Manages Pods on nodes      |
| `kube-proxy`               | Service networking         |
| Container Runtime          | Runs containers            |
| Pod                        | Runs application workloads |

---

## 🔗 Reference

[Kubernetes Architecture Documentation](https://kubernetes.io/docs/concepts/architecture/)

```
```
