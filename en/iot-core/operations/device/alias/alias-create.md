# Creating an alias in {{ iot-name }}

Aliases are linked to specific devices. To create an alias, you need to [find the device ID or name](../device-list.md).

{% include [monitoring-topic](../../../../_includes/iot-core/monitoring-topic.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   To create an alias:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create an alias.
   1. [Go](../../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) to the right of the device name and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Add an alias:
      1. Click **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Fill out the fields: enter an alias, e.g., `events`, and the topic type after `$devices/<device_ID>`, e.g., `events`.<br/>You will be able to use the `events` alias instead of the `$devices/<device_ID>/events` topic.
      1. Repeat these steps for each alias you add.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Create an alias: 
    
    ```bash
    yc iot device add-topic-aliases arenak5ciqss********
      --topic-aliases commands='$devices/arenak5ciqss********/commands'
    ```

	  Result:
	  
    ```bash
    id: arenak5ciqss********
    registry_id: arenou2oj4ct********
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    topic_aliases:
      commands: $devices/arenak5ciqss********/commands
    ``` 

    You can also add an alias when [creating a device](../device-create.md). To do this, instead of a unique ID, specify the `{id}` in the device topic, since the unique ID is not known yet:
    
    ```bash
    yc iot device create
      --registry-name <registry_name>
      --name <device_name>
      --topic-aliases <alias_name>='$devices/{id}/<events,_state,_commands_or_config>'
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To add an alias to a device created using{{ TF }}:

  1. In the configuration file, describe the resources you want to create:

     * `yandex_iot_core_device`: Device properties:
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

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iot_core_device).
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

      You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.
  1. Apply the changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify device aliases in the [management console]({{ link-console-main }}) or using the following [CLI](../../../../cli/quickstart.md) command:

      ```bash
      yc iot device get <device_name>
      ```

- API {#api}

  To create an alias, use the [create](../../../api-ref/Device/create.md) REST API method for the [Device](../../../api-ref/Device/index.md) resource or the [DeviceService/Create](../../../api-ref/grpc/Device/create.md) gRPC API call.

{% endlist %}