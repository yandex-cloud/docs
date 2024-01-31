# Deleting an alias

Aliases are linked to specific devices. To delete an alias, you need to [find the device ID or name](../device-list.md).

{% list tabs group=instructions %}

- Management console {#console}

   To delete an alias:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the alias from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. To the right of the name of the device you need, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}** from the drop-down list.
   1. To the right of the alias to delete, click ![image](../../../../_assets/console-icons/xmark.svg).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Delete an alias:

   ```
   yc iot device remove-topic-aliases arenak5ciqss******** --topic-aliases commands
   ```

   Result:
   ```
   id: arenak5ciqss********
   registry_id: arenou2oj4ct********
   created_at: "2019-09-16T12:32:48.911Z"
   name: second
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../../_includes/terraform-install.md) %}

   To delete an alias created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the value of the alias in the `aliases` block, in the fragment with the device description. To remove all aliases, delete the entire `aliases` block.

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

{% endlist %}