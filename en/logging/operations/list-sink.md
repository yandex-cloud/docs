---
title: How to get a list of sinks in {{ cloud-logging-full-name }}
description: Follow this guide to get a list of sinks.
---

# Getting a list of sinks

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of sinks.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-arrow-down.svg) **{{ ui-key.yacloud.logging.label_sinks }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of sinks in the folder, run this command:

   ```bash
   yc logging sink list
   ```

   Result:

   ```text
   +----------------------+-----------+----------------------+----------------------+------------------+
   |          ID          |   NAME    |      FOLDER ID       |  SERVICE ACCOUNT ID  |       SINK       |
   +----------------------+-----------+----------------------+----------------------+------------------+
   | e23e73lehbfv******** | test-sink | b1gmit33ngp3******** | ajejeis235ma******** | S3: test-bucket/ |
   +----------------------+-----------+----------------------+----------------------+------------------+
   ```

- API {#api}

   To get a list of sinks, use the [list](../api-ref/Sink/list.md) REST API method for the [Sink](../api-ref/Sink/index.md) resource or the [SinkService/List](../api-ref/grpc/Sink/list.md) gRPC API call.

{% endlist %}