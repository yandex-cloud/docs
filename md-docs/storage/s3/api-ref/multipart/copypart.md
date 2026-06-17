# Object Storage API, REST совместимый с Amazon S3: UploadPartCopy

Копирует часть объекта.

Имеет такую же функциональность, как и [Object Storage API, REST совместимый с Amazon S3: UploadPart](uploadpart.md), только данные передаются не в теле запроса, а копируются из существующего объекта.

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя результирующего бакета.
`key` | Ключ результирующего объекта. Идентификатор, под которым объект сохраняется в Object Storage.

### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`partNumber` | Идентификатор, который вы присвоили загружаемой части.
`uploadId` | Идентификатор составной загрузки, который Object Storage вернул при [инициализации](startupload.md).


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Заголовок `Content-Length` обязателен. Также обязательны заголовки, перечисленные в таблице ниже.

Заголовок | Описание
--- | ---
`X-Amz-Copy-Source` | Имя бакета и ключ объекта, данные которого будут копироваться, разделенные символом `/`.<br/><br/>Например, `X-Amz-Copy-Source: /source_bucket/sourceObject`.
`X-Amz-Copy-Source-Range` | Диапазон байт для копирования из исходного объекта. Например, если указать `X-Amz-Copy-Source-Range:bytes=10-36`, то Object Storage скопирует с 10-го по 36-й байт исходного объекта.

Заголовок `Content-MD5` обязателен, если в бакете настроены [блокировки версий объектов по умолчанию](../../../concepts/object-lock.md#default).

Если вы хотите добавить условия на копирование, то используйте заголовки, перечисленные в таблице ниже.

Заголовки, описанные в таблице ниже используйте, если вам необходимо изменить поведение метода `copy` по умолчанию.

Заголовок | Описание
----- | -----
`X-Amz-Copy-Source-If-Match` | Условие для копирования объекта.<br/><br/>Если `ETag` объекта равен заданному в заголовке, то объект копируется.<br/><br/>Если условие не выполнено, то Object Storage вернет ошибку 412.<br/><br/>Можно использовать вместе с заголовком `X-Amz-Copy-Source-If-Unmodified-Since`.
`X-Amz-Copy-Source-If-None-Match` | Условие для копирования объекта.<br/><br/>Если `ETag` объекта не равен заданному в заголовке, то объект копируется.<br/><br/>Если условие не выполнено, то Object Storage вернет ошибку 412.<br/><br/>Можно использовать вместе с заголовком `X-Amz-Copy-Source-If-Modified-Since`.
`X-Amz-Copy-Source-If-Unmodified-Since` | Условие для копирования объекта.<br/><br/>Объект копируется, если он не изменялся с указанного времени.<br/><br/>Если условие не выполнено, то Object Storage вернет ошибку 412.<br/><br/>Можно использовать вместе с заголовком `X-Amz-Copy-Source-If-Match`.
`X-Amz-Copy-Source-If-Modified-Since` | Условие для копирования объекта.<br/><br/>Объект копируется, если он изменился с указанного времени.<br/><br/>Если условие не выполнено, то Object Storage вернет ошибку 412.<br/><br/>Можно использовать вместе с заголовком `X-Amz-Copy-Source-If-None-Match`.


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).


### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Дополнительно, Object Storage может вернуть ошибки, описанные в таблице ниже.

Ошибка | Описание | HTTP-код
----- | ----- | -----
`NoSuchUpload` | Указанная загрузка не существует. Возможно указан неверный идентификатор загрузки или загрузка была завершена или удалена. | 404 Not Found
`EntityTooSmall` | Размер части слишком мал.<br/><br/>Загружаемая часть должна быть не менее 5MB. | 400 Bad Request


### Схема данных {#response-scheme}

```xml
<CopyObjectResult>
   <LastModified>2019-02-15T14:32:00</LastModified>
   <ETag>"9bgh7535f2734ec974343yuc93985328"</ETag>
</CopyObjectResult>
```

Элемент | Описание
----- | -----
`CopyObjectResult` | Содержит элементы ответа.<br/><br/>Путь: `/CopyObjectResult`.
`ETag` | `ETag` результирующей части составной загрузки.<br/><br/>Путь: `/CopyObjectResult/ETag`.
`LastModified` | Дата последнего изменения части составной загрузки.<br/><br/>Путь: `/CopyObjectResult/LastModified`.

#### Связанные статьи {#related-articles}

* [Составная (multipart) загрузка](../../../concepts/multipart.md)

* [Копирование одного объекта](../../../operations/objects/copy.md#copy-single-object)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)