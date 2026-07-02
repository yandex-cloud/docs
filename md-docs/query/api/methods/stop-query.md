[Документация Yandex Cloud](../../../index.md) > [Yandex Query](../../index.md) > Справочник > [HTTP API](../index.md) > [Методы](index.md) > stop-query

# stop-query

Метод останавливает запрос.

При использовании HTTP API необходимо [аутентифицироваться](../auth.md), указав для этого [обязательные заголовки](../index.md#mandatory-headers). Кроме того, можно задать [необязательные заголовки](../index.md#optional-headers) для настройки исполнения запросов. При работе с HTTP API могут возвращаться [ошибки](../index.md#errors).

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