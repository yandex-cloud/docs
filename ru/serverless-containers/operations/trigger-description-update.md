# Изменить описание триггера в {{ serverless-containers-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ serverless-containers-name }}**.
    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, описание которого хотите изменить.
    1. В правом верхнем углу страницы нажмите **Редактировать**.
    1. Измените описание и нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

    Чтобы изменить описание триггера, выполните команду:

    ```
    yc serverless trigger update <имя_триггера> --description "<описание_триггера>"
    ```

    Результат:

    ```
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: my-trigger
    description: My trigger for mail.
    rule:
      mail:
        email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
        invoke_container:
          container_id: bba5jb38o8**********
          service_account_id: aje03adgd2**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
            service-account-id: aje3lebfem**********
    status: ACTIVE
    ```

- API

  Чтобы изменить описание триггера, воспользуйтесь методом REST API [update](../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}
