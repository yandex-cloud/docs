---
title: How to get information about a connector
description: Follow this tutorial to get information about a {{ er-full-name }} connector.
---

# Getting information about a connector

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}** and select the bus. 
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** and select the connector in question.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show detailed information about the connector.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for viewing information about a [connector](../../../concepts/eventrouter/connector.md):

     ```bash
     yc serverless eventrouter connector get --help
     ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}

  1. Get detailed information about your connector by specifying its name or ID:

     ```bash
     yc serverless eventrouter connector get <connector_ID>
     ```

     Result:

     ```bash
     id: f66b9arad2ui********
     bus_id: f669a9niloj3********
     folder_id: b1gk6obg9bqf********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-23T14:01:46.256658Z"
     name: my-connector
     source:
       message_queue:
         queue_arn: yrn:yc:ymq:ru-central1:b1gk6obg9bqf********:my-queue
         service_account_id: ajeis9398lmk********
         visibility_timeout: 43200s
         batch_size: "10"
         polling_timeout: 10s
     status: RUNNING
     ```

- API {#api}

  To get detailed information about a [connector](../../../concepts/eventrouter/connector.md), use the [get](../../../../serverless-integrations/eventrouter/api-ref/Connector/get.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [ConnectorService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/get.md) gRPC API call.

{% endlist %}
