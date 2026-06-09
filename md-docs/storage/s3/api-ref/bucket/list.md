# Object Storage API, REST совместимый с Amazon S3: ListBuckets

Возвращает перечень бакетов, доступных пользователю.

{% note info %}

Авторизация в [Amazon S3 HTTP API](../../index.md) и [инструментах с его поддержкой](../../../tools/index.md) осуществляется с помощью [статических ключей](../../../../iam/concepts/authorization/access-key.md), полученных для [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md).

Вы можете просматривать список бакетов только в том каталоге, в котором был создан используемый сервисный аккаунт.

{% endnote %}

Подробнее о подготовке к работе с API и общем виде запроса см. в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
GET / HTTP/2
```

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```xml
<ListAllMyBucketsResult>
  <Buckets>
    <Bucket>
      <Name>bucket-name</Name>
      <CreationDate>date_time</CreationDate>
    </Bucket>
    ...
  </Buckets>
</ListAllMyBucketsResult>
```

Элемент | Описание
----- | -----
`Bucket` | Содержит описание бакета.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket`.
`Buckets` | Содержит перечень бакетов.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets`.
`CreationDate` | Время создания бакета в формате `yyyy-mm-ddThh:mm:ss.timezone`.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/CreationDate`.
`ListAllMyBucketsResult` | Корневой элемент ответа.<br/><br/>Путь: `/ListAllMyBucketsResult`.
`Name` | Имя бакета.<br/><br/>Путь: `/ListAllMyBucketsResult/Buckets/Bucket/Name`.

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../operations/buckets/get-list.md)

#### См. также {#see-also}

* [{#T}](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)