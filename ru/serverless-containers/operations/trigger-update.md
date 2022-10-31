# Изменение триггера

Вы можете изменить [имя](#update-name) или [описание](#update-description) триггера.

{% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

## Изменить имя триггера {#update-name}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ serverless-containers-name }}**.
    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, имя которого хотите изменить.
    1. В правом верхнем углу страницы нажмите **Редактировать**.
    1. Измените имя и нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить имя триггера, выполните команду:

    ```bash
    yc serverless trigger update <имя_триггера> --new-name <новое_имя_триггера>
    ```

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: my-trigger
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

{% endlist %}

## Изменить описание триггера {#update-description}

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

{% endlist %}
