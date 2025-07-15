---
title: How to create a connector for the {{ er-name }} API
description: Follow this guide to create a connector for the {{ er-name }} API.
---

# Creating a connector for the {{ er-name }} API

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [connector](../../../concepts/eventrouter/connector.md).

  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.

  1. In the left-hand panel, select ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.

  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.

  1. In the left-hand menu, select ![broadcast-signal](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.

  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.

  1. In the **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** field, select `{{ ui-key.yc-eventrouter.dynamic-forms.event_service_name }}`.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a [connector](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create event-service --help
      ```

  1. Create a connector for the {{ er-name }} API:

      ```bash
      yc serverless eventrouter connector create event-service \
        --bus-id <bus_ID> \
        --name <connector_name> \
        --description <connector_description> \
        --labels <label_list> \
        --deletion-protection
      ```

      Where:

      * `--bus-id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `--name`: Connector name. Follow these naming requirements:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description`: Connector description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.
      * `--deletion-protection`: Connector deletion protection. By default, protection is disabled. You cannot delete a connector with this option enabled. To disable deletion protection, specify `--no-deletion-protection`. This is an optional parameter.

      Result:

      ```text
      id: f667savopsoe********
      bus_id: f66klk4lvvjf********
      folder_id: b1gt6g8ht345********
      cloud_id: b1gia87mbaom********
      created_at: "2025-06-18T16:44:03.849030Z"
      name: my-sample-connector
      description: my description
      labels:
        no: label
      source:
        event_service_source: {}
      deletion_protection: true
      status: RUNNING
      ```

- API {#api}

  To create a connector for the {{ er-name }} API, use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) REST API method for the [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [ConnectorService/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md) gRPC API call.

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}