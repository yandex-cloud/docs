# yc managed-sqlserver cluster create

Create SQLServer cluster

#### Command Usage

Syntax: 

`yc managed-sqlserver cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Cluster name.|
|`--description`|<b>`string`</b><br/> Cluster description.|
|`--environment`|<b>`string`</b><br/> Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Individual configurations for hosts that should be created for the SQLServer cluster.  Possible property names:  zone-id ID of the availability zone where the host resides.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Whether the host should get a public IP address on creation.  |
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of database users to be created in the SQLServer cluster.  Possible property names:  name Name of the SQLServer user.  password Password of the SQLServer user.  |
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of databases to be created in the SQLServer cluster.  Possible property names:  name Name of the SQLServer database.  |
|`--sqlserver-version`|<b>`string`</b><br/> Version of SQLServer used in the cluster. Values: 2016sp2std, 2016sp2ent, 2017std, 2017ent, 2019std, 2019ent|
|`--resource-preset`|<b>`string`</b><br/> ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to a host.|
|`--disk-type`|<b>`string`</b><br/> Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--secondary-connections`|<b>`string`</b><br/> Secondary replicas connection mode Values: 'secondary-connections-off', 'secondary-connections-read-only'|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the SQLServer cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/> A list of host groups to place VMs of cluster on.|
|`--service-account-id`|<b>`string`</b><br/> Service account id to assign to cluster hosts.|
|`--confirm-payment`| Confirm immediate payment for cluster creation/modification/restoring|
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
