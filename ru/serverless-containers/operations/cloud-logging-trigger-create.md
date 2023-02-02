# Создать триггер для {{ cloud-logging-name }}, который вызывает контейнер {{ serverless-containers-name }}

Создайте [триггер для {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при добавлении записей в [лог-группу](../../logging/concepts/log-group.md).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* Лог-группа, при добавлении записей в которую триггер будет запускаться. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:
   
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **{{ cloud-logging-name }}**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки {{ cloud-logging-name }}** укажите:

        * лог-группу;
        * (опционально) типы ресурсов — ваши сервисы или сервисы {{ yandex-cloud }}, например `serverless.function`;
        * (опционально) идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например контейнеров {{ serverless-containers-name }};
        * (опционально) уровни логирования.

       Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем опциональным настройкам. Если опциональная настройка не задана, триггер срабатывает при любом ее значении.

    1. (опционально) В блоке **Настройки группирования сообщений** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 100, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **Настройки контейнера** выберите контейнер и укажите:

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
    yc serverless trigger create logging \
      --name <имя_триггера> \
      --log-group-name <имя_лог-группы> \
      --batch-size 1 \
      --batch-cutoff 1s \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--log-group-name` — имя лог-группы, при добавлении записей в которую будет вызываться контейнер.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 100, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: logging-trigger
    rule:
      logging:
        log_group_id: e23bidnftl**********
        batch_settings:
          size: "1"
          cutoff: 1s
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

  Создать триггер для {{ cloud-logging-name }} можно с помощью метода API [create](../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ cloud-logging-name }}, который вызывает функцию {{ sf-name }}](../../functions/operations/trigger/cloud-logging-trigger-create.md).
