# Object Storage API, REST совместимый с Amazon S3: HeadBucket

Возвращает метаданные бакета или ошибку.

Позволяет проверить:

- Существует ли бакет.
- Достаточно ли у пользователя прав для доступа к бакету.

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
HEAD /{bucket} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ не содержит дополнительных данных и означает, что бакет существует и у пользователя достаточно прав для доступа к нему.

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)


* [Получение информации о бакете и статистики бакета](../../../operations/buckets/get-info.md)


#### См. также {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)