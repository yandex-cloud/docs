---
title: How to edit a connector
description: Follow this guide to edit a connector.
---

# Editing a connector

You can update a [connector](../../../concepts/eventrouter/connector.md) name, description, and labels, as well as enable or disable deletion protection. You cannot change a connector data source type and parameters.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to edit a connector.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the line with the connector you need, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the connector's advanced settings.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating connector parameters:

      ```bash
      yc serverless eventrouter connector update --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. In the command, specify the parameters to update, such as the connector name:

      ```bash
      yc serverless eventrouter connector update \
        --name <connector_name> \
        --new-name <new_connector_name>
      ```

      Result:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      description: consumer-one
      labels:
        owner: admin
        version: beta
      source:
        data_stream:
          database: /{{ region-id }}/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: STOPPED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To edit a connector:

  1. Open the {{ TF }} configuration file and edit the part with the `yandex_serverless_eventrouter_connector` resource description.

      Example of a connector description in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<bus_ID>"
        name                = "<connector_name>"
        description         = "<connector_description>"
        deletion_protection = <true|false>

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
        ...
      }
      ```

      For more information about the `yandex_serverless_eventrouter_connector` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  To edit a connector, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Connector/update.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [Connector/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/update.md) gRPC API call.

{% endlist %}