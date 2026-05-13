# yc compute instance-group create

Create an instance group

#### Command Usage

Syntax:

`yc compute instance-group create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

A specification will be loaded from specified file in yaml format ||
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

 * [Создать автоматически масштабируемую группу виртуальных машин](../../operations/instance-groups/create-autoscaled-group.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера](../../operations/instance-groups/create-fixed-group.md#cli_1)
 * [Создать группу виртуальных машин по спецификации в формате YAML](../../operations/instance-groups/create-from-yaml.md#cli_1)
 * [Создать группу в одной зоне доступности с ВМ из пула резервов этой зоны](../../operations/instance-groups/create-group-with-pool.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера с сетевым балансировщиком нагрузки](../../operations/instance-groups/create-with-balancer.md#cli_1)
 * [Создать группу виртуальных машин с подключением к Yandex Object Storage](../../operations/instance-groups/create-with-bucket.md#cli_1)
 * [Создать группу ВМ с Container Optimized Image](../../operations/instance-groups/create-with-coi.md#cli_1)
 * [Создать группу виртуальных машин с подключением к файловому хранилищу](../../operations/instance-groups/create-with-filesystem.md#cli_1)
 * [Создать группу виртуальных машин с фиксированными IP-адресами](../../operations/instance-groups/create-with-fixed-ip.md#cli_1)
 * [Создать группу виртуальных машин фиксированного размера с L7-балансировщиком](../../operations/instance-groups/create-with-load-balancer.md#cli_1)
 * [Создать группу виртуальных машин в группе размещения](../../operations/placement-groups/create-ig-in-pg.md#cli_1)