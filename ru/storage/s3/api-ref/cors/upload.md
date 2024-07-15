# Метод upload

Загружает конфигурацию CORS для бакета. Если конфигурация существует, то заменяет ее.

Конфигурация CORS — это XML-файл размером не более 64КБ. Конфигурация не может содержать более 100 правил.


## Запрос {#request}

```
PUT /{bucket}?cors HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`cors` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Заголовок `Content-MD5` обязателен.

### Схема данных {#request-scheme}

Конфигурация CORS передается в виде XML-документа. Описание схемы смотрите в разделе [{#T}](xml-config.md)

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}