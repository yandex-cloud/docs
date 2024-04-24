# get-query

Метод возвращает информацию о запросе, включая метаинформацию о запросе, статус его выполнения и объем результатов.

{% include [!](../../_includes/api-common.md) %}

## Запрос {#request}

`GET`-запрос на адрес `/queries/{query_id}?project={folder_id}`, где `{folder_id}` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), а `{query_id}` — идентификатор запроса.

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 200 и информацией о запросе.

```json
{
  "name": "<название_запроса>",
  "type": "<тип_запроса>",
  "text": "<текст_запроса>",
  "description": "<описание>",
  "meta": {
    "started_at": "2022-09-03T14:53:00.067Z",
    "finished_at": "2022-09-03T14:53:00.067Z"
  },
  "issues": {
    "details": [
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

Поле | Описание
--- | ---
`name` | Название запроса.
`type` | Тип запроса: `STREAMING` — потоковый, `ANALYTICS` — аналитический.
`text` | Текст запроса.
`description` | Описание запроса.
`meta.started_at` | Момент начала выполнения запроса.
`meta.finished_at` | Момент завершения выполнения запроса.
`issues` | При наличии ошибок выполнения, содержит объект [`Issue`](../index.md#issue).
`result_sets` | Массив результатов выполнения запроса.
`result_sets[].rows` | Количество строк результата выполнения запроса.
`result_sets[].truncated` | Количество строк результата запроса превышает лимит и было обрезано.

## Пример {#example}

Запрос:

```json
curl -X 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********?project=b1gaue5b382m********' \
  -H 'accept: application/json'
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
  "id": "csqugo80f0l3********"
}
```