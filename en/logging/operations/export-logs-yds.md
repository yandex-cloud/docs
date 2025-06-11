---
title: How to export logs from {{ cloud-logging-name }} to {{ yds-name }}
description: In this guide, you will learn how to export logs from {{ cloud-logging-name }} to {{ yds-name }}.
---

# Exporting logs to {{ yds-name }}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the log group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Next to the log group, click ![image](../../_assets/console-icons/ellipsis.svg).
    1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
    1. In the **{{ ui-key.yacloud.logging.label_stream }}** field, select an existing [data stream](../../data-streams/concepts/glossary.md#stream-concepts) or [create](../../data-streams/operations/manage-streams.md#create-data-stream) a new one.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
    To export logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts), run this command:

    ```bash
    yc logging group update \
      --name=<log_group_name> \
      --data-stream=<stream_ID>
    ```

    Where:
    * `--name`: Log group name.
    * `--data-stream`: Data stream ID in [{{ yds-full-name }}](../../data-streams/index.yaml) consisting of the [availability zone](../../overview/concepts/geo-scope.md), [cloud ID](../../resource-manager/operations/cloud/get-id.md), [database](../../ydb/concepts/resources.md#database) ID, and [data stream](../../data-streams/concepts/glossary.md#stream-concepts) name.

    {% include [stream-name-example](../../_includes/data-streams/stream-name-example.md) %}

- API {#api}

    To export logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts), use the [update](../api-ref/LogGroup/update.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Update](../api-ref/grpc/LogGroup/update.md) gRPC API call.

{% endlist %}

The specified data stream will automatically receive the records added to your log group.
