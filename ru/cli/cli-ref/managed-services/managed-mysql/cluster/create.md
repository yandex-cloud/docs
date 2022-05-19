---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-mysql/cluster/create.md
---
# yc managed-mysql cluster create

Create MySQL cluster

#### Command Usage

Syntax: 

`yc managed-mysql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Cluster name.|
|`--description`|<b>`string`</b><br/> Cluster description.|
|`--environment`|<b>`string`</b><br/> Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Individual configurations for hosts that should be created for the MySQL cluster.  Possible property names:  zone-id ID of the availability zone where the host resides.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Whether the host should get a public IP address on creation.  replication-source Name of the host to be used as the replication source for cascaded replication.  backup-priority Priority of the host as a backup source.  priority Host master promotion priority.  |
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of database users to be created in the MySQL cluster.  Possible property names:  name Name of the MySQL user.  password Password of the MySQL user.  |
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of databases to be created in the MySQL cluster.  Possible property names:  name Name of the MySQL database.  |
|`--datalens-access`| Allow access for DataLens|
|`--websql-access`| Allow access for Web SQL|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--mysql-version`|<b>`string`</b><br/> Version of MYSQL used in the cluster. Values: 8.0, 5.7|
|`--resource-preset`|<b>`string`</b><br/> ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to a host.|
|`--disk-type`|<b>`string`</b><br/> Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the MySQL cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/> A list of host groups to place VMs of cluster on.|
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
