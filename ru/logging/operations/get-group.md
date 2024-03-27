---
title: "Как получить информацию о лог-группе {{ cloud-logging-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию о лог-группе."
---

# Получить информацию о лог-группе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.
  1. Выберите лог-группу.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о лог-группе.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы узнать имя или идентификатор лог-группы, [получите](list.md) список групп в каталоге.

  Чтобы получить информацию о лог-группе, выполните команду:

  ```bash
  yc logging group get <имя_группы>
  ```

  Результат:

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
  data_stream: /{{ region-id }}/b1gia87mbaom********/etnu60k6l8ft********/sample-stream
  ```

- API {#api}

  Чтобы получить подробную информацию о лог-группе, воспользуйтесь методом REST API [get](../api-ref/LogGroup/get.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Get](../api-ref/grpc/log_group_service.md#Get).

  Чтобы получить статистику лог-группы, воспользуйтесь методом REST API [stats](../api-ref/LogGroup/stats.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Stats](../api-ref/grpc/log_group_service.md#Stats).

  **Примеры запросов**

  Примеры использования написаны с помощью утилиты `grpcurl`. Чтобы воспользоваться ими, [аутентифицируйтесь](../../logging/api-ref/authentication.md) в API и клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi).

  Чтобы получить подробную информацию о лог-группе, выполните запрос:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d '{"log_group_id": "<идентификатор_лог-группы>"}' \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Get
  ```

  Результат:

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

  Чтобы получить статистику лог-группы, выполните запрос:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d '{"log_group_id": "<идентификатор_лог-группы>"}' \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Stats
  ```

  Результат:

  ```bash
  {
    "logGroupId": "e23u2vn449av********",
    "bytes": "73510",
    "records": "158"
  }
  ```

{% endlist %}