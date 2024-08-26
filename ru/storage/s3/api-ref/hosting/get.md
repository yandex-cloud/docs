# Метод get

Возвращает конфигурацию хостинга статических сайтов для бакета.


## Запрос {#request}

```http
GET /{bucket}?website HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`website` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

### Схема данных {#response-scheme}

Возвращаемые данные имеют ту же структуру, которую имеют данные, передаваемые методом [upload](upload.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}