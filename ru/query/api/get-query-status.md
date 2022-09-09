# get-query-status

Получает информацию о статусе выполнения запроса.

При успехе метод возвращает информацию о статусе выполнения запросе. Метод удобно использовать для отслеживания хода выполнения запроса, чтобы дождаться его завершения и [получить результаты](get-query-results.md).

{% include [!](../_includes/api-common.md) %}

## Запрос {#request}

`GET`-запрос на адрес `/{folder_id}/queries/{query_id}/status`, где `{folder_id}` - идентификатор фолдера, а `{query_id}` - идентификатор запроса. 

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
  'http://localhost:3000/v1/{folder_id}/queries/{query_id}/status' \
  -H 'accept: application/json'
}
```

Ответ: 

```json
{
  "status": "RUNNING"
}
```