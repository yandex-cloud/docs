# Object Storage API, REST совместимый с Amazon S3: PutBucketEncryption

Добавляет шифрование бакету. Объекты, добавляемые в этот бакет, будут по умолчанию шифроваться указанным [ключом KMS](../../../../kms/concepts/key.md). Подробнее о шифровании бакета читайте в разделе [Шифрование в Object Storage](../../../concepts/encryption.md).

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}?encryption HTTP/2
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

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

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

Элемент | Описание
----- | -----
`ApplyServerSideEncryptionByDefault` | Указание применить к объекту шифрование по умолчанию, если в запросе не указаны другие параметры шифрования.<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault`.
`KMSMasterKeyID` | Идентификатор [ключа KMS](../../../../kms/concepts/key.md).<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\KMSMasterKeyID`.
`Rule` | Правило шифрования на стороне сервера. <br/><br/>Шифрование определяется элементами `KMSMasterKeyID` и `SSEAlgorithm`.<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule`.
`ServerSideEncryptionConfiguration` | Конфигурация шифрования, по умолчанию применяемая к новым объектам в бакете.<br/><br/>Путь: `ServerSideEncryptionConfiguration`.
`SSEAlgorithm` | Алгоритм шифрования. Доступные значения: `aws:kms`.<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`.

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)

* [Добавление шифрования бакету](../../../operations/buckets/encrypt.md#add)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)