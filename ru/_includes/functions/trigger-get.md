{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Выберите сервис **{{ sf-name }}**.
  1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    {% include [trigger-list-note](trigger-list-note.md) %}

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя триггера>
    ```

    Результат:

    ```text
    id: dd0gj5tsj2**********
    folder_id: aoek49ghmk**********
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        arn: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
        service_account_id: bfbqqeo6jk**********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91t**********
          function_tag: $latest
          service_account_id: bfbqqeo6jk**********
    status: ACTIVE
    ```

- API

  Получить подробную информацию о триггере можно с помощью метода API [get](../../functions/triggers/api-ref/Trigger/get.md).
  
{% endlist %}
