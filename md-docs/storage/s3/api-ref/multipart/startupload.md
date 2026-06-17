# Object Storage API, REST совместимый с Amazon S3: CreateMultipartUpload

Возвращает идентификатор, который следует использовать во всех дальнейших операциях по загрузке объекта.

Если вместе с объектом необходимо хранить пользовательские метаданные, то передавать их следует в этом запросе.

Подробнее о подготовке к работе с API и общем виде запроса смотрите в разделе [Как пользоваться S3 API](../../index.md).

## Запрос {#request}

```http
POST /{bucket}/{key}?uploads HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Под указанным именем объект будет сохранен в Object Storage.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`uploads` | Флаг, обозначающий операцию составной загрузки.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Дополнительно можно использовать заголовки, перечисленные в таблице ниже.

Заголовок | Описание
----- | -----
`X-Amz-Meta-*` | Пользовательские метаданные объекта.<br/><br/>Все заголовки, начинающиеся с `X-Amz-Meta-`, Object Storage преобразует по правилу: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Общий размер пользовательских заголовков не должен превышать 2 КБ. Размер пользовательских данных определяется как длина строки в кодировке UTF-8. В размере учитываются и названия заголовков и их значения.
`X-Amz-Storage-Class` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Может иметь любое из значений:<ul><li>`STANDARD` — стандартное хранилище.</li><li>`COLD`, `STANDARD_IA` или `NEARLINE` — холодное хранилище.</li><li>`ICE` или `GLACIER` — ледяное хранилище.</li><li>`INTELLIGENT_TIERING` — умное хранилище.</li></ul>Если заголовок не указан, то объект сохраняется в хранилище, установленном в настройках бакета.
`X-Amz-Object-Lock-Mode` | <p>Тип временной [блокировки](../../../concepts/object-lock.md), устанавливаемой на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>Вы можете установить на версию объекта только временную блокировку (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочную блокировку (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [Типы блокировок](../../../concepts/object-lock.md#types).</p>
`X-Amz-Object-Lock-Retain-Until-Date` | Дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Указывается только вместе с заголовком `X-Amz-Object-Lock-Mode`.
`X-Amz-Object-Lock-Legal-Hold` | <p>Статус бессрочной [блокировки](../../../concepts/object-lock.md), устанавливаемой на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>Вы можете установить на версию объекта только временную блокировку (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочную блокировку (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [Типы блокировок](../../../concepts/object-lock.md#types).</p>

С помощью заголовков, перечисленных ниже, можно установить [ACL](../../../concepts/acl.md) для загружаемого объекта.

Заголовок | Описание
--- | ---
`X-Amz-Acl` | Устанавливает [предопределенный ACL](../../../concepts/acl.md#predefined-acls) для объекта.
`X-Amz-Grant-Read` | Устанавливает получателю доступа разрешение на чтение объекта.
`X-Amz-Grant-Read-Acp` | Устанавливает получателю доступа разрешение на чтение ACL объекта.
`X-Amz-Grant-Write-Acp` | Устанавливает получателю доступа разрешение на запись ACL объекта.
`X-Amz-Grant-Full-Control` | Устанавливает получателю доступа разрешения: `READ`, `WRITE`, `READ_ACP`, `WRITE_ACP` на объект.

Значение для заголовков `X-Amz-Grant-*` представляет собой разделенный запятыми список получателей доступа. Каждый получатель доступа идентифицируется структурой вида `<тип_получателя_доступа>:<идентификатор_получателя_доступа>`. Object Storage поддерживает следующие типы получателей:
* `id` — получатель доступа — пользователь облака.
* `uri` — получатель доступа — публичная группа.

Пример:

```http
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [Ответы](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```xml
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
`UploadId` | Идентификатор загрузки.<br/><br/>Все последующие операции с загрузкой должны передавать в Object Storage этот идентификатор.<br/><br/>Путь: `/InitiateMultipartUploadResult/UploadId`.

#### Связанные статьи {#related-articles}

* [Составная (multipart) загрузка](../../../concepts/multipart.md)

* [Создание составной загрузки в бакете](../../../operations/objects/multipart-upload.md#create-multipart-upload)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)