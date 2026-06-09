# Object Storage API, REST совместимый с Amazon S3: DeleteBucketTagging

Удаляет [метки](../../../concepts/tags.md) бакета.

{% note info %}

В терминологии {{ yandex-cloud }} для логической маркировки ресурсов используется понятие _метка_ (_label_). {{ objstorage-name }} поддерживает совместимость с [Amazon S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html), поэтому в командах для [AWS CLI](../../../tools/aws-cli.md) и в параметрах [API](../../index.md) применяется термин AWS — _тег_ (_tag_).

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
DELETE /{bucket}?tagging HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя бакета.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [Удаление меток бакета](../../../operations/buckets/tagging.md#delete-tag)

#### См. также {#see-also}

* [{#T}](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)