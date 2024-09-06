# Метод deleteMultipleObjects

Удаляет объекты по списку ключей, переданному в запросе.

Выполняется быстрее, чем удаление тех же объектов по одному отдельными запросами.

Список на удаление может содержать не более 1000 ключей.

Если объекта не существует, то {{ objstorage-name }} в ответе отметит его как удаленный.

Ответ можно настроить так, что {{ objstorage-name }} выдаст одну из выборок:

- Статусы всех операций удаления.
- Только статусы с ошибкой удаления. В этом случае, если не произошло ни одной ошибки, ответ будет пустым.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

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
`Quiet` | `<Quiet>true</Quiet>` устанавливает <q>тихий</q> режим.<br/><br/>{{ objstorage-name }} запишет в ответ только ошибки удаления. Если ошибок нет, запрос не возвращает тело ответа. Если на момент запроса указанный в нем объект не существует, вернется результат `Deleted`.<br/><br/>Если не указан, то значение по умолчанию — `false`.<br/><br/>Путь: `/Delete/Quiet`.
`Object` | Содержит параметры удаления объекта.<br/><br/>Путь: `/Delete/Object`.
`Key` | Ключ объекта.<br/><br/>Путь: `/Delete/Object/Key`.



## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

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

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}