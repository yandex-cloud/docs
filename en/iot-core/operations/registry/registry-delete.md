---
title: "How to delete a registry"
description: "Follow this guide to delete a registry."
---

# Deleting a registry

{% note warning %}

You can only delete an empty registry. Make sure to [delete devices from the registry](../device/device-delete.md) before deleting the registry itself.

{% endnote %}

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information on retrieving the unique registry ID or name, see [{#T}](registry-list.md).

{% list tabs %}

- Management console

   To delete a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. To the right of the name of the registry to delete, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete the registry:

      ```
      yc iot registry delete my-registry
      ```

   1. Make sure the registry was deleted:

      ```
      yc iot registry list
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

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To delete a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the registry description.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_registry).
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

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry list
      ```

- API

   To delete a registry, use the [delete](../../api-ref/Registry/delete.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Delete](../../api-ref/grpc/registry_service.md#Delete) gRPC API call.

{% endlist %}
