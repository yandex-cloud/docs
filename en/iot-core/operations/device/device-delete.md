# Deleting a device

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information about how to get the unique device ID or name, see [{#T}](device-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the device:

      ```
      $ yc iot device delete my-device
      ```

  1. Make sure the device was deleted:

      ```
      $ yc iot device list --registry-name my-registry
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- Terraform

  {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

  Read more about Terraform in the [documentation](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Devices created using Terraform can be deleted:

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

