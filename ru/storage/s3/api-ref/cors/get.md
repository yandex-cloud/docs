# Object Storage API, REST совместимый с Amazon S3: GetBucketCors

Возвращает конфигурацию CORS для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?cors HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#request-params}

{% include [query-parameters](../../../_includes_service/storage-cors-query-parameters.md) %}

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

### Схема данных {#response-scheme}

Возвращаемые данные имеют ту же структуру, которую имеют данные, передаваемые методом [upload](upload.md).

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/cors.md)

* [{#T}](../../../operations/buckets/cors.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
