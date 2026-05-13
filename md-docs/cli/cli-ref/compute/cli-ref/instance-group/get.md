# yc compute instance-group get

Show information about the specified instance group

#### Command Usage

Syntax:

`yc compute instance-group get <INSTANCE-GROUP-NAME>|<INSTANCE-GROUP-ID> [<INSTANCE-GROUP-NAME>|<INSTANCE-GROUP-ID>...] [Global Flags...]`

Aliases:

- `describe`

- `show`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

instance group id. ||
|| `--name` | `string`

instance group name. ||
|| `--full` | Whether description should include metadata of the instance template ||
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

 * [Проверить статус зоны доступности и время до включения](../../../../../compute/operations/instance-groups/disable-enable-zone.md#cli_3)
 * [Включить защиту от удаления для группы виртуальных машин Compute Cloud](../../../../../compute/operations/instance-groups/enable-deletion-protection.md#tf_1)
 * [Получить информацию о группе виртуальных машин](../../../../../compute/operations/instance-groups/get-info.md#cli_1)
 * [Перенести группу виртуальных машин с L7-балансировщиком в другую зону доступности](../../../../../compute/operations/instance-groups/move-group-with-alb.md#tf_2)
 * [Перенести группу виртуальных машин с сетевым балансировщиком нагрузки в другую зону доступности](../../../../../compute/operations/instance-groups/move-group-with-nlb.md#tf_1)
 * [Перенести группу виртуальных машин в другую зону доступности](../../../../../compute/operations/instance-groups/move-group.md#tf_1)