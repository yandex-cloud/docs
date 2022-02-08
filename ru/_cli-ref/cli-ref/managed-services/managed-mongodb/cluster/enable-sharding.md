# yc managed-mongodb cluster enable-sharding

Enable sharding for MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster enable-sharding [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/> ID of the MongoDB cluster.|
|`--cluster-name`|<b>`string`</b><br/> Name of the MongoDB cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for MongoDB hosts that should be added to the shard.  Possible property names:  type Type of the host to be created. Supported values: 'mongod', 'mongos', 'mongocfg', 'mongoinfra'.  zone-id ID of the availability zone where the new host should reside.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Assign a public IP address to the host being added.  |
|`--mongocfg`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for Mongocfg hosts.  Possible property names:  resource-preset Resource preset for computational resources available to a mongo host (CPU, RAM etc.).  disk-size Volume of the storage available to a mongo host.  disk-type Storage type for a mongo host.  |
|`--mongos`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for Mongos hosts.  Possible property names:  resource-preset Resource preset for computational resources available to a mongo host (CPU, RAM etc.).  disk-size Volume of the storage available to a mongo host.  disk-type Storage type for a mongo host.  |
|`--mongoinfra`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for MongoInfra hosts.  Possible property names:  resource-preset Resource preset for computational resources available to a mongo host (CPU, RAM etc.).  disk-size Volume of the storage available to a mongo host.  disk-type Storage type for a mongo host.|

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
