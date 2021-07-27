---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# yc managed-elasticsearch cluster update

Modify configuration or attributes of a ElasticSearch cluster.

#### Command Usage

Syntax: 

`yc managed-elasticsearch cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the ElasticSearch cluster.|
|`--name`|<b>`string`</b><br/> Name of the ElasticSearch cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> New name for the ElasticSearch cluster|
|`--description`|<b>`string`</b><br/> New description for the ElasticSearch cluster. --labels key=value[,key=value...] New set of labels for the ElasticSearch cluster as key-value pairs. Existing set of labels will be completely overwritten. --security-group-ids value[,value] A list of security groups for the ElasticSearch cluster.|
|`--datanode-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a datanode host (CPU, RAM etc.).|
|`--datanode-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a datanode host.|
|`--datanode-disk-type`|<b>`string`</b><br/> Storage type for a datanode host.|
|`--masternode-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a masternode host (CPU, RAM etc.).|
|`--masternode-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a masternode host.|
|`--masternode-disk-type`|<b>`string`</b><br/> Storage type for a masternode host. --plugins value[,value] ElasticSearch plugins|
|`--version`|<b>`string`</b><br/> ElasticSearch version|

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
