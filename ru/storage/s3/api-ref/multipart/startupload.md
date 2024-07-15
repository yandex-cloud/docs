# Метод startUpload

Возвращает идентификатор, который следует использовать во всех дальнейших операциях по загрузке объекта.

Если вместе с объектом необходимо хранить пользовательские метаданные, то передавать их следует в этом запросе.


## Запрос {#request}

```
POST /{bucket}/{key}?uploads HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Под указанным именем объект будет сохранен в {{ objstorage-name }}.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`uploads` | Флаг, обозначающий операцию составной загрузки.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Дополнительно можно использовать заголовки, перечисленные в таблице ниже.

Заголовок | Описание
----- | -----
`X-Amz-Meta-*` | Пользовательские метаданные объекта.<br/><br/>Все заголовки, начинающиеся с `X-Amz-Meta-`, {{ objstorage-name }} преобразует по правилу: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Общий размер пользовательских заголовков не должен превышать 2 КБ. Размер пользовательских данных определяется как длина строки в кодировке UTF-8. В размере учитываются и названия заголовков и их значения.
`X-Amz-Storage-Class` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Может иметь любое из значений:<ul><li>`STANDARD` — стандартное хранилище.</li><li>`COLD`, `STANDARD_IA` или `NEARLINE` — холодное хранилище.</li><li>`ICE` или `GLACIER` — ледяное хранилище.</li></ul>Если заголовок не указан, то объект сохраняется в хранилище, установленном в настройках бакета.
`X-Amz-Object-Lock-Mode` | <p>Тип временной [блокировки](../../../concepts/object-lock.md), устанавливаемой на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>Вы можете установить на версию объекта только временную блокировку (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочную блокировку (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../../concepts/object-lock.md#types).</p>
`X-Amz-Object-Lock-Retain-Until-Date` | Дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Указывается только вместе с заголовком `X-Amz-Object-Lock-Mode`.
`X-Amz-Object-Lock-Legal-Hold` | <p>Статус бессрочной [блокировки](../../../concepts/object-lock.md), устанавливаемой на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>Вы можете установить на версию объекта только временную блокировку (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочную блокировку (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../../concepts/object-lock.md#types).</p>

С помощью заголовков, перечисленных ниже, можно установить [ACL](../../../concepts/acl.md) для загружаемого объекта.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<InitiateMultipartUploadResult>
  <Bucket>bucket-name</Bucket>
  <Key>object-key</Key>
  <UploadId>upload-id</UploadId>
</InitiateMultipartUploadResult>
```

Тег | Описание
----- | -----
`InitiateMultipartUploadResult` | Корневой тег ответа.<br/><br/>Путь: `/InitiateMultipartUploadResult`.
`Bucket` | Имя бакета в который загружается объект.<br/><br/>Путь: `/InitiateMultipartUploadResult/Bucket`.
`Key` | Ключ, который ассоциируется с объектом, после окончания загрузки.<br/><br/>Путь: `/InitiateMultipartUploadResult/Key`.
`UploadId` | Идентификатор загрузки.<br/><br/>Все последующие операции с загрузкой должны передавать в {{ objstorage-name }} этот идентификатор.<br/><br/>Путь: `/InitiateMultipartUploadResult/UploadId`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}