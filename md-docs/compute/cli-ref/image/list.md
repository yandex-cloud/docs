# yc compute image list

List images

#### Command Usage

Syntax:

`yc compute image list [Flags...] [Global Flags...]`

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

 * [Восстановить диск с помощью образа](../../operations/disk-create/from-image.md#cli_1)
 * [Назначить роль](../../operations/image-control/access.md#cli_1)
 * [Удалить образ диска](../../operations/image-control/delete.md#cli_1)
 * [Зашифровать образ](../../operations/image-control/encrypt.md#cli_1)
 * [Получить список образов дисков](../../operations/image-control/get-list.md#cli_1)
 * [Импортировать образ из другого облака или каталога](../../operations/image-control/import.md)
 * [Создать образ из другого пользовательского образа](../../operations/image-create/create-from-image.md#cli_1)
 * [Создайте образ в Compute Cloud](../../operations/image-create/upload.md#tf_1)
 * [Создать виртуальную машину из публичного образа](../../operations/images-with-pre-installed-software/create.md#cli_1)
 * [Получить список публичных образов](../../operations/images-with-pre-installed-software/get-list.md#cli_1)
 * [Создать автоматически масштабируемую группу виртуальных машин](../../operations/instance-groups/create-autoscaled-group.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера](../../operations/instance-groups/create-fixed-group.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера с сетевым балансировщиком нагрузки](../../operations/instance-groups/create-with-balancer.md#cli_1)
 * [Создать группу виртуальных машин с подключением к Yandex Object Storage](../../operations/instance-groups/create-with-bucket.md#cli_1)
 * [Создать группу виртуальных машин с подключением к файловому хранилищу](../../operations/instance-groups/create-with-filesystem.md#cli_1)
 * [Создать группу виртуальных машин с фиксированными IP-адресами](../../operations/instance-groups/create-with-fixed-ip.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера с L7-балансировщиком](../../operations/instance-groups/create-with-load-balancer.md#cli_1)
 * [Создать группу виртуальных машин в группе размещения](../../operations/placement-groups/create-ig-in-pg.md#cli_1)
 * [Включение консоли при создании ВМ из публичного образа](../../operations/serial-console/index.md#linux_1)
 * [Перенести виртуальную машину в другое облако](../../operations/vm-control/vm-change-cloud.md#cli_1)
 * [Создайте ВМ из подготовленного образа](../../operations/vm-create/create-from-user-image.md#cli_1)
 * [Создайте в Compute Cloud образ с закреплением поколения оборудования Gen 2](../../operations/vm-create/create-gen2-vm.md#tf_1)
 * [Создать виртуальную машину из публичного образа Linux](../../operations/vm-create/create-linux-vm.md#cli_1)
 * [Создать прерываемую ВМ](../../operations/vm-create/create-preemptible-vm.md#cli_1)
 * [Создание виртуальной машины с GPU](../../operations/vm-create/create-vm-with-gpu.md#cli_1)