# Удаление триггера

{% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

## Удалить триггер

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **Удалить**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Удалите триггер:
    
    ```
    yc serverless trigger delete <имя триггера>
    ```

    Результат:
    
    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: PAUSED
    ```

- API

  Удалить триггер можно с помощью метода API [delete](../../triggers/api-ref/Trigger/delete.md).

{% endlist %}
