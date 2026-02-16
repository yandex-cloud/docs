---
title: How to get a list of connectors
description: Follow this guide to view a list of available {{ er-full-name }} connectors.
---

# Getting a list of connectors

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of [connectors](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}** and select a bus.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**. The **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** page will display a list of connectors.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view a list of [connectors](../../../concepts/eventrouter/connector.md):

     ```bash
     yc serverless eventrouter connector list --help
     ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}

- API {#api}

  To view a list of [connectors](../../../concepts/eventrouter/connector.md), use the [list](../../../../serverless-integrations/eventrouter/api-ref/Connector/list.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [ConnectorService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/list.md) gRPC API call.

{% endlist %}
