# yc managed-elasticsearch cluster create

Create a ElasticSearch cluster.

#### Command Usage

Syntax: 

`yc managed-elasticsearch cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the ElasticSearch cluster.|
|`--description`|<b>`string`</b><br/> Description of the cluster.|
|`--environment`|<b>`string`</b><br/> Environment to deploy the cluster in. Supported values: 'production', 'prestable'.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name. --host PROPERTY=VALUE[,PROPERTY=VALUE...] Individual configurations for the cluster hosts.  Possible property names:  zone-id ID of the availability zone where the new host should reside.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Assign a public IP address to the host being added.  type Type of the host to be created. Supported values: 'datanode', 'masternode'.   --user PROPERTY=VALUE[,PROPERTY=VALUE...] Descriptions of database users to be created with the ElasticSearch cluster.  Possible property names:  name Name of the ElasticSearch user.  password Password of the ElasticSearch user.  |
|`--datanode-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a datanode host (CPU, RAM etc.).|
|`--datanode-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a datanode host.|
|`--datanode-disk-type`|<b>`string`</b><br/> Storage type for a datanode host.|
|`--masternode-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a masternode host (CPU, RAM etc.).|
|`--masternode-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a masternode host.|
|`--masternode-disk-type`|<b>`string`</b><br/> Storage type for a masternode host. --plugins value[,value] ElasticSearch plugins|
|`--version`|<b>`string`</b><br/> ElasticSearch version --labels key=value[,key=value...] A list of ElasticSearch cluster labels as key-value pairs. --security-group-ids value[,value] A list of security groups for the ElasticSearch cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Flags

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
