[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Object > DeleteObjects

# Object Storage API, REST совместимый с Amazon S3: DeleteObjects

Удаляет объекты по списку ключей, переданному в запросе.

Выполняется быстрее, чем удаление тех же объектов по одному отдельными запросами.

Список на удаление может содержать не более 1000 ключей.

Если объекта не существует, то Object Storage в ответе отметит его как удаленный.

Ответ можно настроить так, что Object Storage выдаст одну из выборок:

- Статусы всех операций удаления.
- Только статусы с ошибкой удаления. В этом случае, если не произошло ни одной ошибки, ответ будет пустым.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
POST /{bucket}?delete HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`delete` | Флаг, обозначающий операцию удаления.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Для данного запроса заголовки `Content-MD5` и `Content-Length` обязательны.

Также, если на версии объектов в версионируемом бакете установлены временные управляемые [блокировки](../../../concepts/object-lock.md) (governance-mode retention), обязательно используйте заголовок, описанный ниже, чтобы обойти блокировки и подтвердить удаление. Удалить версию объекта с блокировкой может только пользователь с [ролью `storage.admin`](../../../security/index.md). Проверить блокировку можно с помощью метода [getObjectRetention](getobjectretention.md).

Заголовок | Описание
--- | ---
`X-Amz-Bypass-Governance-Retention` | Заголовок, подтверждающий обход временной управляемой блокировки. Укажите значение `true`.

### Схема данных {#request-scheme}

Перечень ключей на удаление передается в XML формате.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Delete>
    <Quiet>true</Quiet>
    <Object>
         <Key>Key</Key>
    </Object>
    ...
</Delete>
```

Тег | Описание
----- | -----
`Delete` | Содержит тело ответа.<br/><br/>Путь: `/Delete`.
`Quiet` | `<Quiet>true</Quiet>` устанавливает <q>тихий</q> режим.<br/><br/>Object Storage запишет в ответ только ошибки удаления. Если ошибок нет, запрос не возвращает тело ответа. Если на момент запроса указанный в нем объект не существует, вернется результат `Deleted`.<br/><br/>Если не указан, то значение по умолчанию — `false`.<br/><br/>Путь: `/Delete/Quiet`.
`Object` | Содержит параметры удаления объекта.<br/><br/>Путь: `/Delete/Object`.
`Key` | [Ключ объекта](../../../concepts/object.md#key).<br/><br/>Путь: `/Delete/Object/Key`.
`VersionId` | Идентификатор [версии объекта](../../../concepts/versioning.md). Например, для удаления сразу нескольких версий объекта.<br/><br/>Путь: `/Delete/Object/VersionId`.


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Структура данных {#response-scheme}

```xml
<DeleteResult>
  <Deleted>
    <Key>some/key.txt</Key>
  </Deleted>
  <Error>
    <Key>some/another/key.txt</Key>
    <Code>TextErrorCode</Code>
    <Message>Describing message</Message>
  </Error>
</DeleteResult>
```

Тег | Описание
----- | -----
`DeleteResult` | Тело ответа.<br/><br/>Путь: `/DeleteResult`.
`Deleted` | Успешно удаленный объект.<br/><br/>Отсутствует, если в запросе был выставлен `<Quiet>true</Quiet>`.<br/><br/>Путь: `/DeleteResult/Deleted`.
`Key` | Ключ объекта.<br/><br/>Путь: `/DeleteResult/Deleted/Key` или `/DeleteResult/Error/Key`
`Error` | Ошибка удаления объекта.<br/><br/>Путь: `/DeleteResult/Error`.
`Code` | Код ошибки.<br/>Путь: `/DeleteResult/Error/Code`.
`Message` | Описание ошибки.<br/>Путь: `/DeleteResult/Error/Message`.

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Удаление всех объектов из бакета](../../../operations/objects/delete-all.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)