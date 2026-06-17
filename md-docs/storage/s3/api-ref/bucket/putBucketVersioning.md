# Object Storage API, REST совместимый с Amazon S3: PutBucketVersioning

Включает или приостанавливает версионирование бакета.

Версионирование можно установить в одно из двух состояний:
- `Enabled` — включить управление версиями для объектов в бакете. Все новые объекты, добавляемые в бакет, будут получать уникальный идентификатор версии.
- `Suspended` — приостанавливает управление версиями для объектов в бакете. Все новые объекты, добавляемые в бакет, будут получать идентификатор версии = `null`.

{% note info %}

При включенной [блокировке версии объекта](../../../concepts/object-lock.md) версионирование нельзя приостановить.

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}?versioning HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versioning` | Обязательный параметр для обозначения типа операции.

### Схема данных {#request-scheme}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

Элемент | Описание
----- | -----
`Status` | Состояние опции версионирования бакета.<br/><br/>Тип: Строка<br/>Возможные значения: `Enabled \| Suspended`

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

* [Управление версионированием бакета](../../../operations/buckets/versioning.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)