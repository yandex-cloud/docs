---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-clickhouse/cli-ref/shards/update/
---

# yc managed-clickhouse shards update

Modify configuration or attributes of a ClickHouse shard.

#### Command Usage

Syntax:

`yc managed-clickhouse shards update <SHARD-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster. ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

Shard name. ||
|| `--clickhouse-resource-preset` | `string`

New resource preset for computational resources (CPU, RAM etc.) available to a ClickHouse host in the shard. ||
|| `--clickhouse-disk-size` | `byteSize`

Volume of the storage available to ClickHouse hosts in the shard in GB. ||
|| `--clickhouse-disk-type` | `string`

Storage type for ClickHouse hosts in the shard. ||
|| `--disk-size-limit` | `byteSize`

Disk size limit of the shard in the cluster (GB). ||
|| `--planned-usage-threshold` | `int`

Planned usage threshold of the shard in the cluster. ||
|| `--emergency-usage-threshold` | `int`

Emergency usage threshold of the shard in the cluster. ||
|| `--weight` | `int`

New weight of a ClickHouse host in the shard. ||
|| `--allow-host-recreation` | Allows or denies re-creation of replicas during update of cluster configuration. The option must be enabled for configuration changes including disk type change. NOTE: Only data of replicated tables will be preserved during host re-creation. Data of non-replicated tables will be lost. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#