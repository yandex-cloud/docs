# Метод bucketPutAcl

Загружает список управления доступом для бакета.

{% note info %}

ACL можно загрузить в виде XML-документа или с помощью специальных заголовков `x-amx-grant*`. Не используйте XML-документ и заголовки `x-amx-grant*` в одном запросе.

{% endnote %}

## Запрос {#request}

```
PUT /{bucket}?acl HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`acl` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также можно использовать заголовки, перечисленные ниже.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

### Схема данных {#data-schema}

ACL передается в виде XML-документа. Описание схемы смотрите в разделе [XML-cхема ACL](xml-config.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).
