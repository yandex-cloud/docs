# Создание триггера для почты

Создайте [триггер для почты](../../serverless-containers/concepts/trigger/mail-trigger.md), который будет вызывать [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

О том, как создать триггер для почты, который будет вызывать функцию, читайте в [документации {{ sf-full-name }}](../../functions/operations/trigger/mail-trigger-create.md).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * (опционально) Введите имя и описание триггера.
        * В поле **Тип** выберите **Почта**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки контейнера** выберите контейнер и укажите:

        * [ревизию контейнера](../../serverless-containers/concepts/container.md#revision);
        * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться контейнер.

    1. (опционально) В блоке **Настройки повторных запросов**:

        * В поле **Интервал** укажите время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **Количество попыток** укажите количество повторных вызовов контейнера, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../serverless-containers/concepts/dlq.md). Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь [Dead Letter Queue](../../serverless-containers/concepts/dlq.md) и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, который запускает контейнер, выполните команду:

    ```
    yc serverless trigger create mail \
      --name <имя триггера> \
      --invoke-container-id <идентификатор контейнера> \
      --invoke-container-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--invoke-container-id` — идентификатор контейнера.
    * `--invoke-container-service-account-id` — сервисный аккаунт с правами на вызов контейнера.
    * `--retry-attempts` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--retry-interval` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../message-queue/concepts/dlq.md). Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--dlq-queue-id` — идентификатор очереди [Dead Letter Queue](../../serverless-containers/concepts/dlq.md). Необязательный параметр.
    * `--dlq-service-account-id` — сервисный аккаунт с правами на запись в очередь [Dead Letter Queue](../../serverless-containers/concepts/dlq.md). Необязательный параметр.

    Результат:

    ```
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    rule:
      mail:
        invoke_container:
          container_id: d4eofc7n0m**********
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932acd**********
    status: ACTIVE
    ```

{% endlist %}

{{ serverless-containers-name }} автоматически сгенерирует адрес электронной почты, при отправке писем на который будет срабатывать триггер. Чтобы посмотреть его, [получите подробную информацию о триггере](../../serverless-containers/operations/trigger-list.md#trigger-get).

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}
