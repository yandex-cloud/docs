---
editable: false
---

# yc managed-clickhouse cluster create

Create a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the ClickHouse cluster.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--environment`|<b>`string`</b><br/>Environment to deploy the cluster in. Supported values: 'production', 'prestable'.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created with the ClickHouse cluster.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the new host should reside.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Assign a public IP address to the host being added.</li> <li><code>shard-name</code>:     Host shard name.</li> <li><code>type</code>:     Type of the host to be created. Supported values: 'clickhouse', 'zookeeper'.</li> </ul>|
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of database users to be created with the ClickHouse cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the ClickHouse user.</li> <li><code>password</code>:     Password of the ClickHouse user.</li> </ul>|
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of databases to be created with the ClickHouse cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the ClickHouse database.</li> </ul>|
|`--clickhouse-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.).|
|`--clickhouse-disk-type`|<b>`string`</b><br/>Storage type for a ClickHouse host.|
|`--clickhouse-disk-size`|<b>`byteSize`</b><br/>Storage volume available to a ClickHouse host in GB|
|`--zookeeper-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.).|
|`--zookeeper-disk-type`|<b>`string`</b><br/>Storage type for the host.|
|`--zookeeper-disk-size`|<b>`byteSize`</b><br/>Storage volume available to a ZooKeeper host in GB|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--metrika-access`|Allow access for Yandex Metrika|
|`--serverless-access`|Allow access for Serverless|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--yandexquery-access`|Allow access for Yandex Query|
|`--version`|<b>`string`</b><br/>Version of the ClickHouse server software.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--cloud-storage-move-factor`|<b>`float`</b><br/>When to move data to Yandex Object Storage.|
|`--cloud-storage-data-cache`|Whether to use cache for data on Yandex Object Storage.|
|`--cloud-storage-data-cache-max-size`|<b>`byteSize`</b><br/>Limit for cache for data on Yandex Object Storage.|
|`--cloud-storage-prefer-not-to-merge`|Disable merge of data parts stored in Yandex Object Storage.|
|`--enable-sql-database-management`|Whether database management through SQL commands is enabled.|
|`--enable-sql-user-management`|Whether user management through SQL commands is enabled.|
|`--embedded-keeper`|Whether cluster should use embedded Keeper instead of Zookeeper.|
|`--backup-retain-period-days`|<b>`int`</b><br/>Auto backups retain period in days.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of ClickHouse cluster labels as key-value pairs.|
|`--service-account`|<b>`string`</b><br/>Service account for the ClickHouse cluster.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the ClickHouse cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--cloud-storage`|Whether to use Yandex Object Storage for storing ClickHouse data.|
|`--admin-password`|<b>`string`</b><br/>Password for entity. Usage of --read-admin-password is more secure|
|`--read-admin-password`|Read password for entity from input|
|`--generate-admin-password`|Generate random password|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
