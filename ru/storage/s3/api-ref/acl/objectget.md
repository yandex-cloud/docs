# Метод objectGetAcl

Возвращает список управления доступом для объекта.

## Запрос {#request}

```http
GET /{bucket}/{key}?acl HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`acl` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Схема данных {#response-scheme}

Возвращаемые данные имеют структуру, описанную в разделе [XML-схема ACL](xml-config.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}