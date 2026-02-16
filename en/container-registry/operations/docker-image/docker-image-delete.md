---
title: How to delete a Docker image from a {{ container-registry-full-name }} registry
description: In this tutorial, you will learn how to delete a Docker image from a {{ container-registry-full-name }} registry.
---

# Deleting a Docker image from a registry

{% note alert %}

Deleting a [Docker image](../../concepts/docker-image.md) is a deferred action operation: once you delete a Docker image, its layers get physically removed after some time, which depends on total volume of data. The registry total size info will be updated 1 hour after physical removal.

{% endnote %}

To delete a Docker image from the registry, you need the `container-registry.images.pusher` [role](../../security/index.md#container-registry-images-pusher) or higher.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a Docker image:
  1. Go to the repository to remove the image from:
     1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Open the appropriate registry.
     1. Open the repository.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the Docker image you want to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.cr.image.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  To delete a Docker image, use the image ID. You can retrieve the ID by [requesting a list of Docker images in the desired registry](docker-image-list.md#docker-image-list).
  1. Delete the Docker image:

     ```bash
     yc container image delete crp9vik7sgec********
     ```

  1. Make sure the Docker image has been deleted:

     ```bash
     yc container image list
     ```

     Result:

     ```bash
     +----+---------+------+------+-----------------+
     | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
     +----+---------+------+------+-----------------+
     +----+---------+------+------+-----------------+
     ```

- API {#api}

  To delete a Docker image, use the [delete](../../api-ref/Image/delete.md) method for the [Image](../../api-ref/Image/) resource.

{% endlist %}
