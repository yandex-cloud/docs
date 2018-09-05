# Ответы

## Успешный ответ {#success}

При отсутствии ошибок Yandex [!KEYREF objstorage-name] отвечает HTTP-кодом 200. Тело ответа зависит от запроса и рассматривается в описаниях запросов.


## Ответ с ошибкой {#error}

При возникновении ошибки [!KEYREF objstorage-name] отвечает сообщением с соответствующим HTTP-кодом и дополнительным описанием в формате XML.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Error>
  <Code>NoSuchKey</Code>
  <Message>The resource you requested does not exist</Message>
  <Resource>/mybucket/myfoto.jpg</Resource> 
  <RequestId>4442587FB7D0A2F9</RequestId>
</Error>
```

Тег | Описание
----- | -----
`Code` | Код ошибки.<br/><br/>Перечень кодов смотрите ниже по тексту.
`Message` | Описание ошибки на английском языке.
`RequestId` | Идентификатор запроса вызвавшего ошибку.<br/><br/>Равен значению заголовка `x-amz-request-id`.
`Resource` | Корзина или объект при работе с которым возникла ошибка.


### Коды ошибок {#error_codes}

Код | Описание | HTTP-код
----- | ----- | -----
`AccessDenied` | Доступ запрещен. | 403 Forbidden
`AccountProblem` | Проблема с аккаунтом, не позволяющая завершиться операции успешно.<br/><br/>Обратитесь в службу поддержки Яндекс.Облака. | 403 Forbidden
`BadDigest` | Хэш переданных в заголовке `Content-MD5` не совпадает с вычисленным на стороне [!KEYREF objstorage-name]. | 400 Bad Request
`BucketAlreadyExists` | Корзина с таким названием уже существует, выберите другие имя. | 409 Conflict
`BucketNotEmpty` | Корзина, которую вы удаляете, не пустая. | 409 Conflict
`CredentialsNotSupported` | Учетные данные не поддерживаются. | 400 Bad Request
`EntityTooSmall` | Загружаемый объект меньше минимально допустимого размера. | 400 Bad Request
`EntityTooLarge` | Загружаемый объект больше максимально допустимого. | 400 Bad Request
`ExpiredToken` | Срок действия предоставленного токена истек. | 400 Bad Request
`IncompleteBody` | Размер отправленных данных меньше, чем указано в заголовке `Content-Length`. | 400 Bad Request
`IncorrectNumberOfFilesInPostRequest` | Метод POST требует передачи строго одного файла. | 400 Bad Request
`InlineDataTooLarge` | Данные запроса превышают максимально допустимый размер. | 400 Bad Request
`InternalError` | Внутренняя ошибка [!KEYREF objstorage-name]. Повторите запрос. | 500 Internal Server Error
`InvalidAccessKeyId` | Неизвестный ключ. | 403 Forbidden
`InvalidArgument` | Недопустимый аргумент. | 400 Bad Request
`InvalidBucketName` | Недопустимое имя корзины. | 400 Bad Request
`InvalidBucketState` | Запрос не может быть выполнен для текущего состояния корзины. | 409 Conflict
`InvalidDigest` | Хэш, переданный в заголовке Content-MD5, не верен. | 400 Bad Request
`InvalidObjectState` | Запрос не может быть выполнен для текущего состояния объекта. | 403 Forbidden
`InvalidPart` | Одна и более частей составной загрузки не найдены. Проверьте корректность перечня. Возможно отсутствующие части не были загружены. | 400 Bad Request
`InvalidPartOrder` | Перечень частей составной загрузки указан некорректно. Части должны быть отсортированы по возрастанию номера. | 400 Bad Request
`InvalidPayer` | Доступ к объекту заблокирован. | 403 Forbidden
`InvalidRange` | Неправильный диапазон в заголовке Range. | 416 Requested Range Not Satisfiable
`InvalidRequest` | Используйте AWS4-HMAC-SHA256. | 400 Bad Request
`InvalidRequest` | Попытка превысить максимальный размер корзины.<br/><br/>Описание ошибки в ответе:<br/><br/>``` You have attempted to exceed the max size configured for the bucket. ``` | 400 Bad Request
`InvalidSecurity` | Предоставленные секретные ключи не валидны. | 403 Forbidden
`InvalidStorageClass` | Некорректный класс хранения. | 400 Bad Request
`InvalidTargetBucketForLogging` | Корзина не существует или вы не владелец корзины или недостаточно прав у группы доставки логов. | 400 Bad Request
`InvalidToken` | Токен неправильно сформирован или некорректен по другой причине. | 400 Bad Request
`InvalidURI` | Не получилось разобрать переданный URI. | 400 Bad Request
`KeyTooLongError` | Ключ слишком длинный. | 400 Bad Request
`MalformedACLError` | Предоставленный XML документ неправильно сформирован или не соответствует схеме. | 400 Bad Request
`MalformedPOSTRequest` | Тело запроса не соответствует формату `multipart/form-data`. | 400 Bad Request
`MalformedXML` | Предоставленный XML документ неправильно сформирован или не соответствует схеме. | 400 Bad Request
`MaxMessageLengthExceeded` | Превышена допустимая длина запроса. | 400 Bad Request
`MaxPostPreDataLengthExceededError` | Заголовок HTTP-сообщения превысил допустимый размер. | 400 Bad Request
`MetadataTooLarge` | Размер заголовков метаданных превысил допустимый размер. | 400 Bad Request
`MethodNotAllowed` | HTTP-метод не применим к заданному ресурсу. | 405 Method Not Allowed
`MissingContentLength` | Добавьте `Content-Length` в заголовки. | 411 Length Required
`MissingRequestBodyError` | Пустое тело запроса.<br/><br/>Возникает в случае отправки пустого XML документа. | 400 Bad Request
`MissingSecurityHeader` | Отсутствует необходимый заголовок. | 400 Bad Request
`NoLoggingStatusForKey` | Отсутствует статус логгирования ключа. | 400 Bad Request
`NoSuchBucket` | Указанной корзины не существует. | 404 Not Found
`NoSuchKey` | Указанный ключ не существует. | 404 Not Found
`NoSuchUpload` | Указанной составной загрузки не существует.<br/><br/>Ошибка возникает в следующих случаях:<br/>- Указан неправильный идентификатор загрузки.<br/>- Загрузка прервана.<br/>- Загрузка завершена. | 404 Not Found
`NotImplemented` | Переданный заголовок не обрабатывается [!KEYREF objstorage-name]. | 501 Not Implemented
`NotSignedUp` | Для аккаунта не разрешено использование [!KEYREF objstorage-name]. | 403 Forbidden
`OperationAborted` | Конфликтующие условные операции. | 409 Conflict
`PermanentRedirect` | К указанной корзине всегда следует обращаться по указанному в ответе адресу. | 301 Moved Permanently
`Redirect` | К указанной корзине временно следует обращаться по указанному в ответе адресу. | 307 Moved Temporarily
`RequestIsNotMultiPartContent` | Запрос должен содержать данные типа `multipart/form-data`. | 400 Bad Request
`RequestTimeout` | Таймаут на чтение/запись. | 400 Bad Request
`RequestTimeTooSkewed` | Слишком большая разница между временем отправки запроса и временем на сервере. | 403 Forbidden
`SignatureDoesNotMatch` | Предоставленная подпись запроса не соответствует вычисленной [!KEYREF objstorage-name]. | 403 Forbidden
`ServiceUnavailable` | [!KEYREF objstorage-name] недоступно.<br/>Уменьшите частоту ваших запросов. | 503 Service Unavailable
`SlowDown` | Уменьшите частоту ваших запросов. | 503 Slow Down
`TemporaryRedirect` | Редирект на время обновления DNS. | 307 Moved Temporarily
`TokenRefreshRequired` | Обновите токен. | 400 Bad Request
`TooManyBuckets` | Превышение лимита на количество корзин. | 400 Bad Request
`UnexpectedContent` | В запросе не должно быть контента. | 400 Bad Request
`UnresolvableGrantByEmailAddress` | Не зарегистрированный e-mail. | 400 Bad Request
`UserKeyMustBeSpecified` | Запрос должен содержать указанный в описании ошибки заголовок. | 400 Bad Request
