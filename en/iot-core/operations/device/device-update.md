# Updating a device

You can update the [name](device-update.md#update-name) or [description](device-update.md#update-description) of a device.

To access a device, use its unique ID or name. For information on retrieving the unique device ID or name, see [{#T}](device-list.md).

## Updating device names {#update-name}

{% list tabs %}

- Management console

   To update the name of a device:

   1. In the [management console]({{ link-console-main }}), select the folder to update the device name in.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Name** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Update a device description:

   ```
   yc iot device update my-device --new-name test-device
   ```

   Result:
   ```
   id: b9135goeh1uc1s2i07nm
   registry_id: b91ki3851hab9m0l68je
   created_at: "2019-05-28T16:08:30.938Z"
   name: test-device
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the name of a device created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the value of the `name` parameter in the fragment with the device description:

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

      You can verify the updated device name in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device list --registry-id <registry ID>
      ```

- API

   You can change the device name using the API [update](../../api-ref/Device/update.md) method.

{% endlist %}

## Updating device descriptions {#update-description}

{% list tabs %}

- Management console

   To update the description of a device:

   1. In the [management console]({{ link-console-main }}), select the folder to update the device description in.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Description** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Update a device description:

   ```
   yc iot device update my-device --description "My first device."
   ```

   Result:

   ```
   id: b9135goeh1uc1s2i07nm
   registry_id: b91ki3851hab9m0l68je
   created_at: "2019-05-28T16:08:30.938Z"
   name: my-device
   description: My first device.
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the name of a device created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the value of the `description` parameter in the fragment with the device description.

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

      You can verify the updated device description in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device get <device name>
      ```

- API

   You can update the device description using the API [update](../../api-ref/Device/update.md) method.

{% endlist %}