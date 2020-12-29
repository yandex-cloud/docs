Создайте [триггер для {{ container-registry-name }}](../../functions/concepts/trigger/cr-trigger.md), который будет вызывать вашу функцию при создании и удалении [Docker-образов](../../container-registry/concepts/docker-image.md) {{ container-registry-full-name }} или их тегов.

Для создания триггера вам понадобятся:
1. [Функция](../../functions/concepts/function.md), которую триггер будет запускать. Если у вас еще нет функции:
    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).
1. [Реестр](../../container-registry/concepts/registry.md), при событиях с Docker-образами в котором триггер будет запускаться. Если у вас нет реестра, [создайте его](../../container-registry/operations/registry/registry-create.md).
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
        * В поле **Тип** выберите **Container Registry**.
    1. В блоке **Настройки Container Registry**:
        * В поле **Реестр** выберите реестр, для событий с образами в котором необходимо создать триггер.
        * В поле **Типы событий** выберите [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер будет запускаться.
        * (опционально) В поле **Имя Docker-образа** введите [имя образа](../../functions/concepts/trigger/cr-trigger.md#filter) для фильтрации.
        * (опционально) В поле **Тег Docker-образа** введите [тег образа](../../functions/concepts/trigger/cr-trigger.md#filter) для фильтрации.
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
    yc serverless trigger create container-registry \
        --name <имя триггера> \
        --registry-id <идентификатор реестра> \
        --events 'create-image', 'delete-image', 'create-image-tag', 'delete-image-tag' \
        --invoke-function-id <идентификатор функции> \
        --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
        --retry-attempts 1 \
        --retry-interval 10s \
        --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
        --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md).
    * `--events` — [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
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
    created_at: "2020-09-08T06:26:22.651656Z"
    name: registry-trigger
    rule:
      container_registry:
        event_type:
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
        registry_id: crtlds4tdfg12kil77sdfg345ghj
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

    Создать триггер для {{ container-registry-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}