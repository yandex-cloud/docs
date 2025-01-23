---
title: Инструкция о том, как получить информацию о триггере в {{ api-gw-full-name }}
description: Из статьи вы узнаете, как получить подробную информацию о триггере в {{ api-gw-full-name }}.
---

# Получить информацию о триггере в {{ api-gw-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1sltg0kn8bt********
    folder_id: b1gc1t4cb638********
    created_at: "2024-07-17T08:54:17.022Z"
    name: timer-trigger
    rule:
      timer:
        cron_expression: '* * ? * * *'
        gateway_websocket_broadcast:
          gateway_id: d5d1ud9bli1e********
          path: /
          service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить информацию о триггере, воспользуйтесь методом REST API [get](../../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}
