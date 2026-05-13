# yc managed-clickhouse cluster get

Get information about a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster get <CLUSTER-NAME>|<CLUSTER-ID> [<CLUSTER-NAME>|<CLUSTER-ID>...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--full` | Also show the entirety of the default and the effective ClickHouse configurations. ||
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

 * [Задать настройки ClickHouse® через интерфейсы Yandex Cloud](../../../../../managed-clickhouse/operations/change-server-level-settings.md#cli_1)
 * [Создать кластер с ClickHouse® Keeper](../../../../../managed-clickhouse/operations/cluster-create.md#cli_1)
 * [Получить детальную информацию о кластере](../../../../../managed-clickhouse/operations/cluster-list.md#cli_2)
 * [Получение патч-версии ClickHouse®](../../../../../managed-clickhouse/operations/cluster-patch-version.md#cli_1)
 * [Получить список словарей](../../../../../managed-clickhouse/operations/dictionaries.md#cli_1)
 * [Изменить дополнительные настройки кластера](../../../../../managed-clickhouse/operations/update.md#cli_4)