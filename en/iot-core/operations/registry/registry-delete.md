# Deleting a registry

{% note warning %}

You can only delete an empty registry. Don't forget to [delete devices from the registry](../device/device-delete.md) before performing the operation.

{% endnote %}

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information about how to get the unique registry ID or name, see [{#T}](registry-list.md).

{% list tabs %}

- Management console

   To delete a registry:
   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry from.
   1. Select **{{ iot-name }}**.
   1. To the right of the name of the registry to delete, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

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

  {% include [terraform-definition](../../../_includes/solutions/terraform-definition.md) %}

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
