---
title: "How to delete a Docker image from a {{ container-registry-full-name }} registry"
description: "In this tutorial, you will learn how to delete a Docker image from a {{ container-registry-full-name }} registry."
---

# Deleting a Docker image from a registry

{% note alert %}

Deleting a [Docker image](../../concepts/docker-image.md) is a deferred action operation: when you delete a Docker image, its layers are physically removed **1 hour later**. Information about the total size of the registry is also updated 1 hour later.

{% endnote %}

{% list tabs %}

- Management console

  To delete a Docker image:
  1. Go to the repository where you want to remove the image:
     1. Go to the [folder page]({{ link-console-main }}) and select **{{ container-registry-name }}**.
     1. Open the appropriate registry.
     1. Open the repository.
  1. Click the ![image](../../../_assets/horizontal-ellipsis.svg) icon next to the Docker image to delete.
  1. In the resulting menu, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  To delete a Docker image, use the image ID. You can retrieve the ID by [requesting a list of Docker images in the desired registry](docker-image-list.md#docker-image-list).
  1. Delete the Docker image:

     ```bash
     yc container image delete crp9vik7sgeco7emq743
     ```

  1. Make sure the Docker image has been deleted:

     ```bash
     yc container image list
     ```

     Command result:

     ```bash
     +----+---------+------+------+-----------------+
     | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
     +----+---------+------+------+-----------------+
     +----+---------+------+------+-----------------+
     ```

- API

  To delete a Docker image, use the [delete](../../api-ref/Image/delete.md) method for the [Image](../../api-ref/Image/) resource.

{% endlist %}