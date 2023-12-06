---
editable: false
---

# yc managed-mongodb cluster create

Create a MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the cluster.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--environment`|<b>`string`</b><br/>Environment to deploy the cluster in. Supported values: 'production', 'prestable'.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created with the MongoDB cluster.<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of the host to be created. Supported values: 'mongod', 'mongos', 'mongocfg', 'mongoinfra'.</li> <li><code>zone-id</code>:     ID of the availability zone where the new host should reside.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Assign a public IP address to the host being added.</li> </ul>|
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of database users to be created with the MongoDB cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the MongoDB user.</li> <li><code>password</code>:     Password of the MongoDB user.</li> </ul>|
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of databases to be created with the MongoDB cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the MongoDB database.</li> </ul>|
|`--mongodb-version`|<b>`string`</b><br/>Version of MongoDB used by the cluster. Supported value: 3.6, 4.0, 4.2, 4.4, 5.0, 6.0|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retain period of automatically created backup in days.|
|`--performance-diagnostics`|Enable or disable performance diagnostics|
|`--datalens-access`|Allow access for DataLens|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--mongod-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongod-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to mongodb host with corresponding role.|
|`--mongod-disk-type`|<b>`string`</b><br/>Storage type for mongodb host with corresponding role.|
|`--mongoinfra-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongoinfra-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to mongodb host with corresponding role.|
|`--mongoinfra-disk-type`|<b>`string`</b><br/>Storage type for mongodb host with corresponding role.|
|`--mongocfg-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongocfg-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to mongodb host with corresponding role.|
|`--mongocfg-disk-type`|<b>`string`</b><br/>Storage type for mongodb host with corresponding role.|
|`--mongos-resource-preset`|<b>`string`</b><br/>Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.).|
|`--mongos-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to mongodb host with corresponding role.|
|`--mongos-disk-type`|<b>`string`</b><br/>Storage type for mongodb host with corresponding role.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of cluster labels as key-value pairs.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the MongoDB cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
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
|`-h`,`--help`|Display help for the command.|
