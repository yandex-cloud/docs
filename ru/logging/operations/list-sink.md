---
title: Как получить список приемников логов {{ cloud-logging-full-name }}
description: Следуя данной инструкции, вы сможете получить список приемников логов.
---

# Получить список приемников логов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список приемников логов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-arrow-down.svg) **{{ ui-key.yacloud.logging.label_sinks }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список приемников логов в каталоге, выполните команду:

  ```bash
  yc logging sink list
  ```

  Результат:

  ```text
  +----------------------+-----------+----------------------+----------------------+------------------+
  |          ID          |   NAME    |      FOLDER ID       |  SERVICE ACCOUNT ID  |       SINK       |
  +----------------------+-----------+----------------------+----------------------+------------------+
  | e23e73lehbfv******** | test-sink | b1gmit33ngp3******** | ajejeis235ma******** | S3: test-bucket/ |
  +----------------------+-----------+----------------------+----------------------+------------------+
  ```

- API {#api}

  Чтобы получить список приемников логов, воспользуйтесь методом REST API [list](../api-ref/Sink/list.md) для ресурса [Sink](../api-ref/Sink/index.md) или вызовом gRPC API [SinkService/List](../api-ref/grpc/sink_service.md#List).

{% endlist %}