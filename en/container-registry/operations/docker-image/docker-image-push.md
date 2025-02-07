---
title: Pushing a Docker image to a registry in {{ container-registry-name }}
description: This guide describes how to push a local Docker image to a {{ container-registry-name }}.
---

# Pushing a Docker image to a registry

These instructions describe how to push a local [Docker image](../../concepts/docker-image.md) to a registry.

{% note info %}

To push an image, you need to [configure](../configure-docker.md) Docker and [get authenticated](../authentication.md) in the registry.

{% endnote %}

To push a Docker image to the registry, you need the `container-registry.images.pusher`[role](../../security/index.md#container-registry-images-pusher) or higher.

{% list tabs group=instructions %}

- CLI {#cli}

  1. View the list of available [Docker images](../../concepts/docker-image.md):

     ```bash
     docker image list
     ```

     Result:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ registry }}/crpd50616s9a********/ubuntu       hello   50ff********  23 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

  1. (Optional) Assign a URL to the Docker image using the following format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

     ```bash
     docker tag ubuntu \
     {{ registry }}/<registry_ID>/ubuntu:hello
     ```

     {% note info %}

     You can only push Docker images to {{ container-registry-name }} if they have a URL in this format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`.

     {% endnote %}

  1. Push the required Docker image to the registry:

     ```bash
     docker push {{ registry }}/<registry_ID>/ubuntu:hello
     ```

  1. Make sure the image has been pushed to the registry by [getting a list of docker images in the registry](docker-image-list.md#docker-image-list).

{% endlist %}