# Docker Multi-Stage Build Homework

## Student Information

| Field                 | Details                |
| --------------------- | ---------------------- |
| **Name**              | YOUR NAME              |
| **Enrollment Number** | YOUR ENROLLMENT NUMBER |

---

# Task 1: Run Multi-Stage Dockerfile

## Objective

The objective of this task was to build and run a Docker image using a **multi-stage Dockerfile** and verify that the application is accessible through port `8080`.

The application should display:

> **Hello World from Docker multi-stage build**

---

## Step 1: Clone the Repository

The repository containing the multi-stage Dockerfile was cloned using:

```bash
git clone <REPOSITORY-URL>
```

The repository was then opened using:

```bash
cd <REPOSITORY-FOLDER>
```

---

## Step 2: Build the Docker Image

The Docker image was built using:

```bash
docker build -t multi-stage-hello .
```

The multi-stage Dockerfile was successfully processed and the Docker image was created.

### Screenshot

![Docker Build](screenshots/docker-build.png)

---

## Step 3: Run the Docker Container

The container was started using:

```bash
docker run -d -p 8080:8080 --name multi-stage-container multi-stage-hello
```

The `-p 8080:8080` option maps:

```text
Host Port 8080 → Container Port 8080
```

---

## Step 4: Verify the Running Container

The running Docker containers were checked using:

```bash
docker ps
```

The output showed that the container was running and port `8080` was mapped successfully.

### Screenshot

![Docker PS](screenshots/docker-ps.png)

---

## Step 5: Access the Application

The application was accessed through a web browser using:

```text
http://localhost:8080
```

The application successfully displayed:

**Hello World from Docker multi-stage build**

### Screenshot

![Application Running](screenshots/application.png)

---

# Task 3: Docker Application Deployment

As part of the assignment, three different types of applications were deployed using Docker:

1. Node.js
2. Python
3. Java

---

## 1. Node.js Application

The Node.js application was containerized using a Dockerfile and built into a Docker image.

### Build

```bash
docker build -t nodejs-hello ./nodejs-app
```

### Run

```bash
docker run -d -p 3000:3000 --name nodejs-container nodejs-hello
```

### Access

```text
http://localhost:3000
```

### Screenshot

![Node.js Application](screenshots/nodejs.png)

---

## 2. Python Application

The Python application was containerized using Docker.

### Build

```bash
docker build -t python-hello ./python-app
```

### Run

```bash
docker run -d -p 8000:8000 --name python-container python-hello
```

### Access

```text
http://localhost:8000
```

### Screenshot

![Python Application](screenshots/python.png)

---

## 3. Java Application

The Java application was containerized using Docker.

### Build

```bash
docker build -t java-hello ./java-app
```

### Run

```bash
docker run -d -p 8081:8080 --name java-container java-hello
```

### Access

```text
http://localhost:8081
```

### Screenshot

![Java Application](screenshots/java.png)

---

# Docker Port Summary

| Application             | Host Port | Container Port | URL                   |
| ----------------------- | --------: | -------------: | --------------------- |
| Multi-Stage Application |      8080 |           8080 | http://localhost:8080 |
| Node.js                 |      3000 |           3000 | http://localhost:3000 |
| Python                  |      8000 |           8000 | http://localhost:8000 |
| Java                    |      8081 |           8080 | http://localhost:8081 |

---

# Conclusion

This assignment provided practical experience with Docker multi-stage builds and application deployment.

The tasks demonstrated:

* Cloning a repository containing a multi-stage Dockerfile
* Building a Docker image
* Running a Docker container
* Mapping host and container ports
* Verifying running containers using `docker ps`
* Accessing a containerized web application
* Deploying Node.js, Python, and Java applications using Docker
* Documenting Docker deployment results with screenshots and command outputs

The multi-stage Docker application was successfully deployed and verified on **port 8080**.
