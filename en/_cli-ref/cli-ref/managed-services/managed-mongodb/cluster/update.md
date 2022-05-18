# yc managed-mongodb cluster update

Modify configuration or attributes of a MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the MongoDB cluster.|
|`--name`|<b>`string`</b><br/> Name of the MongoDB cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Maintenance window settings  Possible property names:  type Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.  hour Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.  day Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'  |
|`--description`|<b>`string`</b><br/> New description for the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten.|
|`--feature-compatibility-version`|<b>`string`</b><br/> When set, minimal DB version possible (can not be downgraded). Supported value: 3.6, 4.0, 4.2, 4.4, 5.0|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the MongoDB cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--mongodb-version`|<b>`string`</b><br/> Version of MongoDB used by the cluster. Supported value: 3.6, 4.0, 4.2, 4.4, 5.0|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/> Retain period of automatically created backup in days.|
|`--datalens-access`| Allow access for DataLens|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--mongod-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongod-disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to mongodb host with corresponding role.|
|`--mongod-disk-type`|<b>`string`</b><br/> Storage type for mongodb host with corresponding role.|
|`--mongocfg-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongocfg-disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to mongodb host with corresponding role.|
|`--mongocfg-disk-type`|<b>`string`</b><br/> Storage type for mongodb host with corresponding role.|
|`--mongos-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongos-disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to mongodb host with corresponding role.|
|`--mongos-disk-type`|<b>`string`</b><br/> Storage type for mongodb host with corresponding role.|
|`--mongoinfra-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongoinfra-disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to mongodb host with corresponding role.|
|`--mongoinfra-disk-type`|<b>`string`</b><br/> Storage type for mongodb host with corresponding role.|

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
