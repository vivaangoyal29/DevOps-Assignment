# 🐳 Docker Fundamentals Assignment

## 📌 Overview

This assignment demonstrates the fundamentals of **Docker containerization** by creating, building, running, and testing six simple **Hello World web applications** using different technologies.

The applications included in this assignment are:

* 🟢 Node.js
* 🐍 Python
* ☕ Java
* 🌐 Apache
* ⚛️ React
* 🔵 Nginx

Each application has its own folder containing the application code and a `Dockerfile`. Each application is built into a Docker image and run as an independent Docker container.

---

# 📁 Repository Structure

```text
Docker fundamental/
│
├── nodejs-app/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
│
├── python-app/
│   ├── Dockerfile
│   └── app.py
│
├── java-app/
│   ├── Dockerfile
│   └── src/
│       └── Main.java
│
├── Apache-app/
│   ├── Dockerfile
│   └── index.html
│
├── React-app/
│   ├── Dockerfile
│   ├── package.json
│   ├── vite.config.js
│   ├── index.html
│   └── src/
│       ├── App.jsx
│       └── main.jsx
│
├── nginx-app/
│   ├── Dockerfile
│   └── index.html
│
└── README.md
```

---

# 🚀 Applications

## 1. 🟢 Node.js Application

### Description

The Node.js application is a simple HTTP web server created using Node.js.

The server listens for HTTP requests and returns a **Hello World** message to the browser.

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | Node.js               |
| Docker Image   | `nodejs-hello`        |
| Container Name | `nodejs-container`    |
| Container Port | `3000`                |
| Host Port      | `3000`                |
| URL            | http://localhost:3000 |

### Build

```bash
cd nodejs-app
docker build -t nodejs-hello .
```

### Run

```bash
docker run -d -p 3000:3000 --name nodejs-container nodejs-hello
```

### 🌐 Result

Open **http://localhost:3000** in a browser.

### 📸 Screenshot

<img width="1917" height="970" alt="Screenshot 2026-09-03 211829" src="https://github.com/user-attachments/assets/b1cbee99-79c1-47e1-9261-20bba0eed978" />


---

# 2. 🐍 Python Application

### Description

The Python application uses Python's built-in HTTP server functionality to create a simple web server.

The server returns a **Hello World from Python** message when accessed through a browser.

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | Python                |
| Docker Image   | `python-hello`        |
| Container Name | `python-container`    |
| Container Port | `8000`                |
| Host Port      | `8000`                |
| URL            | http://localhost:8000 |

### Build

```bash
cd python-app
docker build -t python-hello .
```

### Run

```bash
docker run -d -p 8000:8000 --name python-container python-hello
```

### 🌐 Result

Open **http://localhost:8000** in a browser.

### 📸 Screenshot

<img width="1917" height="872" alt="Screenshot 2026-09-03 212013" src="https://github.com/user-attachments/assets/11ee9e26-7490-4532-9cf2-323a169b727a" />


---

# 3. ☕ Java Application

### Description

The Java application uses Java's built-in `HttpServer` class to create a simple HTTP web server.

The application listens on port `8080` and displays a **Hello World from Java** message.

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | Java                  |
| Docker Image   | `java-hello`          |
| Container Name | `java-container`      |
| Container Port | `8080`                |
| Host Port      | `8080`                |
| URL            | http://localhost:8080 |

### Build

```bash
cd java-app
docker build -t java-hello .
```

### Run

```bash
docker run -d -p 8080:8080 --name java-container java-hello
```

### 🌐 Result

Open **http://localhost:8080** in a browser.

### 📸 Screenshot

<img width="1917" height="957" alt="Screenshot 2026-09-03 212359" src="https://github.com/user-attachments/assets/b01e1998-a027-48d6-bff6-5fafeff7b80b" />


---

# 4. 🌐 Apache Web Server

### Description

The Apache application uses the **Apache HTTP Server** to serve a static HTML page.

The HTML page contains a simple **Hello World** message and is served directly from the Apache Docker container.

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | Apache                |
| Docker Image   | `apache-hello`        |
| Container Name | `apache-container`    |
| Container Port | `80`                  |
| Host Port      | `8081`                |
| URL            | http://localhost:8081 |

### Build

```bash
cd Apache-app
docker build -t apache-hello .
```

### Run

```bash
docker run -d -p 8081:80 --name apache-container apache-hello
```

### 🌐 Result

Open **http://localhost:8081** in a browser.

### 📸 Screenshot

<img width="1917" height="937" alt="Screenshot 2026-09-03 212556" src="https://github.com/user-attachments/assets/de3f13e7-684c-45dc-9a97-2fac3922e0f7" />


---

# 5. ⚛️ React Application

### Description

The React application is a simple **Hello World application** created using React and Vite.

A **multi-stage Docker build** is used to build and serve the React application.

The first stage uses Node.js to install the dependencies and generate the production build. The generated files are then copied into an Nginx image, which serves the final React application.

### Docker Build Process

```text
React Source Code
       │
       ▼
Node.js Docker Image
       │
       ├── npm install
       │
       └── npm run build
       │
       ▼
React Production Build
       │
       ▼
Nginx Docker Image
       │
       ▼
Web Browser
```

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | React                 |
| Docker Image   | `react-hello`         |
| Container Name | `react-container`     |
| Container Port | `80`                  |
| Host Port      | `8082`                |
| URL            | http://localhost:8082 |

### Build

```bash
cd React-app
docker build -t react-hello .
```

### Run

```bash
docker run -d -p 8082:80 --name react-container react-hello
```

### 🌐 Result

Open **http://localhost:8082** in a browser.

### 📸 Screenshot

<img width="1917" height="961" alt="Screenshot 2026-09-03 213747" src="https://github.com/user-attachments/assets/70f55852-2f07-4ed8-9b25-28aa1d8ce5ac" />


---

# 6. 🔵 Nginx Application

### Description

The Nginx application uses the **Nginx web server** to serve a static HTML page.

The HTML page contains a simple **Hello World** message and is served from the Nginx Docker container.

### Docker Configuration

| Property       | Value                 |
| -------------- | --------------------- |
| Application    | Nginx                 |
| Docker Image   | `nginx-hello`         |
| Container Name | `nginx-container`     |
| Container Port | `80`                  |
| Host Port      | `8083`                |
| URL            | http://localhost:8083 |

### Build

```bash
cd nginx-app
docker build -t nginx-hello .
```

### Run

```bash
docker run -d -p 8083:80 --name nginx-container nginx-hello
```

### 🌐 Result

Open **http://localhost:8083** in a browser.

### 📸 Screenshot

<img width="1916" height="962" alt="Screenshot 2026-09-03 213922" src="https://github.com/user-attachments/assets/0f3bfb11-92f8-4908-b6d9-579ead040f87" />


---

# 🔌 Port Mapping

All six applications use different **host ports**, allowing them to run simultaneously.

| Application | Container Port | Host Port | URL                   |
| ----------- | -------------: | --------: | --------------------- |
| 🟢 Node.js  |         `3000` |    `3000` | http://localhost:3000 |
| 🐍 Python   |         `8000` |    `8000` | http://localhost:8000 |
| ☕ Java      |         `8080` |    `8080` | http://localhost:8080 |
| 🌐 Apache   |           `80` |    `8081` | http://localhost:8081 |
| ⚛️ React    |           `80` |    `8082` | http://localhost:8082 |
| 🔵 Nginx    |           `80` |    `8083` | http://localhost:8083 |

---

# 🐳 Docker Commands Used

## Build a Docker Image

```bash
docker build -t <image-name> .
```

## Run a Docker Container

```bash
docker run -d -p <host-port>:<container-port> <image-name>
```

## List Running Containers

```bash
docker ps
```

## List All Containers

```bash
docker ps -a
```

## List Docker Images

```bash
docker images
```

## View Container Logs

```bash
docker logs <container-name>
```

## Stop a Container

```bash
docker stop <container-name>
```

## Remove a Container

```bash
docker rm <container-name>
```

---

# ▶️ Running All Applications

The following commands can be used to run all six containers:

```bash
docker run -d -p 3000:3000 --name nodejs-container nodejs-hello

docker run -d -p 8000:8000 --name python-container python-hello

docker run -d -p 8080:8080 --name java-container java-hello

docker run -d -p 8081:80 --name apache-container apache-hello

docker run -d -p 8082:80 --name react-container react-hello

docker run -d -p 8083:80 --name nginx-container nginx-hello
```

Verify that all containers are running:

```bash
docker ps
```


# 🎯 Learning Outcomes

Through this assignment, I practiced:

* Creating Dockerfiles
* Building Docker images
* Running Docker containers
* Mapping container ports to host ports
* Running multiple containers simultaneously
* Containerizing Node.js applications
* Containerizing Python applications
* Containerizing Java applications
* Using Apache as a web server
* Using Nginx as a web server
* Containerizing React applications
* Using multi-stage Docker builds
* Verifying applications through a web browser
* Managing Docker containers and images

---

# ✅ Assignment Status

| Application | Dockerfile | Image Built | Container Running | Browser Verified |
| ----------- | :--------: | :---------: | :---------------: | :--------------: |
| Node.js     |      ✅     |      ✅      |         ✅         |         ✅        |
| Python      |      ✅     |      ✅      |         ✅         |         ✅        |
| Java        |      ✅     |      ✅      |         ✅         |         ✅        |
| Apache      |      ✅     |      ✅      |         ✅         |         ✅        |
| React       |      ✅     |      ✅      |         ✅         |         ✅        |
| Nginx       |      ✅     |      ✅      |         ✅         |         ✅        |

---

## 🏁 Conclusion

This project demonstrates the basic principles of **Docker containerization** by deploying six independent Hello World applications using different programming languages and web servers.

Each application is isolated within its own Docker container and can be accessed through a dedicated host port. The project also demonstrates a multi-stage Docker build for deploying a production React application using Nginx.
