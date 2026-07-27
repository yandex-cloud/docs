# Object Storage API, REST совместимый с Amazon S3: PutObjectLockConfiguration

Настраивает механизм [блокировок версий объектов](../../../concepts/object-lock.md) в [версионируемом](../../../concepts/versioning.md) бакете: включает или выключает механизм и настраивает блокировки по умолчанию.

{% include [versioning-block-relations](../../../../_includes/storage/versioning-block-relations.md) %}

Когда механизм блокировок включен, вы можете установить на версию объекта блокировку, то есть запрет на удаление или перезапись:

* при загрузке объекта (метод [upload](../object/upload.md));
* после загрузки объекта (методы [putObjectRetention](../object/putobjectretention.md) и [putObjectLegalHold](../object/putobjectlegalhold.md)).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
PUT /{bucket}?object-lock HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

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

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../../storage/concepts/object-lock.md)

* [Управление блокировками версий объектов в бакете](../../../operations/buckets/configure-object-lock.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
