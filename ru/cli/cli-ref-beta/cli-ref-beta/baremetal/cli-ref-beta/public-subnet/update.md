---
editable: false
noIndex: true
---

# yc beta baremetal public-subnet update

Updates the specified public subnet.

#### Command Usage

Syntax:

`yc beta baremetal public-subnet update <PUBLIC-SUBNET-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the public subnet. ||
|| `--hardware-pool-ids` | `[]string`

IDs of the hardware pool that the public subnet belongs to. To get a list of available hardware pools, use the [HardwarePoolService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--name` | `string`

Name of the public subnet. The name must be unique within the folder. ||
|| `--public-subnet-id` | `string`

ID of the PublicSubnet resource to update. To get the public subnet ID, use a [PublicSubnetService.List] request. ||
|| `--type` | `enum`

Possible Values: 'dedicated', 'ephemeral' ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#