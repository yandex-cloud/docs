# Коды ошибок

## Retryable Errors {#retryable-errors}

| Код ошибки | Название ошибки | Описание |
|------------|-----------------|----------|
| `40001` | ErrSerializationFailure | Конфликт транзакций |
| `40P01` | ErrDeadlockDetected | Deadlock |
| `55P03` | ErrLockTimeout | Таймаут блокировки |
| `08P01` | ErrConnectToServer | Ошибка подключения |
| `57P01` | ErrTerminatingConnection | Разрыв соединения |
| `57P03` | ErrDatabaseIsShuttingDown | База данных выключается |
| `53300` | ErrTooManyActiveClients | Слишком много клиентов |
| `S3X01` | ErrNoSuchChunk | Чанк не найден |
| `S3K04` | ErrTransactionTooOld | Транзакция слишком старая |
| `S3X03` | ErrChunkInTransit | Чанк переносится |


## Connection Errors {#connection-errors}

| Код ошибки | Название ошибки |
|------------|-----------------|
| `08P01` | ErrConnectToServer |
| `57P03` | ErrDatabaseIsShuttingDown |
| `57P01` | ErrTerminatingConnection |
| `53300` | ErrTooManyActiveClients |


## S3 API Error Codes (HTTP-уровень) {#s3-api-error-codes}

### Классификация по HTTP Status Code {#classification-by-http-status-code}

#### HTTP 400 Bad Request — Ошибки валидации запроса {#http-400-bad-request}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `InvalidArgument` | Invalid Argument | Неверный аргумент в запросе | Проверить параметры запроса |
| `InvalidBucketName` | The specified bucket is not valid | Некорректное имя бакета | Использовать допустимое имя бакета |
| `InvalidDigest` | The Content-Md5 you specified is not valid | Неверный MD5-хеш | Пересчитать MD5-хеш |
| `InvalidRange` | The requested range is not satisfiable | Неверный диапазон Range | Проверить диапазон байтов |
| `InvalidStorageClass` | Invalid storage class | Неверный класс хранения | Использовать допустимый класс хранения |
| `InvalidVersionID` | Invalid version id specified | Неверный идентификатор версии | Проверить идентификатор версии объекта |
| `InvalidPart` | One or more of the specified parts could not be found | Часть составной загрузки не найдена | Проверьте номера частей |
| `InvalidPartOrder` | The list of parts was not in ascending order | Неверный порядок частей | Отправьте части в правильном порядке |
| `MalformedXML` | The XML you provided was not well-formed | Некорректный XML | Проверьте формат XML |
| `MissingContentLength` | You must provide the Content-Length HTTP header | Отсутствует `Content-Length` | Добавьте заголовок `Content-Length` |
| `MissingContentMD5` | Missing required header: Content-MD5 | Отсутствует `Content-MD5` | Добавьте заголовок `Content-MD5` |
| `BadDigest` | The Content-Md5 you specified did not match | MD5 не совпадает | Пересчитайте и отправьте правильный MD5 |
| `EntityTooSmall` | Your proposed upload is smaller than minimum | Объект слишком мал | Увеличьте размер объекта |
| `EntityTooLarge` | Your proposed upload exceeds maximum | Объект слишком велик | Разделите объект на части |
| `KeyTooLong` | Your key is too long | Ключ слишком длинный | Используйте более короткий ключ |
| `InvalidRequest` | Invalid Request | Общая ошибка запроса | Проверьте формат запроса |
| `MalformedPOSTRequest` | The body is not well-formed multipart/form-data | Некорректный POST-запрос | Проверьте формат POST-данных |
| `InvalidPolicyDocument` | Invalid Policy | Некорректная политика | Проверьте синтаксис политики |
| `BucketsCountQuotaInCloudExceeded` | Maximal amount of buckets exceeded | Превышена квота бакетов | Удалите лишние бакеты или запросите увеличение квоты |
| `BucketMaxSizeExceeded` | Max size configured for bucket exceeded | Превышен размер бакета | Удалите объекты или запросите увеличение квоты |


#### HTTP 401 Unauthorized — Ошибки аутентификации {#http-401-unauthorized}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `Unauthorized` | Unauthorized | Не авторизован | Проверьте учетные данные |
| `UserNotFound` | Requested user is not found | Пользователь не найден | Проверьте ключи доступа |


