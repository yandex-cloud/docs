# yc cdn origin-group list

List origin groups in the specified folder

#### Command Usage

Syntax:

`yc cdn origin-group list [Flags...] [Global Flags...]`

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

 * [Подключение группы источников при создании ресурса](../../../../../cdn/operations/origin-groups/bind-group-to-resource.md#cli_1)
 * [Создание группы источников](../../../../../cdn/operations/origin-groups/create-group.md#tf_1)
 * [Удаление одной группы источников](../../../../../cdn/operations/origin-groups/delete-group.md#cli_1)
 * [Редактирование группы](../../../../../cdn/operations/origin-groups/edit-group.md#cli_1)
 * [Создать ресурс с пользовательским именем сервера для SNI](../../../../../cdn/operations/resources/configure-server-name.md#cli_1)
 * [Создание ресурса](../../../../../cdn/operations/resources/create-resource.md#cli_1)