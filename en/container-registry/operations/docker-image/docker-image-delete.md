# Deleting a Docker image from a registry

To delete a [Docker image](../../concepts/docker-image.md) use its ID. You can find the ID by
[requesting a list of Docker images in the appropriate registry](docker-image-list.md#docker-image-list).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

1. Delete the Docker image:

    ```
    $ yc container image delete crp9vik7sgeco7emq743
    ```

1. Make sure the Docker image has been deleted:

    ```
    $ yc container image list
    +----+---------+------+------+-----------------+
    | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
    +----+---------+------+------+-----------------+
    +----+---------+------+------+-----------------+
    ```

**[!TAB API]**

To delete a Docker image, use the [delete](../../api-ref/Image/delete.md) method for the [Image](../../api-ref/Image/) resource.

---

