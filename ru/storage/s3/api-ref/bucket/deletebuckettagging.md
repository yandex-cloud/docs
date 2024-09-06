# Метод deleteBucketTagging

Удаляет [метки](../../../concepts/tags.md) бакета. 

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
DELETE /{bucket}?tagging HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя бакета.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}