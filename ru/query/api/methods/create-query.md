# create-query

Метод создает запрос к данным и запускает его выполнение. После этого запрос переходит в статус `RUNNING`. Результат можно [получить](get-query-results.md) только после успешного выполнения запроса. Чтобы узнать статус выполнения запроса, используйте метод [get-query-status](get-query-status.md).

{% include [!](../../_includes/api-common.md) %}

## Запрос {#request}

`POST`-запрос на адрес `/queries?project={folder_id}`, где `{folder_id}` — идентификатор каталога.

Тело запроса содержит данные в формате JSON:

```json
{
  "name": "human readable default name",
  "type": "ANALYTICS",
  "text": "string",
  "description": ""
}
```

| Поле | Описание | Допустимые значения | Примечание |
| ----- | ----- | ----- | ----- |
| `name` | Название запроса | | Если параметр не указан, будет присвоено название по умолчанию |
| `type` | Тип запроса | `STREAMING` — потоковый, `ANALYTICS` — аналитический | Значение по умолчанию: `ANALYTICS` |
| `text` | Текст запроса | Строка | Обязательный |
| `description` | Описание запроса | | Значение по умолчанию: пустая строка |

## Ответ {#response}

В случае успеха возвращается HTTP-ответ с кодом 200 и идентификатором запроса.

```json
{
  "id": "string"
}
```

| Поле | Описание | Примечание |
| ----- | ----- | ----- |
| `id` | Идентификатор созданного запроса | Обязательный |

## Пример {#example}

Запрос:

```json
curl -X 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Test query",
    "type": "ANALYTICS",
    "text": "select 1",
    "description": ""
  }'
```

Ответ:

```json
{
  "id": "csqugo80f0l35isue09b"
}
```
