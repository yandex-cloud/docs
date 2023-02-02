# Deleting an alias

Aliases are linked to specific devices. To delete an alias, you need to [find the device ID or name](../device-list.md).

{% list tabs %}

- Management console

   To delete an alias:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the alias from.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device you need, click ![image](../../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. To the right of the alias to delete, click ![image](../../../../_assets/cross.svg).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Delete an alias:

   ```
   yc iot device remove-topic-aliases arenak5ciqss6pbas6js --topic-aliases commands
   ```

   Result:
   ```
   	id: arenak5ciqss6pbas6js
   registry_id: arenou2oj4ct42eq8g3n
   created_at: "2019-09-16T12:32:48.911Z"
   name: second
   ```

- {{ TF }}

   {% include [terraform-definition](../../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      You can verify device aliases in the [management console]({{ link-console-main }}) or using the following [CLI](../../../../cli/quickstart.md) command:

      ```bash
      yc iot device get <device_name>
      ```

{% endlist %}