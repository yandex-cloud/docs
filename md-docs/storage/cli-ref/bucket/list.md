# yc storage bucket list

Lists buckets of specified folder id

#### Command Usage

Syntax:

`yc storage bucket list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
#### Examples

 * [Открыть публичный доступ](../../operations/buckets/bucket-availability.md#cli_1)
 * [Настройка CORS](../../operations/buckets/cors.md#cli_1)
 * [Удаление бакета](../../operations/buckets/delete.md#cli_1)
 * [Запретить доступ в бакет с помощью статических ключей](../../operations/buckets/disable-statickey-auth.md#cli_1)
 * [Получить информацию о бакете](../../operations/buckets/get-info.md#cli_1)
 * [Получение списка бакетов](../../operations/buckets/get-list.md#cli_1)
 * [Управление жизненными циклами объектов в бакете](../../operations/buckets/lifecycles.md#cli_1)
 * [Ограничение максимального размера бакета](../../operations/buckets/limit-max-volume.md#cli_1)
 * [Добавить или изменить метки](../../operations/buckets/tagging.md#cli_1)
 * [Копирование одного объекта](../../operations/objects/copy.md#cli_1)
 * [Удаление всех объектов из бакета](../../operations/objects/delete-all.md#cli_1)
 * [Удалить объект или версию объекта без блокировки](../../operations/objects/delete.md#cli_1)
 * [Удаление частично загруженного объекта](../../operations/objects/deleting-multipart.md#cli_1)
 * [Скачивание объекта](../../operations/objects/download.md#cli_1)
 * [Установить или настроить временную блокировку (governance или compliance)](../../operations/objects/edit-object-lock.md#cli_1)
 * [Получение информации об объекте](../../operations/objects/info.md#cli_1)
 * [Получение подписанной ссылки (pre-signed URL) на скачивание объекта](../../operations/objects/link-for-download.md#cli_1)
 * [Получение подписанной ссылки (pre-signed URL) на загрузку объекта](../../operations/objects/link-for-upload.md#cli_1)
 * [Получение списка объектов в бакете](../../operations/objects/list.md#cli_1)
 * [Создайте составную загрузку в бакете](../../operations/objects/multipart-upload.md#cli_1)
 * [Загрузить объект с метаданными](../../operations/objects/object-meta.md#cli_1)
 * [Переименование](../../operations/objects/rename-move.md#cli_1)
 * [Добавить или изменить метки](../../operations/objects/tagging.md#cli_1)
 * [Простая загрузка](../../operations/objects/upload.md#cli_1)