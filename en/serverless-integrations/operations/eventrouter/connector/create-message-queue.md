---
title: How to create a connector for {{ message-queue-name }}
description: Follow this guide to create a connector for {{ message-queue-full-name }}.
---

# Creating a connector for {{ message-queue-name }}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** field, select `{{ message-queue-full-name }}`.
      1. Under **message settings{{ message-queue-name }}**:

          * Select a folder and a [message queue](../../../../message-queue/concepts/queue.md).
          * Select a [service account](../../../../iam/concepts/users/service-accounts.md) with permissions to read from the message queue.

      1. (Optional) Click ![image](../../../../_assets/console-icons/plus.svg) **Message grouping settings** and specify the following:

          * **Visibility timeout**: [Time](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout) period in hours during which messages are hidden from the queue after one of the recipients has accepted a message. Valid values ​​range from 0 to 12 hours. The default value is 0.
          * **Group size**: Maximum number of messages {{ er-name }} groups together before sending from the source to the [rule](../../../concepts/eventrouter/rule.md). Valid values ​​range from 0 to 12. The default value is 10.
          * **Poll timeout**: Maximum time in milliseconds during which {{ er-name }} is grouping messages before sending them from the source to the rule. The values may range from 0 to 20 seconds. The default value is 10 seconds.

              {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [connector](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create message-queue --help
      ```

  1. Create a connector for {{ message-queue-name }}:

      ```bash
      yc serverless eventrouter connector create message-queue \
        --bus-id <bus_ID> \
        --queue-arn <queue_ARN> \
        --service-account-id <service_account_ID> \
        --visibility-timeout <visibility_timeout> \
        --batch-size <group_size> \
        --polling-timeout <poll_timeout> \
        --name <connector_name> \
        --description "<connector_description>" \
        --labels <label_list> \
        --deletion-protection
      ```

      Where:

      * `--bus-id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `--queue-arn`: {{ message-queue-full-name }} [queue](../../../../message-queue/concepts/queue.md) ARN.
      * `--service-account-id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) with permissions to read from the message queue.
      * `--visibility-timeout`: [Time](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout) period during which messages are hidden from the queue after one of the recipients has accepted a message. Valid values ​​range from 0 to 12 hours. The default value is 0. This is an optional parameter.
      * `--batch-size`: Maximum number of messages {{ er-name }} groups together before sending from the source to the [rule](../../../concepts/eventrouter/rule.md). Valid values ​​range from 0 to 12. The default value is 10. This is an optional parameter.
      * `--polling-timeout`: Maximum time during which {{ er-name }} is grouping messages before sending them from the source to the rule. The values may range from 0 to 20 seconds. The default value is 10 seconds. This is an optional parameter.

          {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      * `--name`: Connector name. The naming requirements are as follows:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description`: Connector description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

      * `--deletion-protection`: Connector deletion protection. You cannot delete a connector with this option enabled. To disable deletion protection, specify `--no-deletion-protection`. This is an optional parameter.

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
        message_queue:
          queue_arn: yrn:yc:ymq:ru-central1:b1g681qpemb4********:my-queue
          service_account_id: ajelprpohp7r********
          visibility_timeout: 60s
          batch_size: "3"
          polling_timeout: 0.100s
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To create a [connector](../../../concepts/eventrouter/connector.md) for {{ message-queue-name }}:

  1. In the configuration file, define the parameters of the resources you want to create:

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

        ymq {
          queue_arn          = "<queue_ARN>"
          service_account_id = "<service_account_ID>"
          visibility_timeout = "1m"
          batch_size         = "3"
          polling_timeout    = "100ms"
        }
      }
      ```

      Where:

      * `bus_id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `name`: Connector name. The naming requirements are as follows:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `description`: Connector description. This is an optional parameter.
      * `deletion_protection`: Connector deletion protection, `true` or `false`. You cannot delete a connector with this option enabled. This is an optional parameter.
      * `labels`: List of labels. Provide labels in `<key> = "<value>"` format. This is an optional parameter.
      * `queue_arn`: [Queue](../../../../message-queue/concepts/queue.md) ARN of {{ message-queue-full-name }}.
      * `service-account-id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) with permissions to read from the message queue.
      * `visibility_timeout`: [Time](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout) period during which messages are hidden from the queue after one of the recipients has accepted a message. Valid values ​​range from 0 to 12 hours. The default value is 0. This is an optional parameter.
      * `batch_size`: Maximum number of messages {{ er-name }} groups together before sending from the source to the [rule](../../../concepts/eventrouter/rule.md). Valid values ​​range from 0 to 12. The default value is 10. This is an optional parameter.
      * `polling_timeout`: Maximum time during which {{ er-name }} is grouping messages before sending them from the source to the rule. The values may range from 0 to 20 seconds. The default value is 10 seconds. This is an optional parameter.

          {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      For more information about the `yandex_serverless_eventrouter_connector` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  To create a [connector](../../../concepts/eventrouter/connector.md) for {{ message-queue-name }}, use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) REST API method for the [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md) gRPC API call.

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}