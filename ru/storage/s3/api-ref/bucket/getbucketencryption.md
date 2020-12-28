# Метод getBucketEncryption

Возвращает информацию о шифровании бакета. Подробнее о шифровании бакета читайте в разделе [{#T}](../../../operations/buckets/encrypt.md).


## Запрос {#request}

```
GET /{bucket}?encryption HTTP/1.1
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

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
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
`KMSMasterKeyID` | Идентификатор [ключа {{ kms-short-name }}](../../../../kms/concepts/key.md).<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\KMSMasterKeyID`.
`Rule` | Правило шифрования на стороне сервера. <br/><br/>Шифрование определяется элементами `KMSMasterKeyID` и `SSEAlgorithm`.<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule`.
`ServerSideEncryptionConfiguration` | Конфигурация шифрования, по умолчанию применяемая к новым объектам в бакете.<br/><br/>Путь: `ServerSideEncryptionConfiguration`.
`SSEAlgorithm` | Алгоритм шифрования. Доступные значения: `aws:kms`.<br/><br/>Путь: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`.