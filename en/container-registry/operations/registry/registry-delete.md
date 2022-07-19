# Deleting a registry

{% note info %}

You can only delete an empty registry. Don't forget to [delete Docker images from the registry](../docker-image/docker-image-delete.md) before performing the operation.

{% endnote %}

To access a [registry](../../concepts/registry.md), use its ID or name. For information on how to find the registry ID or name, see [Getting information about existing registries](registry-list.md).

{% list tabs %}

- Management console

   To delete a [registry](../../concepts/registry.md):
   1. Open **{{ container-registry-name }}** in the folder where you wish to delete a registry.
   1. Click ![image](../../../_assets/vertical-ellipsis.svg) next to the registry to delete.
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete the registry:

      ```bash
      yc container registry delete new-reg
      ```

      Result:

      ```bash
      done
      ```

   1. Make sure the registry has been deleted:

      ```bash
      yc container registry list
      ```

      Result:

      ```bash
       +----+------+-----------+
       | ID | NAME | FOLDER ID |
       +----+------+-----------+
       +----+------+-----------+
      ```

- API

   To delete the registry, use the [delete](../../api-ref/Registry/delete.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}