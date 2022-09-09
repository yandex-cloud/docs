# get-query 

Получает информацию о запросе.

При успехе метод возвращает информацию о запросе, включая метаинформацию о запросе, статус его выполнения и объем результатов. 

{% include [!](../_includes/api-common.md) %}

## Запрос {#request}

`GET`-запрос на адрес `/{folder_id}/queries/{query_id}`, где `{folder_id}` - идентификатор фолдера, а `{query_id}` - идентификатор запроса. 

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 200 и идентификатором запроса.

```json
{
  "name": "<query name>",
  "type": "<query_type>",
  "text": "<query text>",
  "description": "<description>",
  "meta": {
    "started_at": "2022-09-03T14:53:00.067Z",
    "finished_at": "2022-09-03T14:53:00.067Z"
  },
  "issues": {
    "detailed": [
      {
        "position": {
          "row": 0,
          "column": 0,
          "file": "string"
        },
        "message": "string",
        "end_position": {
          "row": 10,
          "column": 10,
          "file": "string"
        },
        "issue_code": 0,
        "severity": "FATAL",
        "issues": [          
        ],
        "status": 0
      }
    ],
    "message": "string",
    "status": 0
  },
  "result_sets": [
    {
      "rows": 0,
      "truncated": true
    }
  ],
  "status": "RUNNING",
  "id": "string"
}
```

| Параметр | Описание | Примечание |
| ----- | ----- | ----- |
|`name`|Название запроса||
|`type`|Тип запроса, потоковый или аналитический | `STREAMING`, `ANALYTICS`||
|`text`|Текст запроса ||
|`description`|Описание запроса ||
|`meta.started_at`|Момент начала выполнения запроса ||
|`meta.finished_at`|Момент завершения выполнения запроса ||
|`issues`|При наличии ошибок выполнения содержит объект [`Issue`](common-information.md#issue) ||
|`result_sets`|Массив результатов выполнения запроса|
|`result_sets[].rows`|Количество строк результата выполнения запроса|
|`result_sets[].truncated`|Количество строк результата запроса превышает лимит и было обрезано|

## Ошибки {#errors}

Могут возникать [ошибки](common-information.md#errors), общие для всех методов.

## Пример { #example }

Запрос: 
```
curl -X 'GET' \
  'http://localhost:3000/v1/{folder_id}/queries/{query_id}' \
  -H 'accept: application/json'
}
```

Ответ: 

```json
{
  "name": "",
  "type": "ANALYTICS",
  "text": "select 1",
  "description": "",
  "meta": {
    "started_at": "2022-09-03T15:02:36.827Z",
    "finished_at": "2022-09-03T15:02:36.827Z"
  },
  "issues": [],
  "result_sets": [
    {
      "rows": 110,
      "truncated": false
    }
  ],
  "status": "FINISHED",
  "id": "csqugo80f0l35isue09b"
}
```