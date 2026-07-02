[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Lifecycles > PutBucketLifecycleConfiguration

# Object Storage API, REST совместимый с Amazon S3: PutBucketLifecycleConfiguration

Загружает конфигурацию жизненных циклов объектов в бакете в Object Storage.

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}?lifecycle HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`lifecycle` | Обязательный параметр для обозначения типа операции.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Заголовок `Content-MD5` обязателен.

### Схема данных {#request-scheme}

Вид конфигурации описан в разделе [Конфигурация жизненных циклов объектов в бакете](xml-config.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Жизненные циклы объектов в бакете](../../../concepts/lifecycles.md)

* [Управление жизненными циклами объектов в бакете](../../../operations/buckets/lifecycles.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)