# yc serverless eventrouter connector list

List connectors

#### Command Usage

Syntax:

`yc serverless eventrouter connector list [Flags...] [Global Flags...]`

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

 * [Коннектор для API EventRouter](../../../../../../serverless-integrations/operations/eventrouter/bus/data-send.md#cli_1)
 * [Создать коннектор для Message Queue](../../../../../../serverless-integrations/operations/eventrouter/connector/create-message-queue.md#tf_1)
 * [Создать таймер](../../../../../../serverless-integrations/operations/eventrouter/connector/create-timer.md#tf_1)
 * [Создать коннектор для Data Streams](../../../../../../serverless-integrations/operations/eventrouter/connector/create-yds.md#tf_1)
 * [Удалить коннектор](../../../../../../serverless-integrations/operations/eventrouter/connector/delete.md#cli_1)
 * [Получить информацию о коннекторе](../../../../../../serverless-integrations/operations/eventrouter/connector/get-info.md#cli_1)
 * [Получить список коннекторов](../../../../../../serverless-integrations/operations/eventrouter/connector/get-list.md#cli_1)
 * [Добавить метку коннектору](../../../../../../serverless-integrations/operations/eventrouter/connector/label-add.md#tf_1)
 * [Удалить метку коннектора](../../../../../../serverless-integrations/operations/eventrouter/connector/label-delete.md#tf_1)
 * [Изменить метку коннектора](../../../../../../serverless-integrations/operations/eventrouter/connector/label-update.md#tf_1)
 * [Запустить коннектор](../../../../../../serverless-integrations/operations/eventrouter/connector/start.md#cli_1)
 * [Остановить коннектор](../../../../../../serverless-integrations/operations/eventrouter/connector/stop.md#cli_1)
 * [Изменить коннектор](../../../../../../serverless-integrations/operations/eventrouter/connector/update.md#cli_1)