# yc compute instance list

List virtual machine instances

#### Command Usage

Syntax:

`yc compute instance list [Flags...] [Global Flags...]`

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

 * [Подключить файловое хранилище к виртуальной машине](../../operations/filesystem/attach-to-vm.md#cli_1)
 * [Отключить файловое хранилище от виртуальной машины](../../operations/filesystem/detach-from-vm.md#cli_1)
 * [Создать виртуальную машину из публичного образа](../../operations/images-with-pre-installed-software/create.md#cli_1)
 * [Привязать существующую ВМ к пулу](../../operations/reserved-pools/manage-pool-vms.md#cli_3)
 * [Подключиться к серийной консоли](../../operations/serial-console/connect-cli.md#linux%20c%20ssh-%d0%ba%d0%bb%d1%8e%d1%87%d0%be%d0%bc_1)
 * [Подключиться к серийной консоли](../../operations/serial-console/connect-ssh.md#%d0%a1%20ssh-%d1%81%d0%b5%d1%80%d1%82%d0%b8%d1%84%d0%b8%d0%ba%d0%b0%d1%82%d0%be%d0%bc%20%d0%bf%d0%be%20os%20login_1)
 * [Отключить доступ к серийной консоли](../../operations/serial-console/disable.md#cli_1)
 * [Включение консоли при изменении ВМ](../../operations/serial-console/index.md)
 * [Подключиться с помощью стандартного SSH-клиента](../../operations/vm-connect/os-login.md#ssh-key_1)
 * [Добавление сетевого интерфейса на остановленную ВМ](../../operations/vm-control/attach-network-interface.md#cli_1)
 * [Удалить сетевой интерфейс на виртуальной машине](../../operations/vm-control/detach-network-interface.md#cli_1)
 * [Изменить внутренний IP-адрес виртуальной машины](../../operations/vm-control/internal-ip-update.md#cli_1)
 * [Назначить роль](../../operations/vm-control/vm-access.md#cli_1)
 * [Подключить диск](../../operations/vm-control/vm-attach-disk.md#cli_1)
 * [Привязать к виртуальной машине публичный IP-адрес](../../operations/vm-control/vm-attach-public-ip.md#cli_1)
 * [Изменить каталог ВМ](../../operations/vm-control/vm-change-folder.md#cli_1)
 * [Удалите исходную виртуальную машину](../../operations/vm-control/vm-change-zone.md#cli_3)
 * [Удалить виртуальную машину](../../operations/vm-control/vm-delete.md#cli_1)
 * [Отключить диск от виртуальной машины](../../operations/vm-control/vm-detach-disk.md#cli_1)
 * [Отвязать публичный IP-адрес от виртуальной машины](../../operations/vm-control/vm-detach-public-ip.md#cli_1)
 * [Остановить](../../operations/vm-control/vm-stop-and-start.md#cli_1)
 * [Привяжите IP-адрес к новой ВМ](../../operations/vm-control/vm-transferring-public-ip.md#cli_4)
 * [Изменить конфигурацию vCPU и RAM](../../operations/vm-control/vm-update-resources.md#cli_1)
 * [Изменить виртуальную машину](../../operations/vm-control/vm-update.md#cli_1)
 * [Создайте виртуальную машину, работающую на оборудовании поколения Gen 2](../../operations/vm-create/create-gen2-vm.md#tf_5)
 * [Сменить тип ВМ](../../operations/vm-create/create-preemptible-vm.md#cli_2)
 * [Получить информацию снаружи ВМ](../../operations/vm-info/get-info.md#cli_1)
 * [Получить вывод последовательного порта](../../operations/vm-info/get-serial-port-output.md#cli_1)
 * [Доступ к метаданным снаружи ВМ](../../operations/vm-metadata/get-vm-metadata.md#cli_1)
 * [Настроить параметры сервиса метаданных ВМ](../../operations/vm-metadata/setup-metadata-service.md#cli_1)
 * [Включить доступ по OS Login](../../operations/vm-metadata/update-vm-metadata.md#cli_3)