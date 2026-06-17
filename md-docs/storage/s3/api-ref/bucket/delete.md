# Object Storage API, REST совместимый с Amazon S3: DeleteBucket

Удаляет пустой бакет. Если бакет не пустой, то сначала нужно удалить все находящиеся в ней объекты.

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
DELETE /{bucket} HTTP/2
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

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)

* [Удаление бакета](../../../operations/buckets/delete.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)