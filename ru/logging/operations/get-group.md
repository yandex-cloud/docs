---
title: "Как получить информацию о лог-группе {{ cloud-logging-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию о лог-группе."
---

# Получить информацию о лог-группе

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.logging.label_groups }}**.
  1. Выберите лог-группу.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о лог-группе.

- CLI

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
  data_stream: /ru-central1/b1gia87mbaom********/etnu60k6l8ft********/sample-stream
  ```

- API

  Чтобы получить подробную информацию о лог-группе, воспользуйтесь методом REST API [get](../api-ref/LogGroup/get.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Get](../api-ref/grpc/log_group_service.md#Get).

{% endlist %}