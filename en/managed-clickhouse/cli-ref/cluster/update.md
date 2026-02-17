---
editable: false
---

# yc managed-clickhouse cluster update

Modify configuration or attributes of a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the ClickHouse cluster ||
|| `--description` | `string`

New description for the ClickHouse cluster. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the ClickHouse cluster as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--service-account` | `string`

New service account for the ClickHouse cluster. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the ClickHouse cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--clickhouse-resource-preset` | `string`

New resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.). ||
|| `--clickhouse-disk-size` | `byteSize`

New volume of the storage available to a ClickHouse host in GB. ||
|| `--clickhouse-disk-type` | `string`

New storage type for a ClickHouse host. ||
|| `--zookeeper-resource-preset` | `string`

New resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.). ||
|| `--zookeeper-disk-size` | `byteSize`

New volume of the storage available to a ZooKeeper host in GB. ||
|| `--zookeeper-disk-type` | `string`

New storage type for a ZooKeeper host. ||
|| `--version` | `string`

Version of the ClickHouse server software. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--metrika-access` | Allow access for Yandex Metrika ||
|| `--serverless-access` | Allow access for Serverless ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for Yandex Query ||
|| `--cloud-storage` | Whether to use Yandex Object Storage for storing ClickHouse data. ||
|| `--cloud-storage-move-factor` | `float`

When to move data to Yandex Object Storage. ||
|| `--cloud-storage-data-cache` | Whether to use cache for data on Yandex Object Storage. ||
|| `--cloud-storage-data-cache-max-size` | `byteSize`

Limit for cache for data on Yandex Object Storage. ||
|| `--cloud-storage-prefer-not-to-merge` | Disable merge of data parts stored in Yandex Object Storage. ||
|| `--backup-retain-period-days` | `int`

Auto backups retain period in days. ||
|| `--enable-sql-database-management` | Whether database management through SQL commands is enabled. ||
|| `--enable-sql-user-management` | Whether user management through SQL commands is enabled. ||
|| `--admin-password` | `string`

Password for entity. Usage of --read-admin-password is more secure ||
|| `--read-admin-password` | Read password for entity from input ||
|| `--generate-admin-password` | Generate random password ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `clickhouse-disk-size-limit`: Disk size limit of all shards in the cluster (GB).

- `clickhouse-planned-usage-threshold`: Planned usage threshold of all shards in the cluster.

- `clickhouse-emergency-usage-threshold`: Emergency usage threshold of all shards in the cluster.

- `zookeeper-disk-size-limit`: Set disk size limit for zookeeper subcluster (GB).

- `zookeeper-planned-usage-threshold`: Set planned usage threshold for zookeeper subcluster.

- `zookeeper-emergency-usage-threshold`: Set emergency usage threshold for zookeeper subcluster. ||
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