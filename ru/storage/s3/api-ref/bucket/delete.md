# Метод deleteBucket

Удаляет пустую корзину. Если корзина не пустая, то сначала нужно удалить все находящиеся в ней объекты.


## Запрос {#request}

```
DELETE /{bucket} HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя корзины.


### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).
