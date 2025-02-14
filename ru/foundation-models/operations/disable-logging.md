# Отключить логирование запросов

По умолчанию модели сохраняют все данные запросов. Если в запросах вы передаете персональные или конфиденциальные данные либо другую чувствительную информацию, отключите логирование. Для этого добавьте в заголовок запроса REST или метаинформацию вызова gRPC опцию `x-data-logging-enabled: false`. Запросы, переданные с отключенной опцией логирования, не будут сохраняться на серверах {{ yandex-cloud }}.

Чтобы отключить логирование запросов:

{% list tabs group=programming_language %}

- SDK {#sdk}

  При инициализации объекта класса `YCloudML` в параметре `enable_server_data_logging` установите значение `False`. В этом случае {{ ml-sdk-full-name }} будет добавлять опцию `x-data-logging-enabled: false` в метаинформацию каждого gRPC-вызова.

  Например:

  ```python
  ...
  sdk = YCloudML(
      folder_id="<идентификатор_каталога>",
      auth="<API-ключ>",
      enable_server_data_logging=False,
  )
  ...
  ```

  Где:

  * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../iam/concepts/users/service-accounts.md).
  * `<API-ключ>` — [API-ключ](../../iam/concepts/authorization/api-key.md) сервисного аккаунта, необходимый для [аутентификации в API](../api-ref/authentication.md). Вы также можете использовать другие варианты аутентификации. Подробнее см. в разделе [{#T}](../sdk/index.md#authentication).

- cURL {#curl}

  {% note info %}

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  {% endnote %}

  Добавьте к REST-запросу заголовок `x-data-logging-enabled: false`. Например:

  ```bash
  export FOLDER_ID=<идентификатор_каталога>
  export IAM_TOKEN=<IAM-токен>

  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --header "x-data-logging-enabled: false" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data "@<путь_до_файла_json>" \
    "<эндпоинт_модели>"
  ```

  Где:

  * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть необходимая [роль](../security/index.md).
  * `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.
  * `@<путь_до_файла_json>` — путь к файлу JSON, содержащему запрос к модели.
  * `<эндпоинт_модели>` — эндпоинт для обращения к модели. Например:
    * `https://llm.{{ api-host }}/foundationModels/v1/completion` — для синхронных запросов к [{{ yagpt-name }}](../concepts/yandexgpt/index.md).
    * `https://llm.{{ api-host }}/foundationModels/v1/completionAsync` — для [асинхронных](./yandexgpt/async-request.md) запросов к {{ yagpt-name }}.
    * `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification` — для [дообученных](../concepts/classifier/index.md#trainable) классификаторов.
    * `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` — для [Zero-shot](../concepts/classifier/index.md#zero-shot) и [Few-shot](../concepts/classifier/index.md#few-shot) классификаторов.
    * `https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync` — для [{{ yandexart-name }}](../concepts/yandexart/index.md).
    
    Полный список доступных эндпоинтов см. в [справочниках API {{ foundation-models-full-name }}](../concepts/api.md).

{% endlist %}