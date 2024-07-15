# Метод putObjectLegalHold

Устанавливает на версию объекта бессрочную [блокировку](../../../concepts/object-lock.md) или снимает ее.

Чтобы на версии объектов можно было устанавливать блокировки, в бакете должен быть включен механизм блокировок. Включить его можно с помощью метода [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md).

Установить или снять блокировку могут пользователи с [ролью `storage.uploader`](../../../security/index.md). Проверить блокировку можно с помощью метода [getObjectLegalHold](getobjectlegalhold.md).

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

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}