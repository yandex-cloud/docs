# Метод listBuckets

Возвращает перечень бакетов, доступных пользователю.

{% include [sa-acl-bucket-list-note.md](../../../../_includes/storage/sa-acl-bucket-list-note.md) %}

## Запрос {#request}

```
GET / HTTP/2
```

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<ListAllMyBucketsResult>
  <Buckets>
    <Bucket>
      <Name>bucket-name</Name>
      <CreationDate>date_time</CreationDate>
    </Bucket>
    ...
  </Buckets>
</ListAllMyBucketsResult>
```

Элемент | Описание
----- | -----
`Bucket` | Содержит описание бакета.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket`.
`Buckets` | Содержит перечень бакетов.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets`.
`CreationDate` | Время создания бакета в формате `yyyy-mm-ddThh:mm:ss.timezone`.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`.
`ListAllMyBucketsResult` | Корневой элемент ответа.<br/><br/>Путь: `/ListAllMyBucketsResult`.
`Name` | Имя бакета.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/Name`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}