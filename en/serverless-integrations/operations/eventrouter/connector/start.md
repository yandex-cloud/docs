---
title: How to run a connector
description: Follow this guide to run a connector.
---

# Running a connector

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to run a [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the line with the connector, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for running a [connector](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector start --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Run a connector:

      ```bash
      yc serverless eventrouter connector start <connector_name_or_ID>
      ```

      Result:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      ...
      status: RUNNING
      ```

- API {#api}

  To run a [connector](../../../concepts/eventrouter/connector.md), use the [Start](../../../../serverless-integrations/eventrouter/api-ref/Connector/start.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [Connector/Start](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/start.md) gRPC API call.

{% endlist %}