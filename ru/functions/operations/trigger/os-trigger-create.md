# Создание триггера для {{ objstorage-name }}

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Создайте [триггер для {{ objstorage-name }}](../../concepts/trigger/os-trigger.md), который будет вызывать вашу функцию при наступлении определенного события с объектом в бакете.

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    {% include [os-create-ui](../../../_includes/functions/os-create-ui.md) %}
    
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер для {{ objstorage-name }}, выполните команду: 

    ```    
    $ yc serverless trigger create object-storage \
        --name <имя триггера> \
        --bucket-id <имя бакета> \
        --prefix '<префикс>' \
        --suffix '<суффикс>' \
        --events 'create-object','delete-object','update-object' \
        --invoke-function-id <идентификатор функции> \
        --invoke-function-service-account-id <идентификатор сервисного аккаунта>
    ```
    Результат:
    ```
    id: a1s92agr8mpgeo3kjt48
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-12-18T09:47:50.079103Z"
    name: s3-trigger
    rule:
      object_storage:
        event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
        bucket_id: s3-for-trigger
        prefix: dev
        suffix: 12.jpg
        invoke_function:
          function_id: d4eofc7n0m03lmudsk7y
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7drte
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```
    
    Где: 
    * `--name` — имя таймера.
    * `--bucket-id` — имя бакета.
    * `--prefix` — [префикс](../trigger/os-trigger-create.md#filter) ключа объекта в бакете. Используется для фильтрации.
    * `--suffix` — [суффикс](../trigger/os-trigger-create.md#filter) ключа объекта в бакете. Используется для фильтрации.
    * `--events` — тип события, после наступления которого триггер запускается.
    * `--invoke-function-id` — идентификатор функции. 
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    
{% endlist %}
