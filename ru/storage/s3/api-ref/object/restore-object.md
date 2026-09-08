# Object Storage API, REST совместимый с Amazon S3: RestoreObject

Метод обеспечивает совместимость с другими решениями — например, можно не менять логику работы с Amazon S3 Glacier при работе с {{ objstorage-name }}. Но в отличие от Amazon S3 Glacier объекты {{ objstorage-name }} доступны для чтения напрямую без перемещения в более горячие классы, поэтому метод всегда возвращает `200 OK`.

Также `RestoreObject` считается обращением к объекту в [умном хранилище](../../../concepts/storage-class.md#features-intelligent-tiering) (`INTELLIGENT_TIERING`). Метод может перевести объект на уровень более частого доступа.

{% note warning %}

Восстановление объектов с помощью S3 Select не поддерживается. Запрос со значением `SELECT` в элементе `Type` вернет ошибку `501 Not Implemented`.

{% endnote %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

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

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ не содержит дополнительных данных.

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/object.md)

* [{#T}](../../../concepts/storage-class.md#features-intelligent-tiering)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
