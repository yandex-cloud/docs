# Метод delete

Удаляет конфигурацию CORS для корзины.


## Запрос {#request}

```
DELETE /{bucket}?cors HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя корзины.

### Query параметры {#parameters}

Параметр | Описание
----- | -----
`cors` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).

Если конфигурация CORS не существует, то [!KEYREF objstorage-name] ответит кодом `204 No Content`.
