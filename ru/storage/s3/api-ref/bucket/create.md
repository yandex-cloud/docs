# Метод create

Создает бакет.


## Запрос {#request}

```
PUT /{bucket} HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.<br/><br/>При создании бакета помните об [ограничениях на имя](../../../concepts/bucket.md#naming).

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

