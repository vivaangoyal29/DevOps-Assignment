````markdown
# Kubernetes Ingress Assignment

## 1. Ingress vs Ingress Controller

### Ingress

**Ingress** is a Kubernetes API object that defines rules for routing external HTTP/HTTPS traffic to internal cluster Services.

It acts as a **configuration or blueprint** for traffic routing.

### Ingress Controller

An **Ingress Controller** is the actual software that implements the routing rules defined by an Ingress resource.

Examples include:

- NGINX
- Traefik
- HAProxy

> An Ingress resource requires an Ingress Controller to actually route traffic.

---

## 2. Host-based vs Path-based Routing

### Host-based Routing

Routes traffic to different Services based on the **hostname/domain** in the request.

**Example:**

```text
api.example.com  →  Service A
shop.example.com →  Service B
````

### Path-based Routing

Routes traffic based on the **URL path** under the same domain.

**Example:**

```text
example.com/api  →  Service A
example.com/shop →  Service B
```

---

## 3. In-Class Commands

### ConfigMaps and Secrets

<img width="1147" height="183" alt="Screenshot 2026-09-17 231704" src="https://github.com/user-attachments/assets/beb0ab52-48be-470a-bfce-573c1cbb75c8" />


### ConfigMap JSONPath

<img width="1430" height="101" alt="Screenshot 2026-09-17 232145" src="https://github.com/user-attachments/assets/71068be4-9afe-4842-8cba-89447a65c927" />



### ConfigMap and Secret YAML

<img width="1550" height="443" alt="image" src="https://github.com/user-attachments/assets/4bc9b1f6-913e-4f11-883e-bb3a4b39ea21" />
<img width="1581" height="571" alt="image" src="https://github.com/user-attachments/assets/7e553506-3122-4011-a93c-cc1ff177a0e4" />


```
```
