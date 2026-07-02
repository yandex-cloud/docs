[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > ACL > PutObjectAcl

# Object Storage API, REST совместимый с Amazon S3: PutObjectAcl

Загружает список управления доступом для объекта.

{% note info %}

ACL можно загрузить в виде XML-документа или с помощью специальных заголовков `X-Amz-Grant*`. Не используйте XML-документ и заголовки `X-Amz-Grant*` в одном запросе.

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}/{key}?acl HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Идентификатор, под которым объект будет сохранен в Object Storage.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`acl` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также можно использовать заголовки, перечисленные ниже.

Заголовок | Описание
--- | ---
`X-Amz-Acl` | Устанавливает [предопределенный ACL](../../../concepts/acl.md#predefined-acls) для объекта.
`X-Amz-Grant-Read` | Устанавливает получателю доступа разрешение на чтение объекта.
`X-Amz-Grant-Read-Acp` | Устанавливает получателю доступа разрешение на чтение ACL объекта.
`X-Amz-Grant-Write-Acp` | Устанавливает получателю доступа разрешение на запись ACL объекта.
`X-Amz-Grant-Full-Control` | Устанавливает получателю доступа разрешения: `READ`, `WRITE`, `READ_ACP`, `WRITE_ACP` на объект.

Значение для заголовков `X-Amz-Grant-*` представляет собой разделенный запятыми список получателей доступа. Каждый получатель доступа идентифицируется структурой вида `<тип_получателя_доступа>:<идентификатор_получателя_доступа>`. Object Storage поддерживает следующие типы получателей:
* `id` — получатель доступа — пользователь облака.
* `uri` — получатель доступа — публичная группа.

Пример:

```http
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```

### Схема данных {#data-schema}

ACL передается в виде XML-документа. Описание схемы смотрите в разделе [XML-схема ACL](xml-config.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Список управления доступом (ACL)](../../../concepts/acl.md)

* [Редактирование ACL объекта](../../../operations/objects/edit-acl.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)