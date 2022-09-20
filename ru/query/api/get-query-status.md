# get-query-status

Получает информацию о статусе выполнения запроса.

При успехе метод возвращает информацию о статусе выполнения запросе. Метод удобно использовать для отслеживания хода выполнения запроса, чтобы дождаться его завершения и [получить результаты](get-query-results.md).

{% include [!](../_includes/api-common.md) %}

## Запрос {#request}

`GET`-запрос на адрес `/queries/{query_id}/status?project={folder_id}`, где `{folder_id}` - идентификатор фолдера, а `{query_id}` - идентификатор запроса. 

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 200 и статусом выполнения запроса.

```json
{
  "status": "RUNNING"
}
```

| Параметр | Описание | Примечание |
| ----- | ----- | ----- |
|`status`|Статус выполнения запроса|Возможные значения: `RUNNING`, `COMPLETED`, `FAILED` |


## Ошибки {#errors}

Могут возникать [ошибки](common-information.md#errors), общие для всех методов.

## Пример { #example }

Запрос: 
```
curl -X 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7/status?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: application/json'
}
```

Ответ: 

```json
{
  "status": "RUNNING"
}
```