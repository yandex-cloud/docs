# Object Storage API, REST совместимый с Amazon S3: GetBucketAcl

Возвращает список управления доступом для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?acl HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters-with-key](../../../_includes_service/storage-path-parameters-with-key.md) %}

### Query параметры {#request-params}

{% include [request-params](../../../_includes_service/storage-request-params.md) %}

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Схема данных {#response-scheme}

Возвращаемые данные имеют структуру, описанную в разделе [XML-схема ACL](xml-config.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/acl.md)

* [{#T}](../../../operations/buckets/edit-acl.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
