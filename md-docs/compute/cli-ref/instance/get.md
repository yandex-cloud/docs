# yc compute instance get

Show information about the specified virtual machine instance

#### Command Usage

Syntax:

`yc compute instance get <INSTANCE-NAME>|<INSTANCE-ID> [<INSTANCE-NAME>|<INSTANCE-ID>...] [--full] [Global Flags...]`

Aliases:

- `describe`

- `show`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--full` | Whether description should include metadata of the instance ||
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

 * [Подключить файловое хранилище к виртуальной машине](../../operations/filesystem/attach-to-vm.md#tf_1)
 * [Отключить файловое хранилище от виртуальной машины](../../operations/filesystem/detach-from-vm.md#tf_1)
 * [Добавить виртуальную машину в кластер GPU](../../operations/gpu-cluster/gpu-add-to-cluster.md#tf_1)
 * [Создайте пароль для пользователя Linux](../../operations/serial-console/index.md)
 * [Добавление SSH-ключей для других пользователей](../../operations/vm-connect/ssh.md)
 * [Добавление сетевого интерфейса на остановленную ВМ](../../operations/vm-control/attach-network-interface.md#cli_1)
 * [Удалить сетевой интерфейс на виртуальной машине](../../operations/vm-control/detach-network-interface.md#cli_1)
 * [Изменить внутренний IP-адрес виртуальной машины](../../operations/vm-control/internal-ip-update.md#cli_1)
 * [Подключить диск](../../operations/vm-control/vm-attach-disk.md#cli_1)
 * [Привязать к виртуальной машине публичный IP-адрес](../../operations/vm-control/vm-attach-public-ip.md#cli_1)
 * [Изменить подсеть ВМ](../../operations/vm-control/vm-change-folder.md#cli_2)
 * [Перенести ВМ в зону ru-central1-d с помощью специальной команды](../../operations/vm-control/vm-change-zone.md#cli_4)
 * [Отключить диск от виртуальной машины](../../operations/vm-control/vm-detach-disk.md#cli_1)
 * [Отвязать публичный IP-адрес от виртуальной машины](../../operations/vm-control/vm-detach-public-ip.md#cli_1)
 * [Привяжите IP-адрес к новой ВМ](../../operations/vm-control/vm-transferring-public-ip.md#cli_4)
 * [Проверьте обработку событий обслуживания](../../operations/vm-control/vm-update-policies.md)
 * [Изменить конфигурацию vCPU и RAM](../../operations/vm-control/vm-update-resources.md#cli_1)
 * [Создание виртуальной машины с GPU](../../operations/vm-create/create-vm-with-gpu.md#cli_1)
 * [Создать виртуальную машину с метаданными из переменных окружения](../../operations/vm-create/create-with-env-variables.md)
 * [Получить информацию снаружи ВМ](../../operations/vm-info/get-info.md#cli_1)
 * [Доступ к метаданным снаружи ВМ](../../operations/vm-metadata/get-vm-metadata.md#cli_1)
 * [Настроить параметры сервиса метаданных ВМ](../../operations/vm-metadata/setup-metadata-service.md#tf_1)