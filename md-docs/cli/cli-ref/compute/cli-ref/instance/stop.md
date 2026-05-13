# yc compute instance stop

Stop the specified virtual machine instance

#### Command Usage

Syntax:

`yc compute instance stop <INSTANCE-NAME>|<INSTANCE-ID> [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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

 * [Добавить виртуальную машину в группу размещения](../../../../../compute/operations/placement-groups/add-vm.md#cli_1)
 * [Исключить виртуальную машину из группы размещения](../../../../../compute/operations/placement-groups/delete-vm.md#cli_1)
 * [Добавление сетевого интерфейса на остановленную ВМ](../../../../../compute/operations/vm-control/attach-network-interface.md#cli_1)
 * [Удалить сетевой интерфейс на виртуальной машине](../../../../../compute/operations/vm-control/detach-network-interface.md#cli_1)
 * [Подключить диск](../../../../../compute/operations/vm-control/vm-attach-disk.md#cli_1)
 * [Изменить подсеть ВМ](../../../../../compute/operations/vm-control/vm-change-folder.md#cli_2)
 * [Отключить диск от виртуальной машины](../../../../../compute/operations/vm-control/vm-detach-disk.md#cli_1)
 * [Остановить](../../../../../compute/operations/vm-control/vm-stop-and-start.md#cli_1)
 * [Изменить конфигурацию vCPU и RAM](../../../../../compute/operations/vm-control/vm-update-resources.md#cli_1)
 * [Сменить тип ВМ](../../../../../compute/operations/vm-create/create-preemptible-vm.md#cli_2)