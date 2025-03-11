# Метод getObjectMeta

Возвращает метаданные объекта.

Метод эквивалентен методу [get](get.md), но в ответе отсутствует сам объект.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
HEAD /{bucket}/{key} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также в запросе можно использовать следующие заголовки:

Заголовок | Описание
----- | -----
`Range` | Определяет диапазон байт для загрузки из объекта.<br/><br/>Подробнее про заголовок Range читайте в спецификации HTTP [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35).
`If-Modified-Since` | Если указан, то {{ objstorage-name }} возвращает:<br/>- Объект. Если он изменялся после указанного времени.<br/>- Код 304. Если объект не изменялся после указанного времени.<br/><br/>Если в запросе одновременно присутствуют заголовки `If-Modified-Since` и `If-None-Match` и проверки по ним разрешаются как `If-Modified-Since -> true` и `If-None-Match -> false`, то {{ objstorage-name }} возвращает код 304. Подробности смотрите в [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-Unmodified-Since` | Если указан, то {{ objstorage-name }} возвращает:<br/>- Объект. Если он не изменялся с указанного времени.<br/>- Код 412. Если объект изменялся с указанного времени.<br/><br/>Если в запросе одновременно присутствуют заголовки `If-Unmodified-Since` и `If-Match` и проверки по ним разрешаются как `If-Unmodified-Since -> false` и `If-Match -> true`, то {{ objstorage-name }} возвращает код 200 и запрошенные данные. Подробности смотрите в [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-Match` | Если указан, то {{ objstorage-name }} возвращает:<br/><br/>- Объект. Если его `ETag` совпадает с переданным.<br/>- Код 412. Если его `ETag` не совпадает с переданным.<br/><br/><br/>Если в запросе одновременно присутствуют заголовки `If-Unmodified-Since` и `If-Match` и проверки по ним разрешаются как `If-Unmodified-Since -> false` и `If-Match -> true`, то {{ objstorage-name }} возвращает код 200 и запрошенные данные. Подробности смотрите в [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-None-Match` | Если указан, то {{ objstorage-name }} возвращает:<br/><br/>- Объект. Если его `ETag` не совпадает с переданным.<br/>- Код 304. Если его `ETag` совпадает с переданным.<br/><br/><br/>Если в запросе одновременно присутствуют заголовки `If-Modified-Since` и `If-None-Match` и проверки по ним разрешаются как `If-Modified-Since -> true` и `If-None-Match -> false`, то {{ objstorage-name }} возвращает код 304. Подробности смотрите в [RFC 7232](https://tools.ietf.org/html/rfc7232).

## Ответ {#response}

### Заголовки {#response-headers}

Помимо [общих заголовков](../common-response-headers.md) вы можете увидеть в ответе заголовки, перечисленные в таблице ниже.


Заголовок | Описание
----- | -----
`X-Amz-Meta-*` | Пользовательские метаданные объекта.
`X-Amz-Storage-Class` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/>Имеет значение `COLD`, если объект находится в холодном хранилище, или `ICE`, если объект находится в ледяном хранилище.<br/><br/>Если объект сохранен в стандартном хранилище, то заголовка не будет.
`X-Amz-Server-Side-Encryption` | Алгоритм шифрования, которым был зашифрован объект. Возвращается, если объект был загружен с включенным [шифрованием](../../../operations/buckets/encrypt.md).
`X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | Идентификатор [ключа {{ kms-short-name }}](../../../../kms/concepts/key.md). Возвращается, если объект был загружен с включенным [шифрованием](../../../operations/buckets/encrypt.md).
`X-Amz-Object-Lock-Mode` | <p>Тип временной [блокировки](../../../concepts/object-lock.md), установленной на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`GOVERNANCE` — временная управляемая блокировка.</li><li>`COMPLIANCE` — временная строгая блокировка.</li></ul><p>На версию объекта может быть установлена только временная блокировка (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочная блокировка (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../../concepts/object-lock.md#types).</p>
`X-Amz-Object-Lock-Retain-Until-Date` | Дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Указывается только вместе с заголовком `X-Amz-Object-Lock-Mode`.
`X-Amz-Object-Lock-Legal-Hold` | <p>Статус бессрочной [блокировки](../../../concepts/object-lock.md), установленной на объект (если бакет [версионируемый](../../../concepts/versioning.md) и в нем включен механизм блокировок):</p><ul><li>`ON` — блокировка установлена.</li><li>`OFF` — блокировка не установлена.</li></ul><p>На версию объекта может быть установлена только временная блокировка (заголовки `X-Amz-Object-Lock-Mode` и `X-Amz-Object-Lock-Retain-Until-Date`), только бессрочная блокировка (`X-Amz-Object-Lock-Legal-Hold`) или обе сразу. Подробнее об их совместной работе см. в разделе [{#T}](../../../concepts/object-lock.md#types).</p>


### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}