#### HTTP 403 Forbidden — Ошибки авторизации {#http-403-forbidden}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `AccessDenied` | Access Denied | Доступ запрещен | Проверьте права доступа |
| `NotSignedUp` | Your account is not signed up for S3 | Аккаунт не зарегистрирован | Зарегистрируйте аккаунт в S3 |
| `AccountProblem` | Problem with your account | Проблема с аккаунтом | Исследуйте логи приложения |
| `InvalidAccessKeyId` | Access key ID does not exist | Неверный ключ доступа | Проверьте идентификатор ключа доступа |
| `TooManyAccessKeys` | Too many access keys | Слишком много ключей | Удалите лишние ключи доступа |
| `SignatureDoesNotMatch` | Signature does not match | Подпись не совпадает | Проверьте секретный ключ и метод подписи |
| `RequestTimeTooSkewed` | Request time too different from current | Время запроса слишком отличается | Синхронизируйте время клиента |
| `ExpiredPresignRequest` | Request has expired | Presigned URL истек | Сгенерируйте новый Presigned URL |
| `AllAccessDisabled` | All access to this bucket disabled | Весь доступ отключен | Проверьте настройки бакета |
| `InvalidObjectState` | Operation not valid for current state | Неверное состояние объекта | Проверьте состояние объекта |
| `LockedDeletedObject` | Object to be deleted is locked | Объект заблокирован | Дождитесь истечения срока блокировки |


#### HTTP 404 Not Found — Ресурс не найден {#http-404-not-found}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `NoSuchBucket` | The specified bucket does not exist | Бакет не существует | Проверьте имя бакета |
| `NoSuchKey` | The specified key does not exist | Объект не существует | Проверьте путь к объекту |
| `NoSuchUpload` | The specified multipart upload does not exist | Составная загрузка не существует | Начните новую составную загрузку |
| `NoSuchVersion` | The specified version does not exist | Версия не существует | Проверьте идентификатор версии |
| `NoSuchWebsiteConfiguration` | Bucket does not have website configuration | Нет конфигурации website | Настройте конфигурацию website |
| `NoSuchBucketPolicy` | The bucket policy does not exist | Нет политики бакета | Создайте политику бакета |
| `NoSuchCORSConfiguration` | The CORS configuration does not exist | Нет конфигурации CORS | Настройте CORS |
| `NoSuchLifecycleConfiguration` | The lifecycle configuration does not exist | Нет конфигурации жизненного цикла | Настройте правила жизненного цикла |
| `NoSuchConfiguration` | The specified configuration does not exist | Конфигурация не существует | Проверьте параметры конфигурации |
| `NoSuchFolder` | The specified folder does not exist | Папка не существует | Проверьте путь к папке |
| `NoSuchCloud` | The specified cloud does not exist | Облако не существует | Проверьте идентификатор облака |
| `NoSuchOperation` | The specified operation does not exist | Операция не существует | Проверьте тип операции |
| `NoSuchHTTPSConfig` | No such HTTPS config | HTTPS-конфигурация не найдена | Настройте HTTPS-конфигурацию |


#### HTTP 409 Conflict — Конфликт ресурсов {#http-409-conflict}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `BucketAlreadyExists` | The requested bucket name is not available | Бакет уже существует | Выберите другое имя бакета |
| `BucketAlreadyOwnedByYou` | You already own this bucket | Вы уже владеете бакетом | Используйте существующий бакет |
| `BucketNotEmpty` | The bucket is not empty | Бакет не пустой | Удалите все объекты из бакета |
| `FolderNotEmpty` | The folder is not empty | Папка не пустая | Удалите все объекты из папки |
| `InvalidBucketState` | Bucket versioning must be enabled | Неверное состояние бакета | Включите versioning для бакета |
| `ConcurrentUpdatesPatchConflict` | Failed to apply patch due to concurrent updates | Конфликт при патче | Повторите операцию позже |
| `ConditionalRequestConflict` | Conditional request cannot succeed | Конфликт условного запроса | Проверьте условия запроса |


#### HTTP 429 Too Many Requests — Превышение лимитов {#http-429-too-many-requests}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `TooManyRequests` | Reduce request rate | Слишком много запросов | Уменьшите частоту запросов |
| `SubtasksNotFinished` | Subtasks are not finished yet | Подзадачи не завершены | Дождитесь завершения подзадач |


#### HTTP 500 Internal Server Error — Внутренние ошибки {#http-500-internal-server-error}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `InternalError` | We encountered an internal error | Внутренняя ошибка сервера | Исследуйте логи приложения |
| `BucketInTransit` | Bucket in transit | Бакет в процессе переноса | Дождитесь завершения переноса |


