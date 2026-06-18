# Object Storage API, REST совместимый с Amazon S3: PutBucketPolicy

Применяет политику доступа к заданному бакету.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```bash
PUT /{bucket}?policy HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`policy` | Обязательный параметр для обозначения типа операции.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

### Схема данных {#request-scheme}

Данные передаются в формате JSON, подробнее читайте в разделе [Схема данных](scheme.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Политика доступа (bucket policy)](../../../concepts/policy.md)

* [Применение или изменение политики](../../../operations/buckets/policy.md#apply-policy)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)