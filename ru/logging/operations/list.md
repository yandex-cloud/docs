---
title: "Как получить список лог-групп {{ cloud-logging-full-name }}"
description: "Следуя данной инструкции, вы сможете получить список лог-групп."
---

# Получить список лог-групп

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список лог-групп.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список лог-групп в каталоге, выполните команду:

    ```bash
    yc logging group list
    ```

    Результат:

    ```text
    +----------------------+---------+----------------------+--------+
    |          ID          |  NAME   |      FOLDER ID       | STATUS |
    +----------------------+---------+----------------------+--------+
    | af36gk8qv2********** | default | aoek6qrs8t********** | ACTIVE |
    +----------------------+---------+----------------------+--------+
    ```

- API {#api}

  Чтобы получить список лог-групп, воспользуйтесь методом REST API [list](../api-ref/LogGroup/list.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/List](../api-ref/grpc/log_group_service.md#List).

  **Пример запроса**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

  Выполните запрос:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d '{"folder_id": "<идентификатор_каталога>"}' \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.List
  ```

  Результат:

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