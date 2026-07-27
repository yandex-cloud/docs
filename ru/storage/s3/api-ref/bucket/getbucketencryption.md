# Object Storage API, REST совместимый с Amazon S3: GetBucketEncryption

Возвращает информацию о шифровании бакета. Подробнее о шифровании бакета читайте в разделе [{#T}](../../../concepts/encryption.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?encryption HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

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
<ServerSideEncryptionConfiguration>
   <Rule>
      <ApplyServerSideEncryptionByDefault>
         <KMSMasterKeyID>string</KMSMasterKeyID>
         <SSEAlgorithm>string</SSEAlgorithm>
      </ApplyServerSideEncryptionByDefault>
   </Rule>
   ...
</ServerSideEncryptionConfiguration>
```

#|
|| **Элемент** | **Описание** ||
|| `ApplyServerSideEncryptionByDefault` | Указание применить к объекту шифрование по умолчанию, если в запросе не указаны другие параметры шифрования.

Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault`. ||
|| `KMSMasterKeyID` | Идентификатор [ключа {{ kms-short-name }}](../../../../kms/concepts/key.md).

Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\KMSMasterKeyID`. ||
|| `Rule` | Правило шифрования на стороне сервера.

Шифрование определяется элементами `KMSMasterKeyID` и `SSEAlgorithm`.

Путь: `ServerSideEncryptionConfiguration\Rule`. ||
|| `ServerSideEncryptionConfiguration` | Конфигурация шифрования, по умолчанию применяемая к новым объектам в бакете.

Путь: `ServerSideEncryptionConfiguration`. ||
|| `SSEAlgorithm` | Алгоритм шифрования. Доступные значения: `aws:kms`.

Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`. ||
|#

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/buckets/encrypt.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
