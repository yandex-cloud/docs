# Object Storage API, REST совместимый с Amazon S3: GetBucketLifecycleConfiguration

Возвращает конфигурацию жизненных циклов объектов в бакете из {{ objstorage-name }}.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?lifecycle HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#request-params}

{% include [lifecycles-query-parameters](../../../_includes_service/storage-lifecycles-query-parameters.md) %}

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

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/lifecycles.md)

* [{#T}](../../../operations/buckets/lifecycles.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
