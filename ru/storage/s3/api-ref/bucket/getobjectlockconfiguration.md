# Метод getObjectLockConfiguration

Возвращает настройки механизма [блокировок версий объектов](../../../concepts/object-lock.md) в [версионируемом](../../../concepts/versioning.md) бакете.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?object-lock HTTP/2
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

Элемент | Описание
----- | -----
`ObjectLockEnabled` | <p>Статус механизма блокировок:</p><ul><li>`Enabled` — механизм блокировок включен.</li></ul><p>Если элемент не указан, механизм блокировок выключен.</p><p>Путь: `ObjectLockConfiguration\ObjectLockEnabled`.</p>
`Rule` | <p>Настройки блокировок.</p><p>Путь: `ObjectLockConfiguration\Rule`.</p>
`DefaultRetention` | <p>Настройки блокировок по умолчанию.</p><p>Путь: `ObjectLockConfiguration\Rule\DefaultRetention`.</p>
`Mode` | <p>[Тип](../../../concepts/object-lock.md#types) блокировки по умолчанию:</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`.</p>
`Days` | <p>Срок блокировки по умолчанию в днях от момента загрузки версии объекта. Должен быть положительным целым числом.</p><p>Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Days`.</p>
`Years` | <p>Срок блокировки по умолчанию в годах от момента загрузки версии объекта. Должен быть положительным целым числом.</p><p>Путь: `ObjectLockConfiguration\Rule\DefaultRetention\Years`.</p>

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}