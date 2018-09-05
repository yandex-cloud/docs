# Метод listBuckets

Возвращает перечень корзин, доступных пользователю.


## Запрос {#request}

```
GET / HTTP/1.1
```

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).

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
`Bucket` | Содержит описание корзины.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket`.
`Buckets` | Содержит перечень корзин.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets`.
`CreationDate` | Время создания корзины в формате `yyyy-mm-ddThh:mm:ss.timezone`.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`.
`ListAllMyBucketsResult` | Корневой элемент ответа.<br/><br/>Путь: `/ListAllMyBucketsResult`.
`Name` | Имя корзины.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/Name`.
