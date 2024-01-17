---
title: "How to get information about a log group in {{ cloud-logging-full-name }}"
description: "Follow this guide to get information about a log group."
---

# Getting information about a log group

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.
   1. Select a log group.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the log group details.

- CLI

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

- API

   To get detailed information about a log group, use the [get](../api-ref/LogGroup/get.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/Get](../api-ref/grpc/log_group_service.md#Get) gRPC API call.

{% endlist %}