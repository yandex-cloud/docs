---
title: How to delete a {{ iot-full-name }} registry
description: Follow this guide to delete a {{ iot-short-name }} registry.
---

# Deleting a registry

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

{% note warning %}

You can only delete an empty registry. Make sure to [delete devices from the registry](../device/device-delete.md) before deleting the registry itself.

{% endnote %}

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information on how to get the unique ID or name of a registry, see [{#T}](registry-list.md).

{% list tabs group=instructions %}

- Management console {#console}

   To delete a registry:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a registry.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. To the right of the name of the registry to delete, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a registry:

      ```bash
      yc iot registry delete my-registry
      ```

  1. Make sure the registry has been deleted:

      ```bash
      yc iot registry list
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

  To delete a registry created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section with the registry description.

      Here is an example of a registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about `yandex_iot_core_registry` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
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

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry list
      ```

- API {#api}

  To delete a registry, use the [delete](../../api-ref/Registry/delete.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Delete](../../api-ref/grpc/Registry/delete.md) gRPC API call.

{% endlist %}
