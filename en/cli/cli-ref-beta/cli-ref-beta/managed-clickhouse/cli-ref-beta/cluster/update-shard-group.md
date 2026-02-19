---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster update-shard-group

Updates the specified shard group.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster update-shard-group <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster that contains the shard group to update. To get the cluster ID, make a [ClusterService.List] request. ||
|| `--description` | `string`

Updated description of the shard group. 0-256 characters long. ||
|| `--shard-group-name` | `string`

Name of the shard group that should be updated. To get the name, make a [ClusterService.ListShardGroups] request. ||
|| `--shard-names` | `[]string`

Updated list of shard names that belongs to the shard group. ||
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