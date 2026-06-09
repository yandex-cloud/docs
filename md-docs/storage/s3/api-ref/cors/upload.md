# Object Storage API, REST совместимый с Amazon S3: PutBucketCors

Загружает конфигурацию CORS для бакета. Если конфигурация существует, то заменяет ее.

Конфигурация CORS — это XML-файл размером не более 64КБ. Конфигурация не может содержать более 100 правил.

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
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

Конфигурация CORS передается в виде XML-документа. Описание схемы смотрите в разделе [CORS в Object Storage](../../../concepts/cors.md)

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [CORS в Object Storage](../../../concepts/cors.md)

* [Настройка CORS](../../../operations/buckets/cors.md)

#### См. также {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)