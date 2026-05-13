# yc resource-manager cloud list

List clouds

#### Command Usage

Syntax:

`yc resource-manager cloud list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
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

 * [Создание нового облака](../../../../../resource-manager/operations/cloud/create.md#tf_1)
 * [Удаление облака](../../../../../resource-manager/operations/cloud/delete.md#cli_1)
 * [Получение идентификатора облака](../../../../../resource-manager/operations/cloud/get-id.md#cli_1)
 * [Назначить роль на облако](../../../../../resource-manager/operations/cloud/set-access-bindings.md#tf_1)
 * [Переключение на другое облако](../../../../../resource-manager/operations/cloud/switch-cloud.md#cli_1)
 * [Переименование облака](../../../../../resource-manager/operations/cloud/update.md#cli_1)