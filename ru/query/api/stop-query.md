# stop-query

Останавливает запрос. 

При успехе метод возвращает HTTP-код 204, означающий успешное исполнение команды.

{% include [!](../_includes/api-common.md) %}

## Запрос {#request}

`POST`-запрос на адрес `/queries/{query_id}/stop?project={folder_id}`, где `{folder_id}` - идентификатор фолдера, а `{query_id}` - идентификатор запроса. 

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 204 без содержимого.

## Ошибки {#errors}

Могут возникать [ошибки](common-information.md#errors), общие для всех методов.

## Пример { #example }

Запрос: 
```
curl -X 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7/stop?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: */*' \
  -d ''
```

Ответ: HTTP 204.
