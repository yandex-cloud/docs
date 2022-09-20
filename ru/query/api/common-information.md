# Общая информация

Ниже приведены общие подходы по работе с {{yq-full-name}} HTTP API:
- [Заголовки](#headers).
- [Ошибки](#errors).

## Заголовки { #headers }

При работе с HTTP API часть заголовков является обязательной, а часть - нет.

### Обязательные заголовки { #mandatory-headers }

Ниже приведены заголовки, которые необходимо указывать при работе с API:
|Название|Тип|Описание|Пример|
|---|---|---|---|
|`Authorization`|Строка|[Параметры аутентификации](auth.md)|`Authorization: Bearer <IAM-токен>`|

### Необязательные заголовки { #optional-headers }

Ниже приведены список необязательных заголовков HTTP API:

|Название|Тип|Описание|Пример|
|---|---|---|---|
|`x-request-id`|Строка|Используется для диагностики запросов. В качестве значения можно указывать произвольное строковое значение. Рекомендуем указывать высокоуникальные значения, типа Guid, для избежания коллизий с идентификаторами диагностики других запросов|`c8b4c0aa-8fc2-4159-8870-f4cb40b73aae`|
|`Idempotency-Key`|Строка, UUID|[Ключ идемпотентности](../../api-design-guide/concepts/idempotency.md). Используется в ряде модифицирующих операций. Настоятельно рекомендуем указывать этот параметр для избежания неожиданных ситуаций|`Idempotency-Key: c1700de3-b8cb-4d8a-9990-e4ebf052e9aa`|

## Ошибки { #errors }

При возникновении ошибок {{yq-full-name}} возвращает детальное описание ошибки в Json-объекте следующего вида:

```json
{
    "message": "Failed to parse query",
    "details": [
        {
        "position": {
            "row": 0,
            "column": 0
        },
        "message": "string",
        "end_position": {
            "row": 0,
            "column": 0
        },
        "issue_code": 0,
        "severity": "FATAL",
        "issues": [
            "string"
        ],
        "status": 0
        }
    ]
}
```

|Название|Тип|Описание|Пример|
|---|---|---|---|
|`message`|Строка|Общее описание ошибки|"Failed to parse query"|
|`details`|Массив объектов [`Issue`](#issue)|Детальное описание строки с ошибкой||

### Объект Issue { #issue }

При возникновении ошибки возвращается детальная информация про место возникновения ошибки, контекст, номера строк SQL-запроса, содержащие ошибку. Вся эта информация возвращается в виде экземпляра объекта `Issue`. 

Информация об ошибках может быть иерархической, то есть более общая `Issue` может содержать несколько детальных `Issue` с более подробным описанием и так далее. 

{% cut "Пример иерархических ошибок" %}

```
{
"issues": [
    {
    "issues": [
        {
        "position": {
            "column": 1,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 1,
            "row": 1
        },
        "message": "Column references are not allowed without FROM"
        },
        {
        "position": {
            "column": 8,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 8,
            "row": 1
        },
        "message": "Column reference 'x'"
        }
    ],
    "severity": 1,
    "message": "Parse Sql"
    },
    {
    "issues": [
        {
        "position": {
            "column": 1,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 1,
            "row": 1
        },
        "message": "Column references are not allowed without FROM"
        },
        {
        "position": {
            "column": 8,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 8,
            "row": 1
        },
        "message": "Column reference 'x'"
        }
    ],
    "severity": 1,
    "message": "Parse Sql"
    }
],
"severity": 1,
"message": "Failed to parse query"
}
```

{% endcut %}

Список полей объекта `Issue`:

|Название|Тип|Описание|Пример|
|---|---|---|---|
|`message`|Строка|Общее описание ошибки|"Failed to parse query"|
|`severity`|Число|Критичность ошибки. Возможные значения: Info, Warn, Error, Fatal||
|`position.row`|Число|Номер строки начала блока кода, вызвавшего ошибку||
|`position.column`|Число|Номер символа в строке `position.row` с блоком кода, вызвавшего ошибку||
|`endPosition.row`|Число|Номер строки конца блока кода, вызвавшего ошибку||
|`endPosition.column`|Число|Номер символа в строке `endPosition.row` с блоком кода, вызвавшего ошибку||
|`Issues`|Массив|Массив вложенных `Issue` с детализацией ошибок||
