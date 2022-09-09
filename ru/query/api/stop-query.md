# stop-query

Останавливает запрос. 

При успехе метод возвращает HTTP-код 204, означающий успешное исполнение команды.

{% include [!](../_includes/api-common.md) %}

## Запрос {#request}

`POST`-запрос на адрес `/{folder_id}/queries/{query_id}/stop`, где `{folder_id}` - идентификатор фолдера, а `{query_id}` - идентификатор запроса. 

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 204 без содержимого.

## Ошибки {#errors}

Могут возникать [ошибки](common-information.md#errors), общие для всех методов.

## Пример { #example }

Запрос: 
```
curl -X 'POST' \
  'http://localhost:3000/v1/{folder_id}/queries/{query_id}/stop' \
  -H 'accept: */*' \
  -d ''
```

Ответ: HTTP 204.
