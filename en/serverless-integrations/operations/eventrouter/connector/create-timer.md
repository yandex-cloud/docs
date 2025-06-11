---
title: How to create a timer in {{ er-name }}
description: Follow this guide to create a timer in {{ er-name }}.
---

# Creating a timer

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
  1. In the **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** field, select **Timer**.
  1. Under **Timer settings**, specify:

      * In the **Cron expression** field, a schedule for generating events, in [cron expression](../../../concepts/eventrouter/connector.md#cron-expression) format.
      * In the **Time zone** field, a time zone in [tz database](https://en.wikipedia.org/wiki/Tz_database) format. This is an optional parameter.
      * In the **Data** field, a message sent to the bus if the timer fires in the `payload` field. This is an optional parameter.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [connector](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create timer --help
      ```

  1. Create a [timer](../../../concepts/eventrouter/connector.md#timer):

      ```bash
      yc serverless eventrouter connector create timer \
        --bus-id <bus_ID> \
        --cron-expression <timer_schedule> \
        --time-zone <time_zone> \
        --payload <message> \
        --name <connector_name> \
        --description <connector_description> \
        --labels <label_list> \
        --deletion-protection
      ```

      Where:

      * `--bus-id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `--cron-expression`: Schedule for generating events, in [cron expression](../../../concepts/eventrouter/connector.md#cron-expression) format.
      * `--time-zone`: Time zone in [tz database](https://en.wikipedia.org/wiki/Tz_database) format. This is an optional parameter.
      * `--payload`: Message sent to the bus if the timer fires. This is an optional parameter.
      * `--name`: Connector name. Follow these naming requirements:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description`: Connector description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

      * `--deletion-protection`: Connector deletion protection. By default, protection is disabled. You cannot delete a connector with this option enabled. To disable deletion protection, specify `--no-deletion-protection`. This is an optional parameter.

      Result:

      ```text
      id: f66l8kgo20d8********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-21T09:04:33.248254Z"
      name: mq-via-cli
      description: created via cli
      labels:
        interface: yccli
        owner: admin
      source:
        timer:
          cron_expression: '*/5 * * ? * *'
          time_zone: Europe/Moscow
          payload: '{"message": "Hello, world!"}'
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To create a [timer](../../../concepts/eventrouter/connector.md#timer):

  1. In the configuration file, describe the resources you want to create:

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
        timer {
          cron_expression = "<schedule_for_generating_events>"
          timezone        = "<time_zone>"
          payload         = "<message>"
        }
      }
      ```

      Where:

      * `bus_id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `name`: Connector name. Follow these naming requirements:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `description`: Connector description. This is an optional parameter.
      * `deletion_protection`: Connector deletion protection, `true` or `false`. You cannot delete a connector with this option enabled. This is an optional parameter.
      * `labels`: List of labels. Provide labels in `<key> = "<value>"` format. This is an optional parameter.
      * `cron_expression`: Schedule for generating events, in [cron expression](../../../concepts/eventrouter/connector.md#cron-expression) format.
      * `timezone`: Time zone in [tz database](https://en.wikipedia.org/wiki/Tz_database) format. This is an optional parameter.
      * `payload`: Message sent to the bus if the timer fires. This is an optional parameter.

      For more information about the `yandex_serverless_eventrouter_connector` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  To create a [timer](../../../concepts/eventrouter/connector.md#timer), use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) REST API method for the [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md) gRPC API call.

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}
