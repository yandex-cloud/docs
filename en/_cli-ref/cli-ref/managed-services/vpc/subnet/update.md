---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# yc vpc subnet update

Modify configuration or attributes of a subnet.

#### Command Usage

Syntax: 

`yc vpc subnet update <SUBNET-NAME>|<SUBNET-ID> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Subnet id.|
|`--name`|<b>`string`</b><br/> Subnet name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> New name for a subnet.|
|`--description`|<b>`string`</b><br/> Specifies a textual description of the subnet. --labels key=value[,key=value...] New set of labels for the subnet as key-value pairs. Existing set of labels will be completely overwritten.|
|`--route-table-id`|<b>`string`</b><br/> ID of the route table to which the subnetwork belongs.|
|`--route-table-name`|<b>`string`</b><br/> Name of the route table to which the subnetwork belongs.|
|`--disassociate-route-table`| Disassociate a route table from the subnet.|
|`--domain-name`|<b>`string`</b><br/> Domain name for a subnet. --domain-name-server value[,value] Domain name server for a subnet. --ntp-server value[,value] Ntp server for a subnet.|

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
