# Метод objectPutAcl

Загружает список управления доступом для объекта.

> [!NOTE]
>
>ACL можно загрузить в виде XML-документа или с помощью специальных заголовков `x-amx-grant*`. Не используйте XML-документ и заголовки `x-amx-grant*` в одном запросе.

## Запрос {#request}

```
PUT /{bucket}/{key}?acl HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Идентификатор, под которым объект будет сохранен в [!KEYREF objstorage-name].

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`acl` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также можно использовать заголовки, перечисленные ниже.

[!INCLUDE [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md)]

### Схема данных

ACL передается в виде XML-документа. Описание схемы смотрите в разделе [XML-cхема ACL](xmlscheme.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).
