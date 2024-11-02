---
editable: false
---

# yc managed-clickhouse cluster update

Modify configuration or attributes of a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the ClickHouse cluster.|
|`--name`|<b>`string`</b><br/>Name of the ClickHouse cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the ClickHouse cluster|
|`--description`|<b>`string`</b><br/>New description for the ClickHouse cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the ClickHouse cluster as key-value pairs. Existing set of labels will be completely overwritten.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--service-account`|<b>`string`</b><br/>New service account for the ClickHouse cluster.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the ClickHouse cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--clickhouse-resource-preset`|<b>`string`</b><br/>New resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.).|
|`--clickhouse-disk-size`|<b>`byteSize`</b><br/>New volume of the storage available to a ClickHouse host in GB.|
|`--clickhouse-disk-type`|<b>`string`</b><br/>New storage type for a ClickHouse host.|
|`--zookeeper-resource-preset`|<b>`string`</b><br/>New resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.).|
|`--zookeeper-disk-size`|<b>`byteSize`</b><br/>New volume of the storage available to a ZooKeeper host in GB.|
|`--zookeeper-disk-type`|<b>`string`</b><br/>New storage type for a ZooKeeper host.|
|`--version`|<b>`string`</b><br/>Version of the ClickHouse server software.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--metrika-access`|Allow access for Yandex Metrika|
|`--serverless-access`|Allow access for Serverless|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--yandexquery-access`|Allow access for Yandex Query|
|`--cloud-storage`|Whether to use Yandex Object Storage for storing ClickHouse data.|
|`--cloud-storage-move-factor`|<b>`float`</b><br/>When to move data to Yandex Object Storage.|
|`--cloud-storage-data-cache`|Whether to use cache for data on Yandex Object Storage.|
|`--cloud-storage-data-cache-max-size`|<b>`byteSize`</b><br/>Limit for cache for data on Yandex Object Storage.|
|`--cloud-storage-prefer-not-to-merge`|Disable merge of data parts stored in Yandex Object Storage.|
|`--backup-retain-period-days`|<b>`int`</b><br/>Auto backups retain period in days.|
|`--enable-sql-database-management`|Whether database management through SQL commands is enabled.|
|`--enable-sql-user-management`|Whether user management through SQL commands is enabled.|
|`--admin-password`|<b>`string`</b><br/>Password for entity. Usage of --read-admin-password is more secure|
|`--read-admin-password`|Read password for entity from input|
|`--generate-admin-password`|Generate random password|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
