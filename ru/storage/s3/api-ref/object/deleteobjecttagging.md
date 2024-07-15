# Метод deleteObjectTagging

Удаляет все [метки](../../../concepts/tags.md) объекта в бакете. 

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

## Запрос {#request}

```http
DELETE /{bucket}/{key}?tagging&versionId={versionId} HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Тип операции. Обязательный параметр.
`versionId` | Идентификатор [версии объекта](../../../concepts/versioning.md). Обязательный параметр.

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Кроме [общих заголовков](../common-response-headers.md), ответ может содержать:

Заголовок | Описание
--------- | --------
`x-amz-version-id` | Идентификатор версии объекта.

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}