#### HTTP 501 Not Implemented — Не реализовано {#http-501-not-implemented}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `NotImplemented` | Functionality not implemented | Функционал не реализован | Используйте альтернативный метод |


#### HTTP 503 Service Unavailable — Сервис недоступен {#http-503-service-unavailable}

| Код ошибки | Описание | Причина | Возможные действия |
|------------|-------------|---------|-------------------|
| `ServiceUnavailable` | Reduce your request rate | Сервис недоступен | Уменьшите частоту запросов |
| `Busy` | The service is unavailable. Please retry | Сервис занят | Повторите запрос позже |


## Database Driver Error Codes (PostgreSQL SQLSTATE) {#database-driver-error-codes}

### S3-специфичные коды (логические ошибки) {#s3-specific-codes}

#### Account Errors (S3Axx) {#account-errors}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `S3A01` | ErrAccountAccessDenied | AccessDenied | Нет доступа к аккаунту | Проверьте права доступа к аккаунту |
| `S3A02` | ErrAccountNotSignedUp | NotSignedUp | Аккаунт не зарегистрирован в S3 | Зарегистрируйте аккаунт в S3 |
| `S3A03` | ErrAccountProblem | AccountProblem | Временная проблема с аккаунтом | Исследуйте логи приложения |
| `S3A04` | ErrAccountInvalidAccessKeyID | InvalidAccessKeyId | Неверный идентификатор ключа доступа | Проверьте идентификатор ключа доступа |
| `S3A05` | ErrAccountTooManyAccessKeys | TooManyAccessKeys | Превышен лимит ключей доступа | Удалите лишние ключи доступа |


#### Bucket Errors (S3Bxx) {#bucket-errors}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `S3B01` | ErrNoSuchBucket | NoSuchBucket | Бакет не существует | Проверьте имя бакета |
| `S3B02` | ErrBucketAlreadyExists | BucketAlreadyExists | Бакет уже существует | Выберите другое имя бакета |
| `S3B03` | ErrBucketAccessDenied | AccessDenied | Нет доступа к бакету | Проверьте права доступа к бакету |
| `S3B04` | ErrBucketServiceUnavailable | ServiceUnavailable | Временные проблемы с бакетом | Исследуйте логи приложения |
| `S3B05` | ErrBucketAlreadyOwnedByYou | BucketAlreadyOwnedByYou | Вы уже владеете бакетом | Используйте существующий бакет |
| `S3B06` | ErrBucketHasObjects | BucketHasObjects | Нельзя удалить бакет с объектами | Удалите все объекты из бакета |
| `S3B07` | ErrBucketHasObjectParts | BucketHasObjectParts | Нельзя удалить бакет с незавершенными загрузками | Завершите или отмените все составные загрузки |


#### Key/Object Errors (S3Kxx) {#key-object-errors}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `S3K01` | ErrNoSuchKey | NoSuchKey | Объект не существует | Проверьте путь к объекту |
| `S3K02` | ErrKeyNoSuchVersion | NoSuchVersion | Версия объекта не существует | Проверьте идентификатор версии объекта |
| `S3K03` | ErrKeyEntityTooLarge | EntityTooLarge | Объект слишком большой (более 5 ГБ) | Разделите объект на части |
| `S3K04` | ErrTransactionTooOld | TransactionTooOld | Транзакция слишком старая | Повторите операцию |
| `S3K05` | ErrConditionalWriteOnConflict | ConditionalWriteOnConflict | Конфликт условной записи | Проверьте условия записи |
| `S3K06` | ErrConditionalWriteOnIfMatch | ConditionalWriteOnIfMatch | Ошибка условия `If-Match` | Проверьте `ETag` объекта |
| `S3K07` | ErrConditionalWriteOnIfNoneMatch | ConditionalWriteOnIfNoneMatch | Ошибка условия `If-None-Match` | Проверьте отсутствие объекта |


#### Multipart Upload Errors (S3Mxx) {#multipart-upload-errors}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `S3M01` | ErrNoSuchUpload | NoSuchUpload | Составная загрузка не существует | Начните новую составную загрузку |
| `S3M02` | ErrUploadInvalidPart | InvalidPart | Часть загрузки отсутствует | Проверьте номера частей |
| `S3M03` | ErrUploadInvalidPartOrder | InvalidPartOrder | Неверный порядок частей | Отправьте части в правильном порядке |
| `S3M04` | ErrUploadEntityTooSmall | EntityTooSmall | Часть слишком мала (менее 5 МБ) | Увеличьте размер части |
| `S3M05` | ErrUploadEntityTooLarge | EntityTooLarge | Часть слишком велика (более 5 ГБ) | Уменьшите размер части |


