---
title: How to create a connector for {{ yds-name }}
description: Follow this guide to create a connector for {{ yds-full-name }}.
---

# Creating a connector for {{ yds-name }}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
  1. In the **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** field, select `{{ yds-full-name }}`.
  1. Under **{{ yds-name }} settings**:

      * Select the [data stream](../../../../data-streams/concepts/glossary.md#stream-concepts) and [dedicated data consumer](../../../../data-streams/concepts/glossary.md#consumers).
      * Select a [service account](../../../../iam/concepts/users/service-accounts.md) that has read permissions for the data stream.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [connector](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create data-stream --help
      ```

  1. Create a connector for {{ yds-name }}:

      ```bash
      yc serverless eventrouter connector create data-stream \
        --bus-id <bus_ID> \
        --database <DB_path>
        --stream-name <stream_name>
        --consumer <consumer_name>
        --service-account-id <service_account_ID> \
        --name <connector_name> \
        --description "<connector_description>" \
        --labels <label_list> \
        --deletion-protection
      ```

      Where:

      * `--bus-id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `--database`: [Path](../../../../ydb/operations/connection.md#endpoint-and-path) to the {{ ydb-full-name }} [database](../../../../ydb/concepts/resources.md#database) specified in the [data stream](../../../../data-streams/concepts/glossary.md#stream-concepts) settings, e.g., `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********`.
      * `--stream-name`: Stream name.
      * `--consumer`: Name of the [dedicated data consumer](../../../../data-streams/concepts/glossary.md#consumers).
      * `--service-account-id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) that has read permissions for the data stream.
      * `--name`: Connector name. Follow these naming requirements:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description`: Connector description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

      * `--deletion-protection`: Connector deletion protection. By default, protection is disabled. You cannot delete a connector with this option enabled. To disable deletion protection, specify `--no-deletion-protection`. This is an optional parameter.

      Result:

      ```text
      id: f66g6jcnc5no********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-21T10:53:25.994124Z"
      name: yds-via-cli
      description: created via cli
      labels:
        interface: yccli
        owner: admin
      source:
        data_stream:
          database: /{{ region-id }}/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To create a [connector](../../../concepts/eventrouter/connector.md) for {{ yds-name }}:

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
          database           = "<DB_path>"
          stream_name        = "<stream_name>"
          consumer           = "<consumer_name>"
          service_account_id = "<service_account_ID>"
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
      * `database`: [Path](../../../../ydb/operations/connection.md#endpoint-and-path) to the {{ ydb-full-name }} [database](../../../../ydb/concepts/resources.md#database) specified in the [data stream](../../../../data-streams/concepts/glossary.md#stream-concepts) settings, e.g., `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********`.
      * `stream_name`: Stream name.
      * `consumer`: Name of the [dedicated data consumer](../../../../data-streams/concepts/glossary.md#consumers).
      * `service_account_id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) that has read permissions for the data stream.

      For more information about the `yandex_serverless_eventrouter_connector` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  To create a [connector](../../../concepts/eventrouter/connector.md) for {{ yds-name }}, use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) REST API method for the [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md) gRPC API call.

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}