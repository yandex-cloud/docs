---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-mongodb/cluster/create.md
---
# yc managed-mongodb cluster create

Create a MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the cluster.|
|`--description`|<b>`string`</b><br/> Description of the cluster.|
|`--environment`|<b>`string`</b><br/> Environment to deploy the cluster in. Supported values: 'production', 'prestable'.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Individual configurations for hosts that should be created with the MongoDB cluster.  Possible property names:  zone-id ID of the availability zone where the new host should reside.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Assign a public IP address to the host being added.  |
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of database users to be created with the MongoDB cluster.  Possible property names:  name Name of the MongoDB user.  password Password of the MongoDB user.  |
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of databases to be created with the MongoDB cluster.  Possible property names:  name Name of the MongoDB database.  |
|`--mongodb-version`|<b>`string`</b><br/> Version of MongoDB used by the cluster. Supported value: 3.6, 4.0, 4.2, 4.4, 5.0|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/> Retain period of automatically created backup in days.|
|`--datalens-access`| Allow access for DataLens|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--mongod-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongod-disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to mongodb host with corresponding role.|
|`--mongod-disk-type`|<b>`string`</b><br/> Storage type for mongodb host with corresponding role.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of cluster labels as key-value pairs.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the MongoDB cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
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
