# Метод delete

Удаляет конфигурацию жизненного цикла объектов в бакете из Object Storage.

## Запрос {#request}

```
DELETE /{bucket}?lifecycle HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#parameters}

Параметр | Описание
----- | -----
`lifecycle` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [#T](../response-codes.md).

Если конфигурация жизненных циклов бакета не существует, то Object Storage ответит кодом 200.
