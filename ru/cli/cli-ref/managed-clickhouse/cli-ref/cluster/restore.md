---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-clickhouse/cli-ref/cluster/restore.md
---

# yc managed-clickhouse cluster restore

Restore a ClickHouse cluster from a backup.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster restore [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backup-id` | `value[,value]`

IDs of the backup to use for restoring a cluster. ||
|| `--name` | `string`

Name for the restored cluster. ||
|| `--description` | `string`

Description for the restored cluster. ||
|| `--folder-id` | `string`

ID of folder where restored cluster will be created. ||
|| `--environment` | `string`

Environment for the restored cluster. Supported values: 'production', 'prestable'. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--shard` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configurations of the shards that should be created in the cluster. Their number, names and order should match those in the backups whose ids you provide in the flags.

Possible property names:

- `name`: Shard name.

- `disk-size-limit`: Disk size limit of the shard in the cluster (GB).

- `planned-usage-threshold`: Planned usage threshold of the shard in the cluster.

- `emergency-usage-threshold`: Emergency usage threshold of the shard in the cluster.

- `weight`: Weight of the shard in the cluster; an integer. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created for the ClickHouse cluster being restored.

Possible property names:

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Assign a public IP address to the host being added.

- `shard-name`: Host shard name.

- `type`: Type of the host to be created. Supported values: 'clickhouse', 'zookeeper'. ||
|| `--clickhouse-resource-preset` | `string`

Resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.). ||
|| `--clickhouse-disk-type` | `string`

Storage type for a ClickHouse host. ||
|| `--clickhouse-disk-size` | `byteSize`

Storage volume available to a ClickHouse host in GB ||
|| `--zookeeper-resource-preset` | `string`

Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.). ||
|| `--zookeeper-disk-type` | `string`

Storage type for the host. ||
|| `--zookeeper-disk-size` | `byteSize`

Storage volume available to a ZooKeeper host in GB ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--metrika-access` | Allow access for Yandex Metrika ||
|| `--serverless-access` | Allow access for Serverless ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for Yandex Query ||
|| `--version` | `string`

Version of the ClickHouse server software. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--cloud-storage-move-factor` | `float`

When to move data to Yandex Object Storage. ||
|| `--cloud-storage-data-cache` | Whether to use cache for data on Yandex Object Storage. ||
|| `--cloud-storage-data-cache-max-size` | `byteSize`

Limit for cache for data on Yandex Object Storage. ||
|| `--cloud-storage-prefer-not-to-merge` | Disable merge of data parts stored in Yandex Object Storage. ||
|| `--enable-sql-database-management` | Whether database management through SQL commands is enabled. ||
|| `--enable-sql-user-management` | Whether user management through SQL commands is enabled. ||
|| `--embedded-keeper` | Whether cluster should use embedded Keeper instead of Zookeeper. ||
|| `--backup-retain-period-days` | `int`

Auto backups retain period in days. ||
|| `--labels` | `key=value[,key=value...]`

A list of labels as key-value pairs to add for the cluster being restored. ||
|| `--service-account` | `string`

Service account for the ClickHouse cluster being restored. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the ClickHouse cluster. ||
|| `--cloud-storage` | Whether to use Yandex Object Storage for storing ClickHouse data. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. Empty input will remove the use of encryption. ||
|| `--admin-password` | `string`

Password for entity. Usage of --read-admin-password is more secure ||
|| `--read-admin-password` | Read password for entity from input ||
|| `--generate-admin-password` | Generate random password ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `clickhouse-disk-size-limit`: Disk size limit of all shards in the cluster (GB).

- `clickhouse-planned-usage-threshold`: Planned usage threshold of all shards in the cluster.

- `clickhouse-emergency-usage-threshold`: Emergency usage threshold of all shards in the cluster.

- `zookeeper-disk-size-limit`: Set disk size limit for zookeeper subcluster (GB).

- `zookeeper-planned-usage-threshold`: Set planned usage threshold for zookeeper subcluster.

- `zookeeper-emergency-usage-threshold`: Set emergency usage threshold for zookeeper subcluster. ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
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