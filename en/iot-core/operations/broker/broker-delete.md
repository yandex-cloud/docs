---
title: How to delete a broker in {{ iot-full-name }}
description: In this tutorial, you will learn how to delete a broker in {{ iot-full-name }}.
---

# Deleting a broker

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To access a [broker](../../concepts/index.md#broker), use its unique ID or name. For information on retrieving the unique broker ID or name, see [{#T}](broker-list.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete the broker from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. To the right of the name of the broker you want to delete, click the ![image](../../../_assets/console-icons/ellipsis.svg) icon and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Delete a broker:

      ```
      yc iot broker delete my-broker
      ```

   1. Make sure the broker was deleted:

      ```
      yc iot broker list
      ```

      Result:
      ```
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To delete a broker created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the broker description.

      Example broker description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        }
      ...
      }
      ```

      For more information about the `yandex_iot_core_broker` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_broker).
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
      yc iot broker list
      ```

- API {#api}

   To delete a broker, use the [delete](../../broker/api-ref/Broker/delete.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Delete](../../broker/api-ref/grpc/Broker/delete.md) gRPC API call.

{% endlist %}
