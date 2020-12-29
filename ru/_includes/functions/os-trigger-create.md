Создайте [триггер для {{ objstorage-name }}](../../functions/concepts/trigger/os-trigger.md), который будет вызывать вашу функцию при создании, перемещении или удалении [объекта](../../storage/concepts/object.md) в бакете.

Для создания триггера вам понадобятся:
1. [Функция](../../functions/concepts/function.md), которую триггер будет запускать. Если у вас еще нет функции:
    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).
1. [Бакет](../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../storage/operations/buckets/create.md).
1. Очередь [Dead Letter Queue](../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).
1. Сервисный аккаунт с правами на вызов функции. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. Перейдите на вкладку **Триггеры**.
    1. Нажмите кнопку **Создать триггер**.
    1. В блоке **Базовые параметры**:
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Object Storage**.
    1. В блоке **Настройки Object Storage**:
        * В поле **Бакет** выберите бакет, для событий с объектами которого хотите создать триггер.
        * В поле **Типы событий** выберите [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер будет запускаться.
        * (опционально) В поле **Префикс ключа объекта** введите [префикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.
        * (опционально) В поле **Суффикс ключа объекта** введите [суффикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.
    1. В блоке **Настройки функции**:
        * Выберите функцию, которую будет вызывать триггер.
        * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
        * Укажите сервисный аккаунт, от имени которого будет вызываться функция.
    1. В блоке **Настройки повторных запросов**:
        * В поле **Интервал** укажите время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд.
        * В поле **Количество попыток** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5.
    1. В блоке **Настройки Dead Letter Queue** выберите очередь [Dead Letter Queue](../../functions/concepts/dlq.md) и сервисный аккаунт с правами на запись в нее.
    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, выполните команду:

    ```
    yc serverless trigger create object-storage \
        --name <имя триггера> \
        --bucket-id <имя бакета> \
        --prefix '<префикс ключа объекта>' \
        --suffix '<суффикс ключа объекта>' \
        --events 'create-object','delete-object','update-object' \
        --invoke-function-id <идентификатор функции> \
        --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
        --retry-attempts 1 \
        --retry-interval 10s \
        --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
        --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    где:

    * `--name` — имя таймера.
    * `--bucket-id` — идентификатор бакета.
    * `--prefix` — [префикс](../../functions/concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Используется для фильтрации.
    * `--suffix` — [суффикс](../../functions/concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Используется для фильтрации.
    * `--events` — [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--retry-attempts` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--retry-interval` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--dlq-queue-id` — идентификатор очереди [Dead Letter Queue](../../functions/concepts/dlq.md).
    * `--dlq-service-account-id` — сервисный аккаунт с правами на запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md).

    Результат:

    ```
    id: a1s92agr8mpgeo3kjt48
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-12-18T09:47:50.079103Z"
    name: os-trigger
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
          dead_letter_queue:
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
    ```

- API

    Создать триггер для {{ objstorage-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}
