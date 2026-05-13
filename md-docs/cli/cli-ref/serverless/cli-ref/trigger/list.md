# yc serverless trigger list

List triggers

#### Command Usage

Syntax:

`yc serverless trigger list [Flags...] [Global Flags...]`

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

 * [Получить список триггеров в API Gateway](../../../../../api-gateway/operations/trigger/trigger-list.md#cli_1)
 * [Создать триггер](../../../../../functions/operations/trigger/cloud-logging-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/cr-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/data-streams-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/iot-core-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/mail-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/os-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../functions/operations/trigger/timer-create.md#tf_1)
 * [Удалить триггер в Cloud Functions](../../../../../functions/operations/trigger/trigger-delete.md#tf_1)
 * [Получить список триггеров в Cloud Functions](../../../../../functions/operations/trigger/trigger-list.md#cli_1)
 * [Создать триггер](../../../../../functions/operations/trigger/ymq-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/cloud-logging-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/cr-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/data-streams-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/iot-core-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/mail-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/os-trigger-create.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/timer-create.md#tf_1)
 * [Удалить триггер в Serverless Containers](../../../../../serverless-containers/operations/trigger-delete.md#tf_1)
 * [Получить список триггеров в Serverless Containers](../../../../../serverless-containers/operations/trigger-list.md#cli_1)
 * [Изменить триггер в Serverless Containers](../../../../../serverless-containers/operations/trigger-update.md#tf_1)
 * [Создать триггер](../../../../../serverless-containers/operations/ymq-trigger-create.md#tf_1)