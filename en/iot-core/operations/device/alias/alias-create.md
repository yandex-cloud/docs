# Creating an alias in {{ iot-name }}

Aliases are linked to specific devices. To create an alias, you need to [find the device ID or name](../device-list.md).

{% include [monitoring-topic](../../../../_includes/iot-core/monitoring-topic.md) %}

{% list tabs %}

- Management console

   To create an alias:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create an alias.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. Click ![image](../../../../_assets/horizontal-ellipsis.svg) to the right of the name of the device you need and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Add an alias:
      1. Click **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Complete the fields: enter an alias (e.g., `events`) and topic type after `$devices/<deviceID>` (e.g., `events`).<br/>You can use the `events` alias to replace `$devices/<deviceID>/events`.
      1. Repeat the steps for each alias you add.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Create an alias:

   ```
   yc iot device add-topic-aliases arenak5ciqss********
     --topic-aliases commands='$devices/arenak5ciqss********/commands'
   ```

   Result:

   ```
   id: arenak5ciqss********
   registry_id: arenou2oj4ct********
   created_at: "2019-09-16T12:32:48.911Z"
   name: second
   topic_aliases:
     commands: $devices/arenak5ciqss********/commands
   ```

   You can also add an alias when [creating a device](../device-create.md). To do this, instead of a unique ID, specify the `{id}` in the device topic, since the unique ID is not yet known:

   ```
   yc iot device create
     --registry-name <registry_name>
     --name <device_name>
     --topic-aliases <alias_name>='$devices/{id}/<events,_state,_commands_or_config>'
   ```

- {{ TF }}

   {% include [terraform-definition](../../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../../_includes/terraform-install.md) %}

   To add an alias to a device created using {{ TF }}:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `yandex_iot_core_device`: Device parameters:
         * `registry_id`: [ID of the registry](../../registry/registry-list.md#registry-list) where the device was created.
         * `name`: [Device name](../device-list.md#device-list).
         * `description`: Device description.
         * `aliases`: Topic aliases.

      Here is an example of the resource structure in the configuration file:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "<device_name>"
        description = "test device for terraform provider documentation"

        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify device aliases in the [management console]({{ link-console-main }}) or using the following [CLI](../../../../cli/quickstart.md) command:

      ```bash
      yc iot device get <device_name>
      ```

- API

   To create an alias, use the [create](../../../api-ref/Device/create.md) REST API method for the [Device](../../../api-ref/Device/index.md) resource or the [DeviceService/Create](../../../api-ref/grpc/device_service.md#Create) gRPC API call.

{% endlist %}