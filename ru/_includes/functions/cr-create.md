{% list tabs %}

- Консоль управления

    Чтобы создать триггер:
    
    1. Откройте раздел **{{ sf-name }}** в каталоге, где требуется создать триггер для {{ container-registry-name }}.
    1. Перейдите во вкладку **Триггеры**.
    1. Нажмите кнопку **Создать триггер**.
    1. В блоке **Базовые параметры**:
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Container Registry**.
    1. В блоке **Настройки Container Registry**:
        * В поле **Реестр** выберите реестр, для событий с образами в котором необходимо создать триггер.
        * В поле **Типы событий** выберите события, которые приведут к запуску триггера.
        * (опционально) В поле **Имя Docker-образа** введите [имя образа](../../functions/concepts/trigger/cr-trigger.md#filter) для фильтрации.
        * (опционально) В поле **Тег Docker-образа** введите [тег образа](../../functions/concepts/trigger/cr-trigger.md#filter) для фильтрации.
    1. В блоке **Настройки повторных запросов**:
        * В поле **Интервал** укажите 5 секунд.
        * В поле **Количество попыток** укажите 5.
    1. В блоке **Настройки функции**:
        * Выберите функцию, которую будет вызывать триггер.
        * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
        * Укажите сервисный аккаунт, от имени которого будет вызываться функция.    
    1. Нажмите кнопку **Создать триггер**.

    Триггер будет создан и отобразится в таблице в разделе **Триггеры**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Создайте триггер: 

    - `--name` — имя триггера.
    - `--registry-id` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md).
    - `--events` — [события триггера](../../functions/concepts/trigger/cr-trigger.md#event).
    - `--invoke-function-id` — уникальный идентификатор функции.
    - `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции. 
           
    ```

    $ yc serverless trigger create container-registry \
        --name registry-trigger \
        --registry-id crtlds4t************ \
        --events create-image,delete-image,create-image-tag,delete-image-tag \
        --invoke-function-id b09q1un7************ \
        --invoke-function-service-account-id bfbm2ib6************
    ```
    Результат:
    ```
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