# yc serverless eventrouter rule list

List rulees

#### Command Usage

Syntax:

`yc serverless eventrouter rule list [Flags...] [Global Flags...]`

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

 * [Добавить приемник](../../../../../../serverless-integrations/operations/eventrouter/rule/add-target.md#tf_1)
 * [Создать правило с приемником Yandex API Gateway](../../../../../../serverless-integrations/operations/eventrouter/rule/create-api-gw.md#tf_1)
 * [Создать правило с приемником Yandex Data Streams](../../../../../../serverless-integrations/operations/eventrouter/rule/create-data-streams.md#tf_1)
 * [Создать правило с приемником Yandex Cloud Functions](../../../../../../serverless-integrations/operations/eventrouter/rule/create-functions.md#tf_1)
 * [Создать правило с приемником Yandex Cloud Logging](../../../../../../serverless-integrations/operations/eventrouter/rule/create-logging.md#tf_1)
 * [Создать правило с приемником Yandex Message Queue](../../../../../../serverless-integrations/operations/eventrouter/rule/create-message-queue.md#tf_1)
 * [Создать правило с приемником Yandex Serverless Containers](../../../../../../serverless-integrations/operations/eventrouter/rule/create-serverless-containers.md#tf_1)
 * [Создать правило с приемником Yandex Workflows](../../../../../../serverless-integrations/operations/eventrouter/rule/create-workflows.md#tf_1)
 * [Удалить приемник](../../../../../../serverless-integrations/operations/eventrouter/rule/delete-target.md#tf_1)
 * [Удалить правило](../../../../../../serverless-integrations/operations/eventrouter/rule/delete.md#cli_1)
 * [Выключить правило](../../../../../../serverless-integrations/operations/eventrouter/rule/disable.md#cli_1)
 * [Включить правило](../../../../../../serverless-integrations/operations/eventrouter/rule/enable.md#cli_1)
 * [Получить информацию о правиле](../../../../../../serverless-integrations/operations/eventrouter/rule/get-info.md#cli_1)
 * [Получить список правил](../../../../../../serverless-integrations/operations/eventrouter/rule/get-list.md#cli_1)
 * [Добавить метку правилу](../../../../../../serverless-integrations/operations/eventrouter/rule/label-add.md#tf_1)
 * [Удалить метку правила](../../../../../../serverless-integrations/operations/eventrouter/rule/label-delete.md#tf_1)
 * [Изменить метку правила](../../../../../../serverless-integrations/operations/eventrouter/rule/label-update.md#tf_1)
 * [Изменить приемник](../../../../../../serverless-integrations/operations/eventrouter/rule/update-target.md#tf_1)
 * [Изменить правило](../../../../../../serverless-integrations/operations/eventrouter/rule/update.md#cli_1)