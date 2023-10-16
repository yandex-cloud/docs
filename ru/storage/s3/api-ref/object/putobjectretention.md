# Метод putObjectRetention

Устанавливает на версию объекта временную [блокировку](../../../concepts/object-lock.md) либо настраивает или снимает уже установленную блокировку.

Чтобы на версии объектов можно было устанавливать блокировки, в бакете должен быть включен механизм блокировок. Включить его можно с помощью метода [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md).

Изменить установленную блокировку может только пользователь с [ролью `storage.admin`](../../../security/index.md). При изменении [управляемой блокировки](../../../concepts/object-lock.md#types) нужно использовать заголовок, подтверждающий обход блокировки (см. [ниже](#request-headers)). Строгую блокировку можно только продлить. Проверить блокировку можно с помощью метода [getObjectRetention](getobjectretention.md).

## Запрос {#request}

```
PUT /{bucket}/{key}?retention&versionId={versionId} HTTP/2
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

Также, если на версию объекта установлена [временная управляемая блокировка](../../../concepts/object-lock.md#types) (governance-mode retention), обязательно используйте заголовок, описанный ниже, чтобы обойти блокировку и подтвердить ее изменение.

Заголовок | Описание
--- | ---
`X-Amz-Bypass-Governance-Retention` | Заголовок, подтверждающий обход временной управляемой блокировки. Укажите значение `true`.

### Схема данных {#request-schema}

```xml
<Retention xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Mode>string</Mode>
    <RetainUntilDate>timestamp</RetainUntilDate>
</Retention>
```

Элемент | Описание
----- | -----
`Retention` | <p>Корневой элемент с настройками блокировки.</p><p>Чтобы снять управляемую блокировку (если у вас есть роль `storage.admin`), оставьте элемент пустым.</p><p>Путь: `Retention`.</p>
`Mode` | <p>[Тип](../../../concepts/object-lock.md#types) блокировки:</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>Путь: `Retention\Mode`.</p>
`RetainUntilDate` | <p>Дата и время окончания блокировки в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). Например, `2025-01-01T00:00:00`. Конец блокировки указывается в часовом поясе [UTC±00:00](https://ru.wikipedia.org/wiki/UTC±00:00). Чтобы указать другой часовой пояс, добавьте к концу записи `+` или `-` и смещение от UTC±00:00.</p><p>Путь: `Retention\RetainUntilDate`.</p>

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).
