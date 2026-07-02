[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Bucket Policy > DeleteBucketPolicy

# Object Storage API, REST совместимый с Amazon S3: DeleteBucketPolicy

Удаляет политику доступа заданного бакета.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```bash
DELETE /{bucket}?policy HTTP/2
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

## Ответ {#response}

При успешном выполнении запроса сервис возвращает ответ с кодом `HTTP 204` и пустым телом.

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Политика доступа (bucket policy)](../../../concepts/policy.md)

* [Удаление политики](../../../operations/buckets/policy.md#delete-policy)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)