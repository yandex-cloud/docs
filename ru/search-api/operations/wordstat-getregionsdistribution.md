# Получить распределение количества запросов с ключевой фразой по регионам

{{ wordstat-name }} позволяет получить распределение числа запросов, содержащих заданную фразу, по регионам мира за последние 30 дней с помощью [REST-метода](../api-ref/Wordstat/getRegionsDistribution.md) или [gRPC-вызова](../api-ref/grpc/Wordstat/getRegionsDistribution.md) GetRegionsDistribution. 

{% include [preview-stage](../../_includes/preview-pp.md) %}

Чтобы воспользоваться примером, [создайте](../../ai-studio/operations/get-api-key.md#run-client) сервисный аккаунт с [ролью](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user` и получите для него API-ключ с областью действия `yc.search-api.execute`. Также вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) как более безопасный способ. [Подробнее об аутентификации в {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Создайте файл с телом запроса (например, `body.json`):
     
     ```json
	  {
        "phrase": "<ключевая_фраза>",
        "region": "REGION_CITIES",
        "devices": ["DEVICE_PHONE"],
        "folderId": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
     * `region` — уровень детализации распределения. Возможные значения:
        * `REGION_CITIES`: детализация только по городам.
        * `REGION_REGIONS`: детализация только по регионам.
        * `REGION_ALL`: везде, значение по умолчанию.
     * `devices` — список типов устройств, с которых был задан запрос. Возможные значения:
        * `DEVICE_ALL`: все устройства.
        * `DEVICE_DESKTOP`: компьютеры.
        * `DEVICE_PHONE`: телефоны.
        * `DEVICE_TABLET`: планшеты.
     * `folderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) вашего сервисного аккаунта.

  1. Выполните HTTP-запрос, указав полученный ранее API-ключ или IAM-токен и путь к файлу с телом запроса:

     * Аутентификация с IAM-токеном:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer <IAM-токен>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/regions" \
         > result.json
       ```

     * Аутентификация с API-ключом:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API-ключ>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/regions" \
         > result.json
       ```

     Результат будет сохранен в файл `result.json`.

      {% cut "Фрагмент ответа" %}

      ```json
      {
       "results": [
        {
         "region": "2",
         "count": "117527",
         "share": 0.033340221022570879,
         "affinityIndex": 48.87239354882464
        },
        {
         "region": "213",
         "count": "286666",
         "share": 0.03751625685705634,
         "affinityIndex": 54.99391465808182
        }
       ]
      }
      ```

      {% endcut %}

- gRPC API {#grpc-api}

  1. Создайте файл с телом запроса (например, `body.json`):
     
     ```json
	  {
        "phrase": "<ключевая_фраза>",
        "region": "REGION_CITIES",
        "devices": ["DEVICE_PHONE"],
        "folder_id": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
     * `region` — уровень детализации распределения. Возможные значения:
        * `REGION_CITIES`: детализация только по городам.
        * `REGION_REGIONS`: детализация только по регионам.
        * `REGION_ALL`: везде, значение по умолчанию.
     * `devices` — список типов устройств, с которых был задан запрос. Возможные значения:
        * `DEVICE_ALL`: все устройства.
        * `DEVICE_DESKTOP`: компьютеры.
        * `DEVICE_PHONE`: телефоны.
        * `DEVICE_TABLET`: планшеты.
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) вашего сервисного аккаунта.

  1. Выполните gRPC-вызов, указав полученный ранее API-ключ или IAM-токен и путь к файлу с телом запроса:
     
      * Аутентификация с IAM-токеном:
     
         ```bash
         grpcurl \
           -rpc-header "Authorization: Bearer <IAM-токен>" \
           -d @ < body.json \
           searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsDistribution \
           > result.json
         ```

      * Аутентификация с API-ключом:
     
         ```bash
         grpcurl \
           -rpc-header "Authorization: Api-Key <API-ключ>" \
           -d @ < body.json \
           searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsDistribution \
           > result.json
         ```

      Результат будет сохранен в файл `result.json`. 

      Ответ содержит массив объектов со следующими параметрами:

      * `region` — [идентификатор региона](../reference/regions.md).
      * `count` — количество запросов с указанной фразой в регионе.
      * `share` — доля запросов с фразой от общего числа запросов в регионе
      * `affinityIndex` — [индекс соответствия](https://ru.wikipedia.org/wiki/Индекс_соответствия) — отношение доли запросов в регионе к их доле по стране.

      {% cut "Фрагмент ответа" %}

      ```json
      {
       "results": [
        {
         "region": "2",
         "count": "117527",
         "share": 0.033340221022570879,
         "affinityIndex": 48.87239354882464
        },
        {
         "region": "213",
         "count": "286666",
         "share": 0.03751625685705634,
         "affinityIndex": 54.99391465808182
        }
       ]
      }
      ```

      {% endcut %}

{% endlist %}