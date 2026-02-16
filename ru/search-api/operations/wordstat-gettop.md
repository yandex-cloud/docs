# Получить топ результатов по ключевой фразе

{{ wordstat-name }} позволяет получить самые популярные результаты поиска по ключевой фразе с помощью [REST-метода](../api-ref/Wordstat/getTop.md) или [gRPC-вызова](../api-ref/grpc/Wordstat/getTop.md) GetTop.

Чтобы воспользоваться примером, [создайте](../../ai-studio/operations/get-api-key.md#run-client) сервисный аккаунт с [ролью](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user` и получите для него API-ключ с областью действия `yc.search-api.execute`. Также вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) как более безопасный способ. [Подробнее об аутентификации в {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Создайте файл с телом запроса (например, `body.json`):
     
     ```json
	  {
       "phrase": "<ключевая_фраза>",
       "numPhrases": 100,
       "regions": ["213"],
       "devices": ["DEVICE_ALL"],
       "folderId": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
     * `numPhrases` — количество фраз в ответе. Значение по умолчанию — 50, максимальное значение — 2000.
     * `regions` — список [идентификаторов регионов](../reference/regions.md), откуда был задан запрос, например, `213` — Москва. По умолчанию учитываются запросы из любого региона.
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
         "https://searchapi.{{ api-host }}/v2/wordstat/topRequests" \
         > result.json
       ```

     * Аутентификация с API-ключом:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API-ключ>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/topRequests" \
         > result.json
       ```

     Результат будет сохранен в файл `result.json`.

     {% cut "Фрагмент ответа" %}

     ```json
     {
        "totalCount": "48885",
        "results": [
          {
            "phrase": "купить собаку",
            "count": "48885"
          },
       ],
        "associations": [
          {
            "phrase": "сколько стоит пудель",
            "count": "613"
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
       "num_phrases": 100,
       "regions": ["213"],
       "devices": ["DEVICE_ALL"],
       "folder_id": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
     * `num_phrases` — количество фраз в ответе. Значение по умолчанию — 50, максимальное значение — 2000.
     * `regions` — список [идентификаторов регионов](../reference/regions.md), откуда был задан запрос, например, `213` — Москва. По умолчанию учитываются запросы из любого региона.
     * `devices` — список типов устройств, с которых был задан запрос. Возможные значения:
        * `DEVICE_ALL`: все устройства.
        * `DEVICE_DESKTOP`: компьютеры.
        * `DEVICE_PHONE`: телефоны.
        * `DEVICE_TABLET`: планшеты.
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) вашего сервисного аккаунта.

  1. Выполните [gRPC-вызов](../api-ref/grpc/Wordstat/getTop.md), указав полученный ранее API-ключ или IAM-токен и путь к файлу с телом запроса:

     * Аутентификация с API-ключом:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Api-Key <API-ключ>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetTop \
         > result.json
       ```

     * Аутентификация с IAM-токеном:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Bearer <IAM-токен>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetTop \
         > result.json
       ```

     Результат будет сохранен в файл `result.json`. 

     {% cut "Фрагмент ответа" %}

     ```json
     {
        "totalCount": "48885",
        "results": [
          {
            "phrase": "купить собаку",
            "count": "48885"
          },
       ],
        "associations": [
          {
            "phrase": "сколько стоит пудель",
            "count": "613"
          }
       ]
     }
     ```

     {% endcut %}

{% endlist %}