# Метод delete

Удаляет конфигурацию CORS для бакета.


## Запрос {#request}

```
DELETE /{bucket}?cors HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

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

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Если конфигурация CORS не существует, то {{ objstorage-name }} ответит кодом `204 No Content`.
