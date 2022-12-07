# Метод getObjectLegalHold

Возвращает настройки бессрочной [блокировки](../../../concepts/object-lock.md), установленной на версию объекта.

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

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).


### Схема данных {#response-schema}

```xml
<LegalHold xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Status>string</Status>
</LegalHold>
```

Элемент | Описание
----- | -----
`Status` | <p>Статус бессрочной блокировки:</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>Путь: `LegalHold\Status`.</p>