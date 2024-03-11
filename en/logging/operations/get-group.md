---
title: "How to get information about a log group in {{ cloud-logging-full-name }}"
description: "Follow this guide to get information about a log group."
---

# Getting information about a log group

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.
   1. Select a log group.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the log group details.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To find out the ID or name of a log group, [get](list.md) a list of groups in the folder.

   To get information about a log group, run this command:

   ```bash
   yc logging group get <group_name>
   ```

   Result:

   ```bash
   id: e23fal6r2l9d********
   folder_id: b1gmit33ngp3********
   cloud_id: b1gia87mbaom********
   created_at: "2023-09-20T18:57:19.903Z"
   name: default
   description: log-group description
   labels:
   compute: instance-logging
   vpc: vpc-log
   status: ACTIVE
   retention_period: 3600s
   data_stream: /ru-central1/b1gia87mbaom********/etnu60k6l8ft********/sample-stream
   ```

- API {#api}

   To get detailed information about a log group, use the [get](../api-ref/LogGroup/get.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Get](../api-ref/grpc/log_group_service.md#Get) gRPC API call.

   To get log group statistics, use the [stats](../api-ref/LogGroup/stats.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Stats](../api-ref/grpc/log_group_service.md#Stats) gRPC API call.

   **Request examples**

   The examples below use the `grpcurl` utility. To use the examples, [authenticate](../../logging/api-ref/authentication.md) in the API and clone the [cloudapi](https://github.com/yandex-cloud/cloudapi) repository.

   To get detailed information about the log group, run the following request:

   ```bash
   grpcurl \
     -rpc-header "Authorization: Bearer $(yc iam create-token)" \
     -d '{"log_group_id": "<log_group_ID>"}' \
     -import-path ~/cloudapi/ \
     -import-path ~/cloudapi/third_party/googleapis/ \
     -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
   logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Get
   ```

   Result:

   ```bash
   {
     "id": "e23u2vn449av********",
     "folderId": "b1g3f9i71bpm********",
     "cloudId": "b1gvlrnlei4l********",
     "createdAt": "2023-11-15T12:48:46.321Z",
     "name": "default",
     "description": "Auto-created default group",
     "status": "ACTIVE",
     "retentionPeriod": "259200s"
   }
   ```

   To get log group statistics, run this request:

   ```bash
   grpcurl \
     -rpc-header "Authorization: Bearer $(yc iam create-token)" \
     -d '{"log_group_id": "<log_group_ID>"}' \
     -import-path ~/cloudapi/ \
     -import-path ~/cloudapi/third_party/googleapis/ \
     -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
   logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Stats
   ```

   Result:

   ```bash
   {
     "logGroupId": "e23u2vn449av********",
     "bytes": "73510",
     "records": "158"
   }
   ```

{% endlist %}