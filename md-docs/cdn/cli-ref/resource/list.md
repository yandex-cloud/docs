# yc cdn resource list

List resources in the specified folder

#### Command Usage

Syntax:

`yc cdn resource list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--no-options` | Enable resource view without options ||
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

 * [Подключение группы источников при изменении настроек ресурса](../../operations/origin-groups/bind-group-to-resource.md#cli_2)
 * [Изменение основных настроек ресурса](../../operations/resources/configure-basics.md#tf_1)
 * [Настройка кеширования ресурса](../../operations/resources/configure-caching.md#tf_1)
 * [Настройка CORS при ответах клиентам](../../operations/resources/configure-cors.md#tf_1)
 * [Настройка HTTP-заголовков запросов и ответов](../../operations/resources/configure-headers.md#tf_1)
 * [Настройка HTTP-методов](../../operations/resources/configure-http.md#tf_1)
 * [Создать ресурс с пользовательским именем сервера для SNI](../../operations/resources/configure-server-name.md#tf_1)
 * [Создание ресурса](../../operations/resources/create-resource.md#tf_1)
 * [Удаление ресурса](../../operations/resources/delete-resource.md#cli_1)
 * [Отключение ресурса](../../operations/resources/disable-resource.md#tf_1)
 * [Включение сжатия файлов](../../operations/resources/enable-compression.md#tf_1)
 * [Включение доступа](../../operations/resources/enable-secure-token.md#console_1)
 * [Включение сегментации файлов](../../operations/resources/enable-segmentation.md#tf_1)
 * [Добавить или изменить метки](../../operations/resources/labeling.md#cli_1)
 * [Принудительная загрузка файлов в кеш CDN-серверов](../../operations/resources/prefetch-files.md#cli_1)
 * [Очистка кеша ресурса](../../operations/resources/purge-cache.md#cli_1)
 * [Настройка перенаправления запросов](../../operations/resources/setup-http-rewrite.md#cli_1)