# Portfolio Performance Docker Image

This repository hosts the Dockerfile and accompanying resources necessary for constructing a Docker image tailored specifically for [Portfolio Performance](https://www.portfolio-performance.info/), a financial asset & investment tracking tool.

## Introduction

This Docker image, built upon the base of [jlesage/baseimage-gui](https://github.com/jlesage/docker-baseimage-gui), offers a seamless method for accessing Portfolio Performance on any system equipped with a web browser. With a comprehensive collection of essential dependencies and pre-configured settings, this image enables the smooth execution of the application, complete with a visually appealing graphical interface.

### Supported architectures

Following architecutes are supported by the core app:

| Architecture| Build arguments              |
|-------------|------------------------------|
| `x86_64`    | `--build-arg ARCH=x86_64`    |
| `aarch64`   | `--build-arg ARCH=aarch64`   |

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.
- Basic knowledge of Docker commands.

## Usage

### Pulling image from Docker Hub

To obtain the pre-built image effortlessly, simply execute the following commands, enabling you to pull it directly from [Docker Hub](https://hub.docker.com/r/meronx/portfolio-performance):

```Dockerfile
# Pull latest image version
docker pull meronx/portfolio-performance:latest

# Run docker container with example compose.yaml
docker compose up -d
```

### Build image from repository

To construct an image from the source code, follow these straightforward commands:

```ssh
git clone https://github.com/meronx/portfolio-performance.git
cd portfolio-performance
```

```Dockerfile
docker buildx build . \
    --network host \
    --build-arg ARCH=x86_64 \
    --build-arg APP_VERSION=0.69.0 \
    --tag portfolio-performance:0.69.0
```
