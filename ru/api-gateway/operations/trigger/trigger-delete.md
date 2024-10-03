---
title: Инструкция о том, как удалить триггер в {{ api-gw-full-name }}
description: Из статьи вы узнаете, как удалить триггер в {{ api-gw-full-name }}.
---

# Удалить триггер в {{ api-gw-full-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
    
- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../../_includes/serverless-containers/trigger-list-note.md) %}
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: PAUSED
    ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../../triggers/api-ref/grpc/trigger_service.md#Delete).

{% endlist %}
