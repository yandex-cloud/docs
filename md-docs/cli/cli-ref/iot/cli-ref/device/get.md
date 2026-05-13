# yc iot device get

Show information about specified device

#### Command Usage

Syntax:

`yc iot device get <DEVICE-NAME>|<DEVICE-ID> [<DEVICE-NAME>|<DEVICE-ID>...] [Flags...] [Global Flags...]`

Aliases:

- `describe`

- `show`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Device id. ||
|| `--name` | `string`

Device name. ||
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

 * [Создание алиаса в Yandex IoT Core](../../../../../iot-core/operations/device/alias/alias-create.md#tf_1)
 * [Удаление алиаса](../../../../../iot-core/operations/device/alias/alias-delete.md#tf_1)
 * [Изменение алиаса](../../../../../iot-core/operations/device/alias/alias-update.md#tf_1)
 * [Получить информацию об устройстве](../../../../../iot-core/operations/device/device-list.md#cli_2)
 * [Изменить описание устройства](../../../../../iot-core/operations/device/device-update.md#tf_2)