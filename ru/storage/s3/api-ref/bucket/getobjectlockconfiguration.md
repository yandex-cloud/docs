# Object Storage API, REST совместимый с Amazon S3: GetObjectLockConfiguration

Возвращает настройки механизма [блокировок версий объектов](../../../concepts/object-lock.md) в [версионируемом](../../../concepts/versioning.md) бакете.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?object-lock HTTP/2
```

### Path параметры {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Заголовки {#request-headers}

Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

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
|| `ObjectLockEnabled` | Статус механизма блокировок:

* `Enabled` — механизм блокировок включен.

Если элемент не указан, механизм блокировок выключен.

Путь: `ObjectLockConfiguration\ObjectLockEnabled`. ||
|| `Rule` | Настройки блокировок.

Путь: `ObjectLockConfiguration\Rule`. ||
|| `DefaultRetention` | Настройки блокировок по умолчанию.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention`. ||
|| `Mode` | [Тип](../../../concepts/object-lock.md#types) блокировки по умолчанию:

* `GOVERNANCE` — временная управляемая блокировка.
* `COMPLIANCE` — временная строгая блокировка.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`. ||
|| `Days` | Срок блокировки по умолчанию в днях от момента загрузки версии объекта. Должен быть положительным целым числом.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Days`. ||
|| `Years` | Срок блокировки по умолчанию в годах от момента загрузки версии объекта. Должен быть положительным целым числом.

Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Years`. ||
|#

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [Блокировка версии объекта](../../../concepts/object-lock.md)

* [Управление блокировками версий объектов в бакете](../../../operations/buckets/configure-object-lock.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
