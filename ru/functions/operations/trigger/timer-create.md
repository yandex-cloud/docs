# Создание таймера

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Создайте [таймер](../../concepts/trigger/timer.md), который будет вызывать вашу функцию по расписанию.

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Создать таймер {#timer-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    Чтобы создать таймер:
    1. Откройте раздел **{{ sf-name }}** в каталоге, где требуется создать таймер.
    1. Перейдите во вкладку **Триггеры**.
    1. Нажмите кнопку **Создать триггер**.
    1. В блоке **Базовые параметры**:
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Таймер**.
    1. В блоке **Настройки таймера**:
        * В поле **Cron-выражение** введите [cron-выражение](../../concepts/trigger/timer.md#cron-expression).
    1. В блоке **Настройки функции**:
        * Выберите функцию, которая будет вызываться по таймеру.
        * Укажите [тег версии функции](../../concepts/function.md#tag).
        * Укажите сервисный аккаунт, от имени которого будет вызываться функция. 
    1. Нажмите кнопку **Создать триггер**.
    
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать таймер, выполните команду: 
    
    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова функции в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
    * `--invoke-function-id` — идентификатор функции. 
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции. 

    ```    
    $ yc serverless trigger create timer \
        --name <имя таймера> \
        --cron-expression '<cron-выражение>' \
        --invoke-function-id <идентификатор функции> \
        --invoke-function-service-account-id <идентификатор сервисного аккаунта>
    ```
    Результат:
    ```
    id: a1sfe084v4se4morbu2i
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-12-04T08:45:31.131391Z"
    name: my-timer
    rule:
      timer:
        cron_expression: 5 12 * * ? *
        invoke_function_with_retry:
          function_id: d4eofc7n0m03lmudse8l
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7dagp
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```
  
{% endlist %}
