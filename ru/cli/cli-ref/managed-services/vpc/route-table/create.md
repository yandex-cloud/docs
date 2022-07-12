---
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/route-table/create.md
---
# yc vpc route-table create

Create a route table.

#### Command Usage

Syntax: 

`yc vpc route-table create <ROUTE-TABLE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the route table.|
|`--description`|<b>`string`</b><br/> Description of the route table.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of route table labels as key-value pairs.|
|`--network-id`|<b>`string`</b><br/> ID of the network to which the route table belongs.|
|`--network-name`|<b>`string`</b><br/> Name of the network to which the route table belongs.|
|`--route`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> A list of static routes in a table.  Possible property names:  destination Destination subnet in CIDR notation.  next-hop Next hop IP address.  |
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
