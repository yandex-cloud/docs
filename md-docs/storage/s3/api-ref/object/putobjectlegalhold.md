[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Object > PutObjectLegalHold

# Object Storage API, REST совместимый с Amazon S3: PutObjectLegalHold

Устанавливает на версию объекта бессрочную [блокировку](../../../concepts/object-lock.md) или снимает ее.

Чтобы на версии объектов можно было устанавливать блокировки, в бакете должен быть включен механизм блокировок. Включить его можно с помощью метода [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md).

Установить или снять блокировку могут пользователи с [ролью `storage.uploader`](../../../security/index.md). Проверить блокировку можно с помощью метода [getObjectLegalHold](getobjectlegalhold.md).

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```
PUT /{bucket}/{key}?legal-hold&versionId={versionId} HTTP/2
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

### Схема данных {#request-schema}

```xml
<LegalHold xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Status>string</Status>
</LegalHold>
```

Элемент | Описание
----- | -----
`Status` | <p>Статус бессрочной блокировки:</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>Путь: `LegalHold\Status`.</p>

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Блокировка версии объекта (object lock)](../../../concepts/object-lock.md)

* [Настройка блокировок версии объекта](../../../operations/objects/edit-object-lock.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)