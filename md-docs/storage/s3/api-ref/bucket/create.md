[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Bucket > CreateBucket

# Object Storage API, REST совместимый с Amazon S3: CreateBucket

Создает бакет.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.<br/><br/>При создании бакета помните об [ограничениях на имя](../../../concepts/bucket.md#naming).

### Заголовки {#request-headers}
Используйте в запросе [общие заголовки](../common-request-headers.md).

С помощью заголовков, перечисленных ниже, можно установить [ACL](../../../concepts/acl.md) создаваемого бакета.

Заголовок | Описание
--- | ---
`X-Amz-Acl` | Устанавливает [виды разрешений](../../../concepts/acl.md#permissions-types) для бакета.
`X-Amz-Grant-Read` | Устанавливает получателю доступа разрешение на просмотр содержимого бакета и разрешение на чтение объектов в бакете.
`X-Amz-Grant-Write` | Устанавливает получателю доступа разрешение на запись объектов. Используйте обязательно вместе с `X-Amz-Grant-Read`, иначе Object Storage ответит с кодом `501 Not Implemented`.
`X-Amz-Grant-Read-Acp` | Устанавливает получателю доступа разрешение на чтение ACL бакета.
`X-Amz-Grant-Write-Acp` | Устанавливает получателю доступа разрешение на запись ACL бакета.
`X-Amz-Grant-Full-Control` | Устанавливает получателю доступа разрешения: `READ`, `WRITE`, `READ_ACP`, `WRITE_ACP` на бакет.

Значение для заголовков `X-Amz-Grant-*` представляет собой список получателей доступа, разделенный запятыми. Каждый получатель доступа идентифицируется структурой вида `<тип_получателя_доступа>:<идентификатор_получателя_доступа>`. Object Storage поддерживает следующие типы получателей:
* `id` — получатель доступа — пользователь облака.
* `uri` — получатель доступа — публичная группа.

Пример:

```http
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)

* [Создание бакета](../../../operations/buckets/create.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)