# Object Storage API, REST совместимый с Amazon S3: GetBucketVersioning

Возвращает состояние опции версионирования бакета.

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
GET /{bucket}?versioning HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versioning` | Обязательный параметр для обозначения типа операции.

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

Элемент | Описание
----- | -----
`VersioningConfiguration` | Корневой элемент.
`Status` | Состояние опции версионирования бакета.<br/><br/>Путь:`/VersioningConfiguration/Status`<br/>Тип: Строка<br/>Возможные значения: `Enabled | Suspended`

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/buckets/versioning.md)

#### См. также {#see-also}

* [{#T}](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)