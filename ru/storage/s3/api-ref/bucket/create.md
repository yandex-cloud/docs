# Метод create

Создает бакет.


## Запрос {#request}

```http
PUT /{bucket} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.<br/><br/>При создании бакета помните об [ограничениях на имя](../../../concepts/bucket.md#naming).

### Заголовки {#request-headers}
Используйте в запросе [общие заголовки](../common-request-headers.md).

С помощью заголовков, перечисленных ниже, можно установить [ACL](../../../concepts/acl.md) создаваемого бакета.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}