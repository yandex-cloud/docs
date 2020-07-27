# Deleting a registry

{% note warning %}

You can only delete an empty registry. Don't forget to [delete devices from the registry](../device/device-delete.md) before performing the operation.

{% endnote %}

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information about how to get the unique registry ID or name, see [{#T}](registry-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the registry:

      ```
      $ yc iot registry delete my-registry
      ```

  1. Make sure the registry was deleted:

      ```
      $ yc iot registry list
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- Terraform

  {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

  Read more about Terraform in the [documentation](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Registries created using Terraform can be deleted:

   1. In the command line, go to the directory with the Terraform configuration file.

   2. Delete resources using the command:

      ```
      $ terraform destroy
      ```

      {% note alert %}

      Terraform deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

    3. Confirm the deletion of resources.

{% endlist %}

