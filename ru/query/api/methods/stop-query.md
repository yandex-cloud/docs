# stop-query

Метод останавливает запрос.

{% include [!](../../_includes/api-common.md) %}

## Запрос {#request}

`POST`-запрос на адрес `/queries/{query_id}/stop?project={folder_id}`, где `{folder_id}` — идентификатор каталога, а `{query_id}` — идентификатор запроса.

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 204 без содержимого.

## Пример {#example}

Запрос:

```json
curl \
  --request 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********/stop?project=b1gaue5b382m********' \
  --header 'accept: */*' \
  --data ''
```

Ответ: HTTP 204.
