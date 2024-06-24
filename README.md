# Portfolio Performance Docker Image

This repository contains the Dockerfile and resources for building a Docker image for [Portfolio Performance](https://www.portfolio-performance.info/), a financial asset & investment tracking tool.

## Introduction

This Docker image is based on the image [jlesage/baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) and provides an easy way to access Portfolio Performance on any system with a web browser. The image includes all necessary dependencies and configurations to run the application with a graphical interface.

### Supported architectures

Following architecutes are supported by the main app:

| Architecture| Build arguments              |
|-------------|------------------------------|
| `x86_64`    | `--build-arg ARCH=x86_64`    |
| `aarch64`   | `--build-arg ARCH=aarch64`   |

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.
- Basic knowledge of Docker commands.

## Usage

### Pulling image from Docker Hub

You can pull the pre-built image from Docker Hub using the following commands:

```Dockerfile
# Pull latest image version
docker pull meronx/portfolio-performance:latest

# Run docker container with example compose.yaml
docker compose up -d
```

### Build image from repository

You can built an image from source code using following commands:

```ssh
git clone https://github.com/meronx/portfolio-performance.git
cd portfolio-performance
```

```Dockerfile
docker buildx build --network host --build-arg ARCH=x86_64 --build-arg APP_VERSION=0.69.0 -t portfolio-performance:0.69.0 .
```