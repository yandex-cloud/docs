# yc organization-manager idp userpool list

List user pools

#### Command Usage

Syntax:

`yc organization-manager idp userpool list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
|| `--filter` | `string`

Filter expression for userpools ||
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

 * [Добавьте локальных пользователей](../../../../../../organization/operations/add-account.md#cli_2)
 * [Удалить локального пользователя](../../../../../../organization/operations/edit-account.md#cli_1)
 * [Активировать локального пользователя](../../../../../../organization/operations/user-pools/activate-user.md#cli_2)
 * [Создать пул пользователей](../../../../../../organization/operations/user-pools/create-userpool.md#tf_1)
 * [Деактивировать локального пользователя](../../../../../../organization/operations/user-pools/deactivate-user.md#cli_2)
 * [Удалить пул пользователей](../../../../../../organization/operations/user-pools/delete-userpool.md#tf_1)
 * [Изменить данные пользователя](../../../../../../organization/operations/user-pools/edit-user.md#cli_1)
 * [Получить список пулов пользователей](../../../../../../organization/operations/user-pools/get-list-userpools.md#cli_1)
 * [Сбросить пароль](../../../../../../organization/operations/user-pools/reset-user-password.md#cli_1)
 * [Настроить доступ пользователям пула](../../../../../../organization/operations/user-pools/set-access-bindings-userpool.md#cli_1)
 * [Настроить парольную политику](../../../../../../organization/operations/user-pools/set-password-policy.md#cli_1)
 * [Локальные пользователи](../../../../../../organization/operations/users-get.md#cli_2)