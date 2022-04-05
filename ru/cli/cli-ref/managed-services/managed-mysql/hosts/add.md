---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-mysql/hosts/add.md
---
# yc managed-mysql hosts add

Create new hosts for the cluster in the specified availability zones

#### Command Usage

Syntax: 

`yc managed-mysql hosts add [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/> MySQL cluster id.|
|`--cluster-name`|<b>`string`</b><br/> MySQL cluster name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for MySQL hosts that should be added to the cluster.  Possible property names:  zone-id ID of the availability zone where the host resides.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Whether the host should get a public IP address on creation.  replication-source Name of the host to be used as the replication source for cascaded replication.  backup-priority Priority of the host as a backup source.  priority Host master promotion priority.|

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
