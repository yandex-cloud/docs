---
title: How to delete a bus
description: Follow this guide to delete a bus.
---

# Deleting a bus

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the [bus](../../../concepts/eventrouter/bus.md) row and select ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a [bus](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus delete --help
      ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. Delete a bus:

      ```bash
      yc serverless eventrouter bus delete <bus_name_or_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To delete a [bus](../../../concepts/eventrouter/bus.md):

  1. Open the {{ TF }} configuration file and delete the fragment with the `yandex_serverless_eventrouter_bus` resource description:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "<bus_name>"
        description         = "<description>"
        deletion_protection = <true|false>

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  To delete a [bus](../../../concepts/eventrouter/bus.md), use the [Delete](../../../../serverless-integrations/eventrouter/api-ref/Bus/delete.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Delete](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/delete.md) gRPC API call.

{% endlist %}