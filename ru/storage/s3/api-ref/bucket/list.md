# Object Storage API, REST совместимый с Amazon S3: ListBuckets

Возвращает перечень бакетов, доступных пользователю.

{% include [sa-acl-bucket-list-note.md](../../../../_includes/storage/sa-acl-bucket-list-note.md) %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET / HTTP/2
```

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```xml
<ListAllMyBucketsResult>
  <Buckets>
    <Bucket>
      <Name>bucket-name</Name>
      <CreationDate>date_time</CreationDate>
    </Bucket>
    ...
  </Buckets>
</ListAllMyBucketsResult>
```

#|
|| **Элемент** | **Описание** ||
|| `Bucket` | Содержит описание бакета.

Путь: `/ListAllMyBucketsResult/Buckets/Bucket`. ||
|| `Buckets` | Содержит перечень бакетов.

Путь: `/ListAllMyBucketsResult/Buckets`. ||
|| `CreationDate` | Время создания бакета в формате `yyyy-mm-ddThh:mm:ss.timezone`.

Путь: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`. ||
|| `ListAllMyBucketsResult` | Корневой элемент ответа.

Путь: `/ListAllMyBucketsResult`. ||
|| `Name` | Имя бакета.

Путь: `/ListAllMyBucketsResult/Buckets/Bucket/Name`. ||
|#

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/buckets/get-list.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
