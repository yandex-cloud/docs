# get-query-status

Метод возвращает информацию о статусе выполнения запроса. Используйте этот метод для отслеживания хода выполнения запроса, чтобы дождаться его завершения и [получить результаты](get-query-results.md).

{% include [!](../../_includes/api-common.md) %}

## Запрос {#request}

`GET`-запрос на адрес `/queries/{query_id}/status?project={folder_id}`, где `{folder_id}` — идентификатор каталога, а `{query_id}` — идентификатор запроса.

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 200 и статусом выполнения запроса: `RUNNING`, `COMPLETED` или `FAILED`.

```json
{
  "status": "RUNNING"
}
```

## Пример {#example}

Запрос:

```json
curl \
  --request 'GET' \
  --header 'accept: application/json' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********/status?project=b1gaue5b382m********'
```

Ответ:

```json
{
  "status": "RUNNING"
}
```
