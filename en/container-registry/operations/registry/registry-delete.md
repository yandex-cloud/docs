# Deleting a registry

{% note info %}

You can only delete an empty [registry](../../concepts/registry.md). Don't forget to [delete Docker images from the registry](../docker-image/docker-image-delete.md) before performing the operation.

{% endnote %}

To access a registry, use its ID or name. For information about how to get the registry ID or name, see [{#T}](registry-list.md).

{% list tabs %}

- Management console

  To delete a registry:
  1. Open **{{ container-registry-name }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you wish to delete a registry.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) next to the registry to delete.
  1. In the resulting menu, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the registry:

     ```bash
     yc container registry delete new-reg
     ```

     Command result:

     ```text
     done
     ```

  1. Make sure the registry has been deleted:

     ```bash
     yc container registry list
     ```

     Command result:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

- API

  To delete the registry, use the [delete](../../api-ref/Registry/delete.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}