# Создание триггера с помощью {{ sf-full-name }}

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

Создайте [триггер для {{ container-registry-name }}](../concepts/trigger.md), который будет вызывать функцию при операциях с [Docker-образами](../concepts/docker-image.md).

{% include [before-begin](../../_includes/functions/os-timer-before-begin.md) %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан триггер для {{ container-registry-name }}.
  1. В списке сервисов выберите **{{ sf-name }}**.
  1. Перейдите во вкладку **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
     * Введите имя и описание триггера.
     * В поле **Тип** выберите **Container Registry**.
  1. В блоке **Настройки Container Registry**:
     * В поле **Реестр** выберите реестр, для событий с образами в котором необходимо создать триггер.
     * В поле **Типы событий** выберите события, которые приведут к запуску триггера.
     * (опционально) В поле **Имя Docker-образа** введите [имя образа](../concepts/trigger.md#filter) для фильтрации.
     * (опционально) В поле **Тег Docker-образа** введите [тег образа](../concepts/trigger.md#filter) для фильтрации.
  1. В блоке **Настройки повторных запросов**:
     * В поле **Интервал** укажите 5 секунд.
     * В поле **Количество попыток** укажите 5.
  1. В блоке **Настройки функции**:
     * Выберите функцию, которую будет вызывать триггер.
     * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
     * Укажите сервисный аккаунт, от имени которого будет вызываться функция.
  1. Нажмите кнопку **Создать триггер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc serverless trigger create container-registry \
    --name registry-trigger \
    --registry-id crtlds4t************ \
    --events create-image,delete-image,create-image-tag,delete-image-tag \
    --invoke-function-id b09q1un7************ \
    --invoke-function-service-account-id bfbm2ib6************
  ```

  Где:
  * `--name` — имя триггера.
  * `--registry-id` — [идентификатор реестра](../operations/registry/registry-list.md).
  * `--events` — [события триггера](../../functions/concepts/trigger/cr-trigger.md#event).
  * `--invoke-function-id` — уникальный идентификатор функции.
  * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.

  Результат выполнения команды:

  ```bash
  id: a1sp5170************
  folder_id: b1g7i3rf************
  created_at: "2020-09-08T06:26:22.651656Z"
  name: registry-trigger
  rule:
    container_registry:
      event_type:
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
      registry_id: crtlds4t************
      invoke_function:
        function_id: b09q1un7************
        function_tag: $latest
        service_account_id: bfbm2ib6************
  status: ACTIVE
  ```

{% endlist %}