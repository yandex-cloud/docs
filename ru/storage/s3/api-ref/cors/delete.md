# Object Storage API, REST совместимый с Amazon S3: DeleteBucketCors

Удаляет конфигурацию CORS для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
DELETE /{bucket}?cors HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#parameters}

{% include [query-parameters](../../../_includes_service/storage-cors-query-parameters.md) %}

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Если конфигурация CORS не существует, то {{ objstorage-name }} ответит кодом `204 No Content`.

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/cors.md)

* [{#T}](../../../operations/buckets/cors.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
