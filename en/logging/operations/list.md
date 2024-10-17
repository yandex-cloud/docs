---
title: How to get a list of log groups in {{ cloud-logging-full-name }}
description: Follow this guide to get a list of log groups.
---

# Getting a list of log groups

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of log groups.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of log groups in the folder, run the command:

    ```bash
    yc logging group list
    ```

    Result:

    ```text
    +----------------------+---------+----------------------+--------+
    |          ID          |  NAME   |      FOLDER ID       | STATUS |
    +----------------------+---------+----------------------+--------+
    | af36gk8qv2********** | default | aoek6qrs8t********** | ACTIVE |
    +----------------------+---------+----------------------+--------+
    ```

- API {#api}

  To get a list of log groups, use the [list](../api-ref/LogGroup/list.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/List](../api-ref/grpc/LogGroup/list.md) gRPC API call.

  **Request example**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

  Run the following query:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d '{"folder_id": "<folder_ID>"}' \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.List
  ```

  Result:

  ```bash
  {
    "groups": [
      {
        "id": "e23u2vn449av********",
        "folderId": "b1g3f9i71bpm********",
        "cloudId": "b1gvlrnlei4l********",
        "createdAt": "2023-02-09T07:49:15.857Z",
        "name": "default",
        "description": "Auto-created default group",
        "status": "ACTIVE",
        "retentionPeriod": "259200s"
      }
    ]
  }
  ```

{% endlist %}