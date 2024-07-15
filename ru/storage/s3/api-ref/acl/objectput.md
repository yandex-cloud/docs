# Метод objectPutAcl

Загружает список управления доступом для объекта.

{% note info %}

ACL можно загрузить в виде XML-документа или с помощью специальных заголовков `X-Amz-Grant*`. Не используйте XML-документ и заголовки `X-Amz-Grant*` в одном запросе.

{% endnote %}

## Запрос {#request}

```
PUT /{bucket}/{key}?acl HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Идентификатор, под которым объект будет сохранен в {{ objstorage-name }}.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`acl` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также можно использовать заголовки, перечисленные ниже.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}

### Схема данных {#data-schema}

ACL передается в виде XML-документа. Описание схемы смотрите в разделе [XML-схема ACL](xml-config.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}