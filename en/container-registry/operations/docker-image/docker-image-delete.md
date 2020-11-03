# Deleting a Docker image from a registry

{% note alert %}

Deleting a Docker image is a deferred action operation: when you delete a Docker image, its layers are physically removed **1 hour later**. Information about the total size of the registry is also updated 1 hour later.

{% endnote %}

{% list tabs %}

- Management console

  To delete a [Docker image](../../concepts/docker-image.md):
  1. Go to the repository where you want to remove the image:
      1. Open the **Container Registry** section in the folder.
      1. Open the appropriate registry.
      1. Open the repository.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the line of the Docker image to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  To delete a [Docker image](../../concepts/docker-image.md), use its ID. You can find the ID by [requesting a list of Docker images in the appropriate registry](docker-image-list.md#docker-image-list).

  1. Delete the Docker image:

      ```
      yc container image delete crp9vik7sgeco7emq743
      ```

  1. Make sure the Docker image has been deleted:

      ```
      yc container image list
      +----+---------+------+------+-----------------+
      | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
      +----+---------+------+------+-----------------+
      +----+---------+------+------+-----------------+
      ```

- API

  To delete a Docker image, use the [delete](../../api-ref/Image/delete.md) method for the [Image](../../api-ref/Image/) resource.

{% endlist %}