# Метод getBucketVersioning

Возвращает состояние опции версионирования бакета.

## Запрос {#request}

```
GET /{bucket}?versioning HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versioning` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}
Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#structure}
```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

Элемент | Описание
----- | -----
`VersioningConfiguration` | Корневой элемент.
`Status` | Состояние опции версионирования бакета.<br/><br/>Путь:`/VersioningConfiguration/Status`<br/>Тип: Строка<br/>Возможные значения: `Enabled | Suspended`

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}