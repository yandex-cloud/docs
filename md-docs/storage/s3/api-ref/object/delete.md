# Object Storage API, REST совместимый с Amazon S3: DeleteObject

Удаляет объект.

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
DELETE /{bucket}/{key} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versionId` | Ссылка на конкретную версию объекта.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также, если на версию объекта в версионируемом бакете установлена временная управляемая [блокировка](../../../concepts/object-lock.md) (governance-mode retention), обязательно используйте заголовок, описанный ниже, чтобы обойти блокировку и подтвердить удаление. Удалить версию объекта с блокировкой может только пользователь с [ролью `storage.admin`](../../../security/index.md). Проверить блокировку можно с помощью метода [getObjectRetention](getobjectretention.md).

Заголовок | Описание
--- | ---
`X-Amz-Bypass-Governance-Retention` | Заголовок, подтверждающий обход временной управляемой блокировки. Укажите значение `true`.


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Удаление объекта](../../../operations/objects/delete.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)