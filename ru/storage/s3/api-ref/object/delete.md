# Метод delete

Удаляет объект.


## Запрос {#request}

```
DELETE /{bucket}/{key} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versionId` | Ссылка на конкретную версию объекта.

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

