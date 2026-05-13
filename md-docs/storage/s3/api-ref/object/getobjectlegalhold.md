# Object Storage API, REST совместимый с Amazon S3: GetObjectLegalHold

Возвращает настройки бессрочной [блокировки](../../../concepts/object-lock.md), установленной на версию объекта.

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```
GET /{bucket}/{key}?legal-hold&versionId={versionId} HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query-параметры {#request-params}

Параметр | Описание
----- | -----
`legal-hold` | Обязательный параметр для обозначения типа операции.
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
<LegalHold xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Status>string</Status>
</LegalHold>
```

Элемент | Описание
----- | -----
`Status` | <p>Статус бессрочной блокировки:</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>Путь: `LegalHold\Status`.</p>

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Блокировка версии объекта (object lock)](../../../concepts/object-lock.md)

* [Настройка блокировок версии объекта](../../../operations/objects/edit-object-lock.md)

#### См. также {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)