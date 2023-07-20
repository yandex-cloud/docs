---
title: "How to delete a broker in {{ iot-full-name }}"
description: "In this tutorial, you will learn how to delete a broker in {{ iot-full-name }}."
---

# Deleting a broker

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

To access a [broker](../../concepts/index.md#broker), use its unique ID or name. For information on retrieving the unique broker ID or name, see [{#T}](broker-list.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete the broker from.
   1. Select **{{ iot-short-name }}**.
   1. To the right of the name of the broker you want to delete, click the ![image](../../../_assets/horizontal-ellipsis.svg) icon and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

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

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../../cli/quickstart.md) command below:

      ```bash
      yc iot broker list
      ```

- API

   To delete a broker, use the [delete](../../broker/api-ref/Broker/delete.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Delete](../../broker/api-ref/grpc/broker_service.md#Delete) gRPC API call.

{% endlist %}
