# Получить динамику изменений частоты запросов по ключевой фразе

{{ wordstat-name }} позволяет узнать, как изменяется частота запросов с ключевой фразой с помощью вызова [GetDynamics](../api-ref/grpc/Wordstat/getDynamics.md).

{% include [preview-stage](../../_includes/preview-pp.md) %}

Чтобы воспользоваться примером, [создайте](../../ai-studio/operations/get-api-key.md#run-client) сервисный аккаунт с [ролью](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user` и получите для него API-ключ с областью действия `yc.search-api.execute`. Также вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) как более безопасный способ. [Подробнее об аутентификации в {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- gRPC API {#grpc-api}

  1. Создайте файл с телом запроса (например, `body.json`):
     
     ```json
	   {
      "phrase": "<ключевая_фраза>",
      "period": "PERIOD_WEEKLY",
      "fromDate": "2025-01-01T00:00:00Z",
      "toDate": "2025-03-01T00:00:00Z",
      "regions": ["213"],
      "devices": ["DEVICE_DESKTOP"],
      "folderId": "<идентификатор_каталога>"
     }
     ```

     Где:

     * `phrase` — ключевая фраза запроса, поддерживает [поисковые операторы](../concepts/search-operators.md).
       
       {% note info %}

        Метод `GetDynamics` поддерживает все операторы при детализации по дням, при детализации по неделям и месяцам — только оператор `+`.

       {% endnote %}

     * `period` — период агрегации запросов по времени. Возможные значения:
       * `PERIOD_MONTHLY`: агрегация за месяц.
       * `PERIOD_WEEKLY`: агрегация за неделю.
       * `PERIOD_DAILY`: агрегация за день.
     * `fromDate` — дата и время начала периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
     * `toDate` — дата и время окончания периода, за который запрашиваются данные, в виде строки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
     * `regions` — список [идентификаторов регионов](../reference/regions.md), откуда был задан запрос, например, `213` — Москва. По умолчанию учитываются запросы из любого региона.
     * `devices` — список типов устройств, с которых был задан запрос. Возможные значения:
        * `DEVICE_ALL`: все устройства.
        * `DEVICE_DESKTOP`: компьютеры.
        * `DEVICE_PHONE`: телефоны.
        * `DEVICE_TABLET`: планшеты.
     * `folderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) вашего сервисного аккаунта.

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

     {% cut "Фрагмент ответа" %}

     ```json
     {
       "results": [
          { "date": "2025-01-05T00:00:00Z", "count": "150", "share": 0.000012 },
          { "date": "2025-01-12T00:00:00Z", "count": "180", "share": 0.000014 }
        ]
     }
     ```

     {% endcut %}

{% endlist %}