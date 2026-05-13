# yc compute disk list

List disks

#### Command Usage

Syntax:

`yc compute disk list [Flags...] [Global Flags...]`

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

 * [Добавить расписание к диску](../../../../../compute/operations/disk-control/configure-schedule.md#cli_1)
 * [Создание снимка](../../../../../compute/operations/disk-control/create-snapshot.md#cli_1)
 * [Удалить диск](../../../../../compute/operations/disk-control/delete.md#cli_1)
 * [Назначить роль](../../../../../compute/operations/disk-control/disk-access.md#cli_1)
 * [Перенести диск](../../../../../compute/operations/disk-control/disk-change-folder.md#cli_1)
 * [Создайте снимки](../../../../../compute/operations/disk-control/disk-change-zone.md#cli_1)
 * [Зашифровать диск](../../../../../compute/operations/disk-control/disk-encrypt.md#cli_1)
 * [Изменить имя и описание диска](../../../../../compute/operations/disk-control/update.md#cli_1)
 * [Создать пустой диск с блоком большого размера](../../../../../compute/operations/disk-create/empty-disk-blocksize.md#cli_1)
 * [Создать пустой диск](../../../../../compute/operations/disk-create/empty.md#cli_1)
 * [Восстановить диск с помощью образа](../../../../../compute/operations/disk-create/from-image.md#cli_1)
 * [Восстановить диск с помощью снимка](../../../../../compute/operations/disk-create/from-snapshot.md#cli_1)
 * [Создать отдельный нереплицируемый диск](../../../../../compute/operations/disk-create/nonreplicated.md#tf_1)
 * [Создать сверхбыстрое сетевое хранилище с тремя репликами (SSD)](../../../../../compute/operations/disk-create/ssd-io.md#tf_1)
 * [Зашифровать образ](../../../../../compute/operations/image-control/encrypt.md#cli_1)
 * [Создать образ из диска](../../../../../compute/operations/image-create/create-from-disk.md#cli_1)
 * [Настроить автоматическое создание снимков дисков по расписанию](../../../../../compute/operations/snapshot-control/create-schedule.md#cli_1)
 * [Зашифровать снимок](../../../../../compute/operations/snapshot-control/snapshot-encrypt.md#cli_1)
 * [Изменить список дисков](../../../../../compute/operations/snapshot-control/update-schedule.md#cli_2)
 * [Подключить диск](../../../../../compute/operations/vm-control/vm-attach-disk.md#cli_1)
 * [Создайте снимки](../../../../../compute/operations/vm-control/vm-change-zone.md#cli_1)
 * [Создать виртуальную машину из набора дисков](../../../../../compute/operations/vm-create/create-from-disks.md#cli_1)
 * [Создайте диск с закреплением поколения оборудования Gen 2](../../../../../compute/operations/vm-create/create-gen2-vm.md#tf_4)