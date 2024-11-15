---
title: Метод getBucketLogging
description: Из статьи вы узнаете, что такое метод getBucketLogging, как выглядит его запрос и ответ.
---

# Метод getBucketLogging


Возвращает настройки [логирования действий с бакетом](../../../concepts/server-logs.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?logging HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя [бакета](../../../concepts/bucket.md).

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`logging` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#structure}

Ответ, если логирование действий с бакетом не настроено:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<BucketLoggingStatus xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<!--<LoggingEnabled><TargetBucket>bucket-logs</TargetBucket><TargetPrefix>add/this/prefix/to/my/log/files/access_log-</TargetPrefix></LoggingEnabled>-->
</BucketLoggingStatus>
```

Ответ, если логирование действий с бакетом настроено:

```xml
<?xml version="1.0" encoding="UTF-8"?>
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
`TargetBucket` | Имя целевого бакета, в который сохраняются [объекты](../../../concepts/object.md) с логами.<br>Путь: `/BucketLoggingStatus/LoggingEnabled/TargetBucket`.<br>Тип: String.
`TargetPrefix` | [Префикс ключа объекта](../../../concepts/server-logs.md#key-prefix) с логами.<br>Путь: `/BucketLoggingStatus/LoggingEnabled/TargetPrefix`.<br>Тип: String.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}