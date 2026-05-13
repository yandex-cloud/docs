# yc compute instance-group list

List instance groups

#### Command Usage

Syntax:

`yc compute instance-group list [Flags...] [Global Flags...]`

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

 * [Назначить роль](../../../../../compute/operations/instance-groups/access.md#cli_1)
 * [Удалить группу виртуальных машин](../../../../../compute/operations/instance-groups/delete.md#cli_1)
 * [Отключить зону доступности](../../../../../compute/operations/instance-groups/disable-enable-zone.md#cli_1)
 * [Настроить проверку состояния приложения на ВМ](../../../../../compute/operations/instance-groups/enable-autohealing.md#cli_1)
 * [Включить защиту от удаления для группы виртуальных машин Compute Cloud](../../../../../compute/operations/instance-groups/enable-deletion-protection.md#cli_1)
 * [Получить информацию о группе виртуальных машин](../../../../../compute/operations/instance-groups/get-info.md#cli_1)
 * [Получить список виртуальных машин в группе](../../../../../compute/operations/instance-groups/get-list-instances.md#cli_1)
 * [Получить список групп виртуальных машин](../../../../../compute/operations/instance-groups/get-list.md#cli_1)
 * [Перенести группу виртуальных машин с L7-балансировщиком в другую зону доступности](../../../../../compute/operations/instance-groups/move-group-with-alb.md#cli_2)
 * [Перенести группу виртуальных машин с сетевым балансировщиком нагрузки в другую зону доступности](../../../../../compute/operations/instance-groups/move-group-with-nlb.md#cli_1)
 * [Перенести группу виртуальных машин в другую зону доступности](../../../../../compute/operations/instance-groups/move-group.md#cli_1)
 * [Поочередно пересоздать виртуальные машины в группе](../../../../../compute/operations/instance-groups/rolling-recreate.md#cli_1)
 * [Поочередно перезагрузить виртуальные машины в группе](../../../../../compute/operations/instance-groups/rolling-restart.md#cli_1)
 * [Запустить группу виртуальных машин](../../../../../compute/operations/instance-groups/start.md#cli_1)
 * [Остановить группу виртуальных машин](../../../../../compute/operations/instance-groups/stop.md#cli_1)
 * [Изменить имя и описание](../../../../../compute/operations/instance-groups/update.md#cli_1)
 * [Исключить группу виртуальных машин из группы размещения](../../../../../compute/operations/placement-groups/delete-ig-from-pg.md#cli_1)