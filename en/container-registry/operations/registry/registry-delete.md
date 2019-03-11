# Deleting a registry

> [!NOTE]
> 
> You can only delete an empty registry. Don't forget to [delete Docker images from the registry](../docker-image/docker-image-delete.md) before performing the operation.

To access the [registry](../../concepts/registry.md), use its ID or name. For information on how to find the registry ID or name, see [Getting information about existing registries](registry-list.md).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

1. Delete the registry:

    ```
    $ yc container registry delete new-reg
    ..done
    ```

1. Make sure the registry has been deleted:

    ```
    $ yc container registry list
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```

**[!TAB API]**

To delete a registry, use the [delete](../../api-ref/Registry/delete.md) method for the [Registry](../../api-ref/Registry/) resource.

---

