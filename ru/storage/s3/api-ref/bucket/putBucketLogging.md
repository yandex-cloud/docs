# Метод putBucketLogging


Включает и выключает [механизм логирования действий с бакетом](../../../concepts/server-logs.md).

## Запрос {#request}

```http
PUT /{bucket}?logging HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя [бакета](../../../concepts/bucket.md).

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`logging` | Обязательный параметр для обозначения типа операции.

### Схема данных {#request-scheme}

**Чтобы включить механизм логирования действий с бакетом**:

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<BucketLoggingStatus xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <LoggingEnabled>
      <TargetBucket>bucket-logs</TargetBucket>
      <TargetPrefix>logs/</TargetPrefix>
   </LoggingEnabled>
</BucketLoggingStatus>
```

Элемент | Описание
--- | ---
`BucketLoggingStatus` | Корневой элемент.
`TargetBucket` | Имя целевого бакета, в который сохраняются [объекты](../../../concepts/object.md) с логами.<br>Тип: String.
`TargetPrefix` | [Префикс ключа объекта](../../../concepts/server-logs.md#key-prefix) с логами.<br>Тип: String.

**Чтобы выключить механизм логирования действий с бакетом**:

```xml
<BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
```

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.
