[Документация Yandex Cloud](../../../../index.md) > [Yandex Object Storage](../../../index.md) > Справочник API > [AWS S3 REST](../../index.md) > [REST](../index.md) > Bucket > PutObjectLockConfiguration

# Object Storage API, REST совместимый с Amazon S3: PutObjectLockConfiguration

Настраивает механизм [блокировок версий объектов](../../../concepts/object-lock.md) в [версионируемом](../../../concepts/versioning.md) бакете: включает или выключает механизм и настраивает блокировки по умолчанию.

{% note info %}

Блокировка версий объектов невозможна в бакетах с выключенным или приостановленным версионированием.

При включенной блокировке версионирование нельзя приостановить.

{% endnote %}

Когда механизм блокировок включен, вы можете установить на версию объекта блокировку, то есть запрет на удаление или перезапись:

* при загрузке объекта (метод [upload](../object/upload.md));
* после загрузки объекта (методы [putObjectRetention](../object/putobjectretention.md) и [putObjectLegalHold](../object/putobjectlegalhold.md)).

Подробнее о подготовке к работе с API и общем виде запроса в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
PUT /{bucket}?object-lock HTTP/2
```

### Path параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `bucket` | Имя бакета ||
|#

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

### Схема данных {#request-scheme}

```xml
<ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <ObjectLockEnabled>string</ObjectLockEnabled>
   <Rule>
      <DefaultRetention>
         <Mode>string</Mode>
         <Days>integer</Days>
         <Years>integer</Years>
      </DefaultRetention>
   </Rule>
</ObjectLockConfiguration>
```

#|
|| **Элемент** | **Описание** ||
|| `ObjectLockConfiguration` | Корневой элемент.

Чтобы выключить механизм блокировок, передайте этот параметр с пустым значением, например `<ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />`.

Путь: `ObjectLockConfiguration`. ||
|| `ObjectLockEnabled` | Статус механизма блокировок:

* `Enabled` — механизм блокировок включен.

Если элемент не указан, будет выведено сообщение об ошибке `InvalidRequest`, а механизм блокировок не включится.

Путь: `ObjectLockConfiguration\ObjectLockEnabled`. ||
|| `Rule` | Настройки блокировок.

Путь: `ObjectLockConfiguration\Rule`. ||
|| `DefaultRetention` | Настройки блокировок по умолчанию.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention`. ||
|| `Mode` | [Тип](../../../concepts/object-lock.md#types) блокировки по умолчанию:

* `GOVERNANCE` — временная управляемая блокировка.
* `COMPLIANCE` — временная строгая блокировка.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`. ||
|| `Days` | Срок блокировки по умолчанию в днях от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Years`.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Days`. ||
|| `Years` | Срок блокировки по умолчанию в годах от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Days`.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Years`. ||
|#

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

#### Связанные статьи {#related-articles}

* [Бакет в Object Storage](../../../concepts/bucket.md)

* [Блокировка версии объекта (object lock)](../../../concepts/object-lock.md)

* [Управление блокировками версий объектов в бакете](../../../operations/buckets/configure-object-lock.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)