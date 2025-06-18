---
title: Creating a Docker image
description: This guide describes how to create and build a Docker image based on a Dockerfile in {{ container-registry-name }}.
---

# Creating a Docker image

This guide describes how to create and build a [Docker image](../../concepts/docker-image.md) based on a Dockerfile.

To work with Docker images, [install and configure](../configure-docker.md) Docker.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file named Dockerfile on your device and add the below lines to it:

     ```dockerfile
     FROM ubuntu:latest
     CMD echo "Hi, I'm inside"
     ```

     The described Docker image is based on Ubuntu and will execute one simple command.

  1. Build the Docker image. For `<registry_ID>`, use the `ID` you got when [creating the registry](../registry/registry-create.md).

     ```bash
     docker build . \
       -t {{ registry }}/<registry_ID>/ubuntu:hello
     ```

     The `-t` flag assigns a URL to the Docker image in this format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`. You can build Docker images without any tag. In this case, the Docker CLI will provide the default label: `latest`.

     The Docker image name and tag are part of the [repository](../../concepts/repository.md) name, which is a [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier), and must follow a specific format. For more information, see the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

{% endlist %}

Once these commands are executed, a Docker image will be created in your repository with the `hello` tag and the full address of the repository, which includes:
* {{ container-registry-name }} address: `{{ registry }}`.
* Your registry ID: `<registry_ID>`.
* Name of your repository: `ubuntu`.