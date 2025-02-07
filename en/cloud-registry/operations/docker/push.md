---
title: Pushing a Docker image to a registry in {{ cloud-registry-name }}
description: This guide describes how to push a local Docker image to a {{ cloud-registry-name }}.
---

# Pushing a Docker image to a registry in {{ cloud-registry-name }}

These instructions describe how to push a local [Docker image](../../concepts/docker-image.md) to a registry.

{% note info %}

To push an image, you need to [configure](installation.md) Docker and [get authenticated](authentication.md) in the registry.

{% endnote %}

To push a Docker image to the registry, you need the `cloud-registry.artifacts.pusher` [role](../../security/index.md#cloud-registry-artifacts-pusher) or higher.

{% list tabs group=instructions %}

- CLI {#cli}

  1. View the list of available [Docker images](../../concepts/docker-image.md):

     ```bash
     docker image list
     ```

     Result:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ cloud-registry }}/crpd50616s9a********/ubuntu       hello   50ff********  23 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

  1. (Optional) Assign a URL to the Docker image using the following format: `{{ cloud-registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

     ```bash
     docker tag ubuntu \
     {{ cloud-registry }}/<registry_ID>/ubuntu:hello
     ```

     {% note info %}

     You can only push Docker images to {{ cloud-registry-name }} if they have a URL in this format: `{{ cloud-registry }}/<registry_ID>/<Docker_image_name>:<tag>`.

     {% endnote %}

  1. Push the required Docker image to the registry:

     ```bash
     docker push {{ cloud-registry }}/<registry_ID>/ubuntu:hello
     ```

{% endlist %}