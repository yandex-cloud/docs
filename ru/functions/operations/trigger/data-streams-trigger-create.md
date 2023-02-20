# Создать триггер для {{ yds-name }}, который вызывает функцию {{ sf-name }}

{% if audience == "external" %} Создайте [триггер для {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). {% endif %}

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../function/function-create.md).
    * [Создайте версию функции](../function/version-manage.md).

* (опционально) Очередь [Dead Letter Queue](../../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов функции;
    * на чтение из потока, при отправке данных в который триггер будет запускаться;
    * (опционально) на запись в очередь Dead Letter Queue.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* Поток, при отправке данных в который триггер будет запускаться. {% if audience == "external" %} Если у вас нет потока, [создайте его](../../../data-streams/quickstart/create-stream.md). {% endif %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ sf-name }}**.

    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **{{ yds-name }}**.
        * В поле **Запускаемый ресурс** выберите **Функция**.

    1. В блоке **Настройки {{ yds-name }}** выберите поток данных и сервисный аккаунт с правами на чтение из потока данных и запись в него.

    1. (опционально) В блоке **Настройки группирования сообщений** укажите:

        * размер группы сообщений в байтах. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию. Суммарный объем данных, которые передаются в функцию, может превышать указанный размер группы, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает размер группы.

    1. В блоке **Настройки функции** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create yds \
      --name <имя триггера> \
      --database <размещение_базы_данных> \
      --stream <имя потока данных> \
      --batch-size 1b \
      --batch-cutoff 1s \
      --stream-service-account-id <идентификатор сервисного аккаунта> \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--database` — размещение базы данных {{ ydb-short-name }}, к которой привязан поток {{ yds-name }}.

      Чтобы узнать, где размещена база данных, выполните команду `yc ydb database list`. Размещение базы данных указано в столбце `ENDPOINT`, в параметре `database`, например `/{{ region-id }}/b1gia87mba**********/etn7hehf6g*******`.

    * `--stream` — имя потока данных {{ yds-name }}.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 Б до 64 КБ, значение по умолчанию — 1 Б.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию. Суммарный объем данных, которые передаются в функцию, может превышать `batch-size`, если данные передаются в одном сообщении. Во всех остальных случаях объем данных не превышает `batch-size`.
    * `--stream-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на чтение из потока данных и запись в него.
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1smnfisr5**********
    folder_id: b1gc1t4cb6**********
    created_at: "2022-10-31T10:57:08.234586266Z"
    name: data-streams-trigger
    rule:
      data_stream:
        database: /{{ region-id }}/b1gvlrnlei**********/etn3ege6nj**********
        stream: yds-stream
        service_account_id: aje07l4q4v**********
        batch_settings:
          size: "1"
          cutoff: 1s
        invoke_function:
          function_id: d4e155orh3**********
          function_tag: $latest
          service_account_id: aje07l4q4v**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue_id: yrn:yc:ymq:{{ region-id }}:b1gc1t4cb6**********:queue_dead
            service_account_id: aje07l4q4v**********
    status: ACTIVE
    ```

- API

    Создать триггер для {{ yds-name }} можно с помощью метода API [create](../../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ yds-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/data-streams-trigger-create.md).
