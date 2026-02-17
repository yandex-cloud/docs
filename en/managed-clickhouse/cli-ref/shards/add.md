---
editable: false
---

# yc managed-clickhouse shards add

Create new shard(s) for the cluster in the specified availability zones.

#### Command Usage

Syntax:

`yc managed-clickhouse shards add [SHARD-NAME] [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster. ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--shard` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configurations for ClickHouse shards that should be added to the cluster.

Possible property names:

- `name`: Shard name.

- `disk-size-limit`: Disk size limit of the shard in the cluster (GB).

- `planned-usage-threshold`: Planned usage threshold of the shard in the cluster.

- `emergency-usage-threshold`: Emergency usage threshold of the shard in the cluster.

- `weight`: Weight of the shard in the cluster; an integer. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configurations for ClickHouse hosts of the new shard(s).

Possible property names:

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Assign a public IP address to the host being added.

- `shard-name`: Host shard name. ||
|| `--copy-schema` | Copy schema from an existing shard. ||
|| `--clickhouse-resource-preset` | `string`

Resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.). ||
|| `--clickhouse-disk-size` | `byteSize`

Storage volume available to a ClickHouse host in GB. ||
|| `--clickhouse-disk-type` | `string`

Storage type for a ClickHouse host. ||
|| `--name` | `string`

Shard name. Incompatible with --shard flags. ||
|| `--weight` | `int`

Weight of the shard in the cluster; an integer. Incompatible with --shard flags. ||
|| `--disk-size-limit` | `byteSize`

Disk size limit of the shard in the cluster (GB). Incompatible with --shard flags. ||
|| `--planned-usage-threshold` | `int`

Planned usage threshold of the shard in the cluster. Incompatible with --shard flags. ||
|| `--emergency-usage-threshold` | `int`

Emergency usage threshold of the shard in the cluster. Incompatible with --shard flags. ||
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