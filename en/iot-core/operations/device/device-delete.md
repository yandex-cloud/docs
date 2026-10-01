# Deleting a device

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information on how to get the unique ID or name of a device, see [{#T}](device-list.md).

{% list tabs group=instructions %}

- Management console {#console}

   To delete a device:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a device.
   1. [Navigate]({{ link-console-main }}/link/iot-core) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}** and select the registry of interest.
   1. Navigate to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. To the right of the device name, click ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a device:

      ```bash
      yc iot device delete my-device
      ```

  1. Make sure the device has been deleted:

      ```bash
      yc iot device list --registry-name my-registry
	    ```

	  Result:
      
	  ```text
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a device created with {{ TF }}:
  
  1. Open the {{ TF }} configuration file and delete the section with the device description.

      Here is an example of a device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      For more on the properties of the `yandex_iot_core_device` resource, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_device).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device list --registry-id <registry_ID>
      ```

- API {#api}

  To delete a device, use the [delete](../../api-ref/Device/delete.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/Delete](../../api-ref/grpc/Device/delete.md) gRPC API call.

{% endlist %}
