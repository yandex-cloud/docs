# Deleting a registry

{% note info %}

You can only delete an empty registry. Don't forget to [delete Docker images from the registry](../docker-image/docker-image-delete.md) before performing the operation.

{% endnote %}

To access a [registry](../../concepts/registry.md), use its ID or name. For information on how to find the registry ID or name, see [Getting information about existing registries](registry-list.md).

{% list tabs %}

- Management console

  To delete a [registry](../../concepts/registry.md):
  1. Open the **Container Registry** section in the folder where you want to delete the registry.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the line of the registry to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

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

- API

  To delete a registry, use the [delete](../../api-ref/Registry/delete.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}