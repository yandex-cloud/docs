# Object Storage API, REST совместимый с Amazon S3: GetBucketVersioning

Возвращает состояние опции версионирования бакета.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?versioning HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query параметры {#request-params}

#|
|| **Параметр** | **Описание** ||
|| `versioning` | Обязательный параметр для обозначения типа операции ||
|#

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#structure}
```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

#|
|| **Элемент** | **Описание** ||
|| `VersioningConfiguration` | Корневой элемент. ||
|| `Status` | Состояние опции версионирования бакета.

Путь:`/VersioningConfiguration/Status`.
Тип: String.
Возможные значения: `Enabled` \| `Suspended`. ||
|#

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/buckets/versioning.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
