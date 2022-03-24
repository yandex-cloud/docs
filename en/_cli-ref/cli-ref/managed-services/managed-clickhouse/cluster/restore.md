# yc managed-clickhouse cluster restore

Restore a ClickHouse cluster from a backup.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster restore [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--backup-id`|<b>`value[,value]`</b><br/> IDs of the backup to use for restoring a cluster.|
|`--name`|<b>`string`</b><br/> Name for the restored cluster.|
|`--description`|<b>`string`</b><br/> Description for the restored cluster.|
|`--environment`|<b>`string`</b><br/> Environment for the restored cluster. Supported values: 'production', 'prestable'.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Individual configurations for hosts that should be created for the ClickHouse cluster being restored.  Possible property names:  zone-id ID of the availability zone where the new host should reside.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Assign a public IP address to the host being added.  type Type of the host to be created. Supported values: 'clickhouse', 'zookeeper'.  |
|`--clickhouse-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a ClickHouse host (CPU, RAM etc.).|
|`--clickhouse-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a ClickHouse host|
|`--clickhouse-disk-type`|<b>`string`</b><br/> Storage type for a ClickHouse host.|
|`--zookeeper-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.).|
|`--zookeeper-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a ZooKeeper host|
|`--zookeeper-disk-type`|<b>`string`</b><br/> Storage type for the host.|
|`--datalens-access`| Allow access for DataLens|
|`--websql-access`| Allow access for Web SQL|
|`--metrika-access`| Allow access for Yandex Metrika|
|`--serverless-access`| Allow access for Serverless|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--yandexquery-access`| Allow access for Yandex Query|
|`--version`|<b>`string`</b><br/> Version of the ClickHouse server software.|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--cloud-storage`| Whether to use Yandex Object Storage for storing ClickHouse data.|
|`--enable-sql-database-management`| Whether database management through SQL commands is enabled.|
|`--enable-sql-user-management`| Whether user management through SQL commands is enabled.|
|`--embedded-keeper`| Whether cluster should use embedded Keeper instead of Zookeeper.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of labels as key-value pairs to add for the cluster being restored.|
|`--service-account`|<b>`string`</b><br/> Service account for the ClickHouse cluster being restored.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the ClickHouse cluster.|
|`--admin-password`|<b>`string`</b><br/> Password for entity. Usage of --read-admin-password is more secure|
|`--read-admin-password`| Read password for entity from input|
|`--generate-admin-password`| Generate random password|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
