# Метод getBucketTagging

Возвращает [метки](../../../concepts/tags.md) бакета. 

{% include [labels-tags](../../../../_includes/storage/labels-tags.md) %}

## Запрос {#request}

```http
GET /{bucket}?tagging HTTP/2
```

### Path-параметры {#path-parameters}

Параметр | Описание
--- | ---
`bucket` | Имя бакета.

### Query-параметры {#request-params}

Параметр | Описание
--- | ---
`tagging` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которых описана ниже.

### Схема данных {#structure}

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<Tagging xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <TagSet>
      <Tag>
         <Key>string</Key>
         <Value>string</Value>
      </Tag>
   </TagSet>
</Tagging>
```

Элемент | Описание
--- | ---
`Tagging` | Корневой элемент.
`TagSet` | Массив меток.
`Tag` | Контейнер для метки.
`Key` | Ключ метки.<br>Тип: string.
`Value` | Значение метки.<br>Тип: string.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}