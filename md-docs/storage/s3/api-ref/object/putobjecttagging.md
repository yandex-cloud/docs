# Object Storage API, REST совместимый с Amazon S3: PutObjectTagging

Добавляет [метки](../../../concepts/tags.md) объекту в бакете. При этом перезаписываются все имеющиеся у объекта метки.

{% note info %}

В терминологии {{ yandex-cloud }} для логической маркировки ресурсов используется понятие _метка_ (_label_). {{ objstorage-name }} поддерживает совместимость с [Amazon S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html), поэтому в командах для [AWS CLI](../../../tools/aws-cli.md) и в параметрах [API](../../index.md) применяется термин AWS — _тег_ (_tag_).

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}/{key}?tagging&versionId={versionId} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Тип операции. Обязательный параметр.
`versionId` | Идентификатор [версии объекта](../../../concepts/versioning.md). Обязательный параметр.

### Схема данных {#request-scheme}

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<Tagging xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <TagSet>
      <Tag>
         <Key>string</Key>
         <Value>string</Value>
      </Tag>
   </TagSet>
</Tagging>
```

Элемент | Описание
--- | ---
`Tagging` | Корневой элемент.
`TagSet` | Массив меток.
`Tag` | Контейнер для метки.
`Key` | Ключ метки.<br>Тип: string.
`Value` | Значение метки.<br>Тип: string.

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Кроме [общих заголовков](../common-response-headers.md), ответ может содержать:

Заголовок | Описание
--------- | --------
`x-amz-version-id` | Идентификатор версии объекта.

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/object.md)

* [{#T}](../../../operations/objects/tagging.md)

#### См. также {#see-also}

* [{#T}](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)