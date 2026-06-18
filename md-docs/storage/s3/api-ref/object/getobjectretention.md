# Object Storage API, REST совместимый с Amazon S3: GetObjectRetention

Возвращает настройки временной [блокировки](../../../concepts/object-lock.md), установленной на версию объекта.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
GET /{bucket}/{key}?retention&versionId={versionId} HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query-параметры {#request-params}

Параметр | Описание
----- | -----
`retention` | Обязательный параметр для обозначения типа операции.
`versionId` | Идентификатор версии объекта. Обязательный параметр.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

### Схема данных {#response-schema}

```xml
<Retention xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Mode>string</Mode>
    <RetainUntilDate>timestamp</RetainUntilDate>
</Retention>
```

Элемент | Описание
----- | -----
`Mode` | <p>[Тип](../../../concepts/object-lock.md#types) блокировки:</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>Путь: `Retention\Mode`.</p>
`RetainUntilDate` | <p>Дата и время окончания блокировки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Например, `2025-01-01T00:00:00`. Конец блокировки указывается в часовом поясе [UTC±00:00](https://ru.wikipedia.org/wiki/UTC±00:00). Чтобы указать другой часовой пояс, добавьте к концу записи `+` или `-` и смещение от UTC±00:00.</p><p>Путь: `Retention\RetainUntilDate`.</p>

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Блокировка версии объекта (object lock)](../../../concepts/object-lock.md)

* [Настройка блокировок версии объекта](../../../operations/objects/edit-object-lock.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)