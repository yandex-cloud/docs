---
title: Getting started with {{ cloud-registry-name }}
description: Use this guide to create your first registry in {{ cloud-registry-name }} and try your hand at managing Docker images.
---

# Getting started with {{ cloud-registry-name }}

Use this guide to create your first [registry](../concepts/registry.md) and try your hand at managing [Docker images](../concepts/artifacts/docker.md).

## Getting started {#before-you-begin}

To create a registry, you will need a folder in {{ yandex-cloud }}. If you do not have a folder yet, create one before creating a registry:

{% include [create-folder](../../_includes/create-folder.md) %}

## Creating a registry and pushing a Docker image {#create-and-push}

To work with {{ cloud-registry-name }} and Docker images:

1. [Install the {{ yandex-cloud }} CLI](../../cli/operations/install-cli.md) and [configure](../operations/docker/installation.md) Docker.
1. [Create a registry](../operations/registry/create.md) in {{ cloud-registry-name }}.
1. [Get authenticated](../operations/docker/authentication.md) in {{ cloud-registry-name }}.
1. Pull a Docker image from the [Docker Hub](https://hub.docker.com) repository:

   ```bash
   docker pull ubuntu
   ```

1. Assign the pulled Docker image a tag in this format: `{{ cloud-registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

   ```bash
   docker tag ubuntu \
   {{ cloud-registry }}/<registry_ID>/ubuntu:hello
   ```

1. Push the Docker image to the {{ cloud-registry-name }} repository:

   ```bash
   docker push \
   {{ cloud-registry }}/<registry_ID>/ubuntu:hello
   ```

1. Run the Docker image:

   ```bash
   docker run \
   {{ cloud-registry }}/<registry_ID>/ubuntu:hello
   ```

#### Useful links {#see-also}

[Supported artifact types](../concepts/artifacts/index.md)
