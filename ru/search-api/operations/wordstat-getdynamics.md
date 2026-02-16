# Получить динамику изменений частоты запросов по ключевой фразе

{{ wordstat-name }} позволяет узнать, как изменяется частота запросов с ключевой фразой с помощью [REST-метода](../api-ref/Wordstat/getDynamics.md) или [gRPC-вызова](../api-ref/grpc/Wordstat/getDynamics.md) GetDynamics.

{% include [preview-stage](../../_includes/preview-pp.md) %}

Чтобы воспользоваться примером, [создайте](../../ai-studio/operations/get-api-key.md#run-client) сервисный аккаунт с [ролью](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user` и получите для него API-ключ с областью действия `yc.search-api.execute`. Также вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) как более безопасный способ. [Подробнее об аутентификации в {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Создайте файл с телом запроса (например, `body.json`):
     
     ```json
	   {
      "phrase": "<ключевая_фраза>",
      "period": "PERIOD_WEEKLY",
      "fromDate": "2025-12-01T00:00:00Z",
      "toDate": "2025-12-14T00:00:00Z",
      "regions": ["213"],
      "devices": ["DEVICE_DESKTOP"],
      "folderId": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
       
       {% note info %}

       Метод `GetDynamics` поддерживает все операторы при детализации по дням. При детализации по неделям и месяцам — только оператор `+`.

       {% endnote %}

     * `period` — период агрегации запросов по времени. Возможные значения:
       * `PERIOD_MONTHLY`: агрегация за месяц.
       * `PERIOD_WEEKLY`: агрегация за неделю.
       * `PERIOD_DAILY`: агрегация за день.
     * `fromDate` — дата и время начала периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Для агрегации за неделю и месяц — понедельник или первый день месяца.
     * `toDate` — дата и время окончания периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Для агрегации за неделю и месяц — воскресенье или последний день месяца.
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
         "https://searchapi.{{ api-host }}/v2/wordstat/dynamics" \
         > result.json
       ```

     * Аутентификация с API-ключом:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API-ключ>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/dynamics" \
         > result.json
       ```

     Результат будет сохранен в файл `result.json`.

     {% cut "Пример ответа" %}

     ```json
     {
       "results": [
         {
           "date": "2025-12-01T00:00:00Z",
           "count": "1999",
           "share": 0.002010327532236065
         },
         {
           "date": "2025-12-08T00:00:00Z",
           "count": "3095",
           "share": 0.0031681796592690848
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
      "period": "PERIOD_WEEKLY",
      "from_date": "2025-12-29T00:00:00Z",
      "to_date": "2026-01-18T00:00:00Z",
      "regions": ["213"],
      "devices": ["DEVICE_DESKTOP"],
      "folder_id": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
       
       {% note info %}

       Метод `GetDynamics` поддерживает все операторы при детализации по дням. При детализации по неделям и месяцам — только оператор `+`.

       {% endnote %}

     * `period` — период агрегации запросов по времени. Возможные значения:
       * `PERIOD_MONTHLY`: агрегация за месяц.
       * `PERIOD_WEEKLY`: агрегация за неделю.
       * `PERIOD_DAILY`: агрегация за день.
     * `from_date` — дата и время начала периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Для агрегации за неделю и месяц — понедельник или первый день месяца.
     * `to_date` — дата и время окончания периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Для агрегации за неделю и месяц — воскресенье или последний день месяца.
     * `regions` — список [идентификаторов регионов](../reference/regions.md), откуда был задан запрос, например, `213` — Москва. По умолчанию учитываются запросы из любого региона.
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
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetDynamics \
         > result.json
       ```

     * Аутентификация с API-ключом:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Api-Key <API-ключ>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetDynamics \
         > result.json
       ```

     Результат будет сохранен в файл `result.json`. 

     {% cut "Пример ответа" %}

     ```json
     {
       "results": [
         {
           "date": "2025-12-01T00:00:00Z",
           "count": "1999",
           "share": 0.002010327532236065
         },
         {
           "date": "2025-12-08T00:00:00Z",
           "count": "3095",
           "share": 0.0031681796592690848
         }
       ]
     }
     ```

     {% endcut %}

{% endlist %}