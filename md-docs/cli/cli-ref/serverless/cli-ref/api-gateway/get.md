# yc serverless api-gateway get

Get API Gateway

#### Command Usage

Syntax:

`yc serverless api-gateway get <API-GATEWAY-NAME>|<API-GATEWAY-ID> [<API-GATEWAY-NAME>|<API-GATEWAY-ID>...] [Flags...] [Global Flags...]`

Aliases:

- `describe`

- `show`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Api-gateway id. ||
|| `--name` | `string`

Api-gateway name. ||
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

 * [Настроить канареечный релиз](../../../../../api-gateway/operations/api-gw-canary.md#tf_1)
 * [Создание API-шлюза](../../../../../api-gateway/operations/api-gw-create.md#tf_1)
 * [Изменить API-шлюз](../../../../../api-gateway/operations/api-gw-update.md#tf_1)
 * [Настроить переменные](../../../../../api-gateway/operations/api-gw-vars.md#tf_1)
 * [Добавить метку API-шлюзу](../../../../../api-gateway/operations/label-add.md#cli_1)
 * [Удалить метку API-шлюза](../../../../../api-gateway/operations/label-delete.md#cli_1)
 * [Изменить метку API-шлюза](../../../../../api-gateway/operations/label-update.md#cli_1)