# Updating a device

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

You can update a device [name](device-update.md#update-name) or [description](device-update.md#update-description).

To access a device, use its unique ID or name. For information on how to get the unique ID or name of a device, see [{#T}](device-list.md).

## Updating a device name {#update-name}

{% list tabs group=instructions %}

- Management console {#console}

   To update the name of a device:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the device name.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. Select **{{ ui-key.yacloud.iot.label_devices }}** in the left pane of the window.
   1. To the right of the device name, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Edit the **{{ ui-key.yacloud.common.name }}** field.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Update the device description:

  ```bash
  yc iot device update my-device --new-name test-device
  ```

  Result:
  ```text
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: test-device
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the name of a device created with {{ TF }}:
  
  1. Open the {{ TF }} configuration file and edit the `name` parameter value in the device description:

      Here is an example of a device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      For more information about `yandex_iot_core_device` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_device).
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

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check the updated device name using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device list --registry-id <registry_ID>
      ```

- API {#api}

  To update a device name, use the [update](../../api-ref/Device/update.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/Update](../../api-ref/grpc/Device/update.md) gRPC API call.

{% endlist %}

## Updating a device description {#update-description}

{% list tabs group=instructions %}

- Management console {#console}

   To update a device description:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the device description.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. Select **{{ ui-key.yacloud.iot.label_devices }}** in the left pane of the window.
   1. To the right of the device name, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Edit the **{{ ui-key.yacloud.common.description }}** field.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Update the device description:

  ```bash
  yc iot device update my-device --description "My first device."
  ```

  Result:
  
  ```bash
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  description: My first device.
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To update the name of a device created with {{ TF }}:
  
  1. Open the {{ TF }} configuration file and edit the `description` parameter value in the device description.

      Here is an example of a device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      For more information about `yandex_iot_core_device` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_device).
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

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check the updated device description using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device get <device_name>
      ```

- API {#api}

  To update a device description, use the [update](../../api-ref/Device/update.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/Update](../../api-ref/grpc/Device/update.md) gRPC API call.

{% endlist %}