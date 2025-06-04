---
title: Getting information about a {{ cloud-logging-full-name }} sink
description: Follow this guide to get information about a log sink.
---

# Getting information about a log sink

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder with the log sink.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-arrow-down.svg) **{{ ui-key.yacloud.logging.label_sinks }}**.
  1. Select the log sink.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the log sink details.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To find out the ID or name of a log sink, [get](list-sink.md) a list of sinks in the folder.

  To get information about a log sink, run this command:

  ```bash
  yc logging sink get <sink_name>
  ```

  Result:

  ```text
  id: e23e73lehbfv********
  folder_id: b1gmit33ngp3********
  cloud_id: b1gia87mbaom********
  created_at: "2023-11-07T09:22:28.946Z"
  name: test-sink
  service_account_id: ajejeis235ma********
  s3:
    bucket: test-bucket
  ```

- API {#api}

  To get log sink details, use the [get](../api-ref/Sink/get.md) REST API method for the [Sink](../api-ref/Sink/index.md) resource or the [SinkService/Get](../api-ref/grpc/Sink/get.md) gRPC API call.

{% endlist %}