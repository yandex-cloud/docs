---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-clickhouse/cluster/add-zookeeper.md
---
# yc managed-clickhouse cluster add-zookeeper

Adds Zookeeper hosts for a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster add-zookeeper <CLUSTER-NAME>|<CLUSTER-ID> [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the ClickHouse cluster.|
|`--name`|<b>`string`</b><br/> Name of the ClickHouse cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.).|
|`--disk-size`|<b>`byteSize`</b><br/> Storage volume available to a ZooKeeper host.|
|`--disk-type`|<b>`string`</b><br/> Storage type for the host.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Configurations for ClickHouse Zookeeper hosts that should be added to the cluster.  Possible property names:  zone-id ID of the availability zone where the new host should reside.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.|

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
