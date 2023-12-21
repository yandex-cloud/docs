---
title: "Как получить информацию о приемнике логов {{ cloud-logging-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию о приемнике логов."
---

# Получить информацию о приемнике логов

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится приемник логов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-arrow-down.svg) **{{ ui-key.yacloud.logging.label_sinks }}**.
  1. Выберите приемник.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о приемнике.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы узнать имя или идентификатор приемника логов, [получите](list-sink.md) список приемников в каталоге.

  Чтобы получить информацию о приемнике логов, выполните команду:

  ```bash
  yc logging sink get <имя_приемника>
  ```

  Результат:

  ```bash
  id: e23e73lehbfv********
  folder_id: b1gmit33ngp3********
  cloud_id: b1gia87mbaom********
  created_at: "2023-11-07T09:22:28.946Z"
  name: test-sink
  service_account_id: ajejeis235ma********
  s3:
    bucket: test-bucket
  ```

- API

  Чтобы получить подробную информацию о приемнике логов, воспользуйтесь методом REST API [get](../api-ref/Sink/get.md) для ресурса [Sink](../api-ref/Sink/index.md) или вызовом gRPC API [SinkService/Get](../api-ref/grpc/sink_service.md#Get).

{% endlist %}