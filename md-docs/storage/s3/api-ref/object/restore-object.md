[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Object > RestoreObject

# Object Storage API, REST совместимый с Amazon S3: RestoreObject

Метод обеспечивает совместимость с другими решениями — например, можно не менять логику работы с Amazon S3 Glacier при работе с Object Storage. Но в отличие от Amazon S3 Glacier объекты Object Storage доступны для чтения напрямую без перемещения в более горячие классы, поэтому метод всегда возвращает `200 OK`.

Также `RestoreObject` считается обращением к объекту в [умном хранилище](../../../concepts/storage-class.md#features-intelligent-tiering) (`INTELLIGENT_TIERING`). Метод может перевести объект на уровень более частого доступа.

{% note warning %}

Восстановление объектов с помощью S3 Select не поддерживается. Запрос со значением `SELECT` в элементе `Type` вернет ошибку `501 Not Implemented`.

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
POST /{bucket}/{key}?restore HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [Объект](../../../concepts/object.md)

* [Умное хранилище](../../../concepts/storage-class.md#features-intelligent-tiering)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)