#### Other S3 Errors {#other-s3-errors}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `S3D02` | ErrLockedDeletedObject | Object is locked | Объект заблокирован для удаления | Дождитесь истечения срока блокировки |
| `S3X01` | ErrNoSuchChunk | No such chunk | Чанк не существует | Повторите запрос |
| `S3X03` | ErrChunkInTransit | Chunk in transit | Чанк в процессе переноса | Дождитесь завершения переноса |
| `S3P01` | ErrPatchNotFound | PatchNotFound | Patch-запрос не найден | Повторите операцию патчинга |
| `S3P02` | ErrFatalPatchConflict | FatalPatchConflict | Неразрешимый конфликт патча | Исследуйте логи приложения |
| `S3P03` | ErrPatchWrongEncryptionState | WrongEncryptionState | Неверное состояние шифрования | Проверьте параметры шифрования |
| `S3I01` | ErrTooManyInventoryConfigs | TooManyInventoryConfigs | Слишком много inventory-конфигураций | Удалите лишние конфигурации |


### PostgreSQL SQLSTATE коды {#postgresql-sqlstate-codes}

| Код ошибки | Название ошибки | Описание | Причина | Возможные действия |
|------|------------|-------------|---------|-------------------|
| `08P01` | ErrConnectToServer | failed to connect to server | Ошибка подключения к серверу | Проверьте сетевую связность и настройки подключения |
| `57P01` | ErrTerminatingConnection | admin_shutdown | Соединение прервано администратором | Дождитесь восстановления сервиса |
| `57P03` | ErrDatabaseIsShuttingDown | database system is shutting down | База данных выключается | Дождитесь перезапуска БД |
| `53300` | ErrTooManyActiveClients | too many active clients | Слишком много активных клиентов | Уменьшите количество параллельных подключений |
| `55P03` | ErrLockTimeout | lock_not_available | Таймаут блокировки | Повторите операцию позже |
| `40001` | ErrSerializationFailure | serialization_failure | Ошибка сериализации транзакции | Повторите транзакцию |
| `40P01` | ErrDeadlockDetected | deadlock_detected | Обнаружен deadlock | Повторите транзакцию |
| `25006` | ErrReadOnlySQLTransaction | read_only_sql_transaction | Попытка записи в read-only транзакции | Проверьте режим транзакции |
| `23505` | ErrUniqueConstraint | duplicate key value | Нарушение уникальности | Измените данные для соблюдения уникальности |
| `23503` | ErrForeignKeyViolation | foreign key constraint | Нарушение внешнего ключа | Проверьте ссылочную целостность |
| `28P01` | ErrWrongPassword | incorrect password | Неверный пароль | Проверьте учетные данные |
| `42804` | ErrDatatypeMismatch | datatype mismatch | Несоответствие типов данных | Проверьте типы данных в запросе |
| `XX000` | ErrInternalError | internal_error | Внутренняя ошибка PostgreSQL | Исследуйте логи приложения |


## gRPC Status Codes Mapping {#grpc-status-codes-mapping}

| HTTP Status | gRPC Code | Описание |
|-------------|-----------|----------|
| 400 Bad Request | `InvalidArgument` | Неверные аргументы |
| 401 Unauthorized | `Unauthenticated` | Не аутентифицирован |
| 403 Forbidden | `PermissionDenied` | Доступ запрещен |
| 404 Not Found | `NotFound` | Ресурс не найден |
| 406 Not Acceptable | `FailedPrecondition` | Предусловие не выполнено |
| 409 Conflict | `AlreadyExists` | Ресурс уже существует |
| 412 Precondition Failed | `FailedPrecondition` | Предусловие не выполнено |
| 416 Range Not Satisfiable | `OutOfRange` | Диапазон вне границ |
| 429 Too Many Requests | `ResourceExhausted` | Ресурсы исчерпаны |
| 500 Internal Server Error | `Internal` | Внутренняя ошибка |
| 501 Not Implemented | `Unimplemented` | Не реализовано |
| 503 Service Unavailable | `Unavailable` | Сервис недоступен |