---
title: How to get a list of buses
description: Follow this guide to view a list of available {{ er-full-name }} buses.
---

# Getting a list of buses

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of [buses](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**. The **{{ ui-key.yacloud.serverless-event-router.label_buses }}** page will display a list of buses.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view a list of [buses](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus list --help
      ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}

- API {#api}

  To view the a list of [buses](../../../concepts/eventrouter/bus.md), use the [list](../../../../serverless-integrations/eventrouter/api-ref/Bus/list.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/list.md) gRPC API call.

{% endlist %}