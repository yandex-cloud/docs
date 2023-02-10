---
title: "Инструкция о том, как удалить триггер в {{ serverless-containers-full-name }}"
description: "Из статьи вы узнаете, как удалить триггер в {{ serverless-containers-full-name }}."
---

# Удалить триггер в {{ serverless-containers-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ serverless-containers-name }}**.
    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
    
- CLI
  
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        invoke_container_with_retry:
          container_id: bba5jb38o8**********
          service_account_id: aje03adgd2**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
            service-account-id: aje3lebfem**********
    status: PAUSED
    ```

- API

  Удалить триггер можно с помощью метода API [delete](../triggers/api-ref/Trigger/delete.md).

{% endlist %}
