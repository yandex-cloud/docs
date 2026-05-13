# yc vpc address list

List addresses in a folder.

#### Command Usage

Syntax:

`yc vpc address list [Flags...] [Global Flags...]`

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

 * [Удалить статический публичный IP-адрес](../../operations/address-delete.md#cli_1)
 * [Переместить публичный IP-адрес в другой каталог](../../operations/address-move.md#cli_1)
 * [Включить защиту от удаления](../../operations/deletion-protection.md#cli_1)
 * [Включение защиты от DDoS-атак при резервировании адреса](../../operations/enable-ddos-protection.md#tf_1)
 * [Зарезервировать статический публичный IP-адрес](../../operations/get-static-ip.md#tf_1)
 * [Сделать статический публичный IP-адрес динамическим](../../operations/set-dynamic-ip.md#cli_1)
 * [Сделать динамический публичный IP-адрес статическим](../../operations/set-static-ip.md#cli_1)