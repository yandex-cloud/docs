# Обзор работы с {{ yq-full-name }} HTTP API

С помощью {{ yq-short-name }} HTTP API можно выполнять разовые операции, а также автоматизировать рутинные действия, например, выполнять запросы к данным из скриптов или программ по расписанию.

[Методы](methods/index.md) {{ yq-short-name }} HTTP API позволяют создавать и запускать запросы к данным, получать статусы выполнения запросов и их результаты, останавливать запросы. Для выполнения запросов к API необходимо [аутентифицироваться](auth.md).

Ниже приведены общие подходы к работе с {{ yq-short-name }} HTTP API:

* [Заголовки](#headers)
* [Ошибки](#errors)

## Заголовки {#headers}

При работе с HTTP API часть заголовков является обязательной, а часть — нет.

### Обязательные заголовки {#mandatory-headers}

| Название | Описание |
| --- | --- |
| `Authorization` | [Параметры аутентификации](auth.md).<br>Тип: строка.<br>Пример: `Authorization: Bearer <IAM-токен>`. |

### Необязательные заголовки {#optional-headers}

| Название | Описание |
| --- | --- |
| `x-request-id` | Используется для диагностики запросов. В качестве значения можно указывать произвольное строковое значение. Рекомендуем указывать высокоуникальные значения (например, Guid) для избежания коллизий с идентификаторами диагностики других запросов.<br>Тип: строка.<br>Пример: `c8b4c0aa-8fc2-4159-8870-f4cb40b73aae`. |
| `Idempotency-Key` | [Ключ идемпотентности](../../api-design-guide/concepts/idempotency.md). Используется в модифицирующих операциях. Рекомендуем указывать этот параметр для избежания неожиданных ситуаций.<br>Тип: строка, UUID.<br>Пример: `Idempotency-Key: c1700de3-b8cb-4d8a-9990-e4ebf052e9aa`. |

## Ошибки {#errors}

При возникновении ошибок {{ yq-full-name }} возвращает детальное описание ошибки в Json-объекте:

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
        ]
        }
    ]
}
```

Поля Json-объекта с ошибками:

| Название | Тип | Описание | Пример |
| --- | --- | --- | --- |
| `message` | Строка | Общее описание ошибки | "Failed to parse query" |
| `details` | Массив объектов [`Issue`](#issue) | Детальное описание строки с ошибкой | |

### Объект Issue {#issue}

При возникновении ошибки {{ yq-full-name }} возвращает детальную информацию о месте возникновения ошибки, контексте и номерах строк SQL-запроса, содержащих ошибку. Результат возвращается в виде экземпляра объекта `Issue`.

Информация об ошибках может быть иерархической, то есть более общая `Issue` может содержать несколько детальных `Issue` с более подробным описанием и так далее.

{% cut "Пример иерархических ошибок" %}

```json
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

Поля объекта `Issue`:

| Название | Тип | Описание | Пример |
| --- | --- | --- | --- |
| `message` | Строка | Общее описание ошибки | "Failed to parse query" |
| `severity` | Число | Критичность ошибки. Возможные значения: `Info`, `Warn`, `Error`, `Fatal` | `Warn` |
| `position.row` | Число | Номер строки начала блока кода, вызвавшего ошибку | 1 |
| `position.column` | Число | Номер символа в строке `position.row` | 1 |
| `endPosition.row` | Число | Номер строки конца блока кода, вызвавшего ошибку | 1 |
| `endPosition.column` | Число | Номер символа в строке `endPosition.row` | 1 |
| `Issues` | Массив | Массив вложенных `Issue` с детализацией ошибок | |
