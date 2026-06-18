# Object Storage API, REST совместимый с Amazon S3: PutBucketTagging

Добавляет [метки](../../../concepts/tags.md) бакету. При этом перезаписываются все имеющиеся у бакета метки.

{% note info %}

В терминологии Yandex Cloud для логической маркировки ресурсов используется понятие _метка_ (_label_). Object Storage поддерживает совместимость с [Amazon S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html), поэтому в командах для [AWS CLI](../../../tools/aws-cli.md) и в параметрах [API](../../index.md) применяется термин AWS — _тег_ (_tag_).

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}?tagging HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Обязательный параметр для обозначения типа операции.

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

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)

* [Добавление или изменение меток бакета](../../../operations/buckets/tagging.md#add-edit-tag)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)