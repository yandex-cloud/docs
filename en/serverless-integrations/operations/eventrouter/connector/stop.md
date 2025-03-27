---
title: How to stop a connector
description: Follow this tutorial to stop a connector.
---

# Stopping a connector

When a [connector](../../../concepts/eventrouter/connector.md) is stopped, it no longer sends messages to the [bus](../../../concepts/eventrouter/bus.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to stop a connector.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select a bus.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the line with the appropriate connector, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/stop.svg) **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to pause a connector:

      ```bash
      yc serverless eventrouter connector stop --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Stop the connector:

      ```bash
      yc serverless eventrouter connector stop <connector_name_or_ID>
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
      status: STOPPED
      ```

- API {#api}

  To stop a connector, use the [Stop](../../../../serverless-integrations/eventrouter/api-ref/Connector/stop.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [Connector/Stop](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/stop.md) gRPC API call.


{% endlist %}