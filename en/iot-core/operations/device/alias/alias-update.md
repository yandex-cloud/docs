# Updating an alias

Aliases are linked to specific devices. To update an alias, you [need the device ID or name](../device-list.md).

{% list tabs group=instructions %}

- Management console {#console}

   To update an alias:

   1. In the [management console]({{ link-console-main }}), select a folder in which to update an alias.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) to the right of the name of the device you need and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. Update the values of the alias fields.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Update device aliases:

   {% note warning %}

   The existing set of `topic_aliases` is completely replaced by the provided set.

   {% endnote %}

   ```
   yc iot device update first --topic-aliases 'events=$devices/areqjd6un3af********/events,commands=$devices/areqjd6un3af********/commands'
   ```

   Result:
   ```
   id: areqjd6un3af********
   registry_id: arenou2oj4ct********
   created_at: "2019-09-16T10:41:06.489Z"
   name: first
   topic_aliases:
     commands: $devices/areqjd6un3af********/commands
     events: $devices/areqjd6un3af********/events
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../../_includes/terraform-install.md) %}

   To update an alias created with {{ TF }}:

   1. Open the {{ TF }} configuration file and update the value of the `alias` in the aliases block, in the fragment with the device description.

      Example device description in the {{ TF }} configuration:

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

- API {#api}

   To update an alias, use the [update](../../../api-ref/Device/update.md) REST API method for the [Device](../../../api-ref/Device/index.md) resource or the [DeviceService/Update](../../../api-ref/grpc/device_service.md#Update) gRPC API call.

{% endlist %}
