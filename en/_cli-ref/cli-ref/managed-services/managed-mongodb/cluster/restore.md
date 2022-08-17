# yc managed-mongodb cluster restore

Restore a MongoDB cluster from a backup.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster restore [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--backup-id`|<b>`string`</b><br/>ID of the backup to use for restoring a cluster.|
|`--name`|<b>`string`</b><br/>Name for the restored cluster.|
|`--description`|<b>`string`</b><br/>Description for the restored cluster.|
|`--environment`|<b>`string`</b><br/>Environment for the restored cluster. Supported values: 'production', 'prestable'.|
|`--recovery-target-timestamp`|<b>`int`</b><br/>Timestamp of the moment to which the MongoDB cluster should be restored. Format: UNIX Epoch time (POSIX time).<br/>Example: '1600884000' is UNIX Epoch time for '2020-09-23T18:00:00+00:00'.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created for the MongoDB cluster being restored.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the new host should reside.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Assign a public IP address to the host being added.</li> </ul>|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of labels as key-value pairs to add for the cluster being restored.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the MongoDB cluster.|
|`--mongodb-version`|<b>`string`</b><br/>Version of MongoDB used by the cluster. Supported value: 3.6, 4.0, 4.2, 4.4, 5.0, 6.0|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retain period of automatically created backup in days.|
|`--datalens-access`|Allow access for DataLens|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--mongod-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongod-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to mongodb host with corresponding role.|
|`--mongod-disk-type`|<b>`string`</b><br/>Storage type for mongodb host with corresponding role.|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
