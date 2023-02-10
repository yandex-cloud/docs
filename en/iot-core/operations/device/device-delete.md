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

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a device created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the device description.

      Example device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry ID>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...  
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command below:

      ```bash
      yc iot device list --registry-id <registry ID>
      ```

- API

   You can delete a device using the API [delete](../../api-ref/Device/delete.md) method.

{% endlist %}