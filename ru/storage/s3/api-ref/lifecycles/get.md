# Метод get

Возвращает конфигурацию жизненных циклов объектов в бакете из {{ objstorage-name }}.

## Запрос {#request}

```http
GET /{bucket}?lifecycle HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`lifecycle` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Если конфигурации не существует, то {{ objstorage-name }} возвращает ошибку 404 с кодом `NoSuchLifecycleConfiguration`.

Перечень других возможных ответов смотрите в разделе [{#T}](../response-codes.md).

### Схема данных {#response-scheme}

Возвращаемые данные имеют ту же структуру, которую имеют данные, передаваемые методом [upload](upload.md). Структура описана в разделе [{#T}](xml-config.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}