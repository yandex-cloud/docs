# Object Storage API, REST совместимый с Amazon S3: DeleteBucketWebsite

Удаляет конфигурацию хостинга статических сайтов для бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
DELETE /{bucket}?website HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#parameters}

{% include [query-parameters](../../../_includes_service/storage-hosting-query-parameters.md) %}

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Если конфигурация хостинга не существует, то {{ objstorage-name }} ответит кодом 200.

#### Связанные статьи {#related-articles}

[{#T}](../../../operations/hosting/setup.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
