# Deleting a device

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information on retrieving the unique device ID or name, see [{#T}](device-list.md).

{% list tabs %}

- Management console

   To delete a device:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the device from.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device to delete, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete the device:

      ```
      yc iot device delete my-device
      ```

   1. Make sure the device was deleted:

      ```
      yc iot device list --registry-name my-registry
      ```

      Result:
      ```
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Devices created using {{ TF }} can be deleted:

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   2. Delete resources using the command:
      ```
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   3. Confirm the deletion of resources.

{% endlist %}
