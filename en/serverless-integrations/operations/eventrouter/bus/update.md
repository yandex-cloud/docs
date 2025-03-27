---
title: How to update a bus
description: Follow this guide to update a bus.
---

# Updating a bus

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to update a [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the row with the [bus](../../../concepts/eventrouter/bus.md) you need and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the bus settings.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for editing [bus](../../../concepts/eventrouter/bus.md) parameters:

      ```bash
      yc serverless eventrouter bus update --help
      ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}
  1. In the command, specify the parameters to update, such as the bus name:

      ```bash
      yc serverless eventrouter bus update \
        --name <bus_name> \
        --new-name <new_bus_name>
      ```

      Result:

      ```text
      id: f66aevm4ithv********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-13T12:36:59.497985Z"
      name: my-bus-43
      description: this is my bus
      labels:
        owner: admin
      deletion_protection: true
      status: ACTIVE
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [bus](../../../concepts/eventrouter/bus.md):

  1. Open the {{ TF }} configuration file and edit the part with the `yandex_serverless_eventrouter_bus` resource description.

      Example of a bus description in a {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "my-bus"
        description         = "this is my bus"
        deletion_protection = true

        labels = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      ```

      For more information about the `yandex_serverless_eventrouter_bus` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  To update a [bus](../../../concepts/eventrouter/bus.md), use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md) gRPC API call.

{% endlist %}