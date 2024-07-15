# Метод putBucketVersioning

Включает или приостанавливает версионирование бакета.

Версионирование можно установить в одно из двух состояний:
- `Enabled` — включить управление версиями для объектов в бакете. Все новые объекты, добавляемые в бакет, будут получать уникальный идентификатор версии.
- `Suspended` — приостанавливает управление версиями для объектов в бакете. Все новые объекты, добавляемые в бакет, будут получать идентификатор версии = `null`.

## Запрос {#request}

```
PUT /{bucket}?versioning HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versioning` | Обязательный параметр для обозначения типа операции.

### Схема данных {#request-scheme}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

Элемент | Описание
----- | -----
`Status` | Состояние опции версионирования бакета.<br/><br/>Тип: Строка<br/>Возможные значения: `Enabled \| Suspended`

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}