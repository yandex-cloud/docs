# Создать таймер, который вызывает контейнер {{ serverless-containers-name }}

Создайте [таймер](../concepts/trigger/timer.md) — триггер, который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} по расписанию.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Таймер**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки таймера** укажите расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).

    1. В блоке **Настройки контейнера** выберите его и укажите:

        {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create timer \
      --name <имя_таймера> \
      --cron-expression '<cron_выражение>' \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        invoke_container_with_retry:
          container_id: bba5jb38o8**********
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
            service-account-id: aje3932acd**********
    status: ACTIVE
    ```

- API

  Создать таймер можно с помощью метода API [create](../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Таймер, который вызывает функцию {{ sf-name }}](../../functions/operations/trigger/timer-create.md).
