# Метод deleteBucketEncryption

Убирает шифрование бакета. Подробнее о шифровании бакета читайте в разделе [{#T}](../../../concepts/encryption.md).

## Запрос {#request}

```
DELETE /{bucket}?encryption HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}