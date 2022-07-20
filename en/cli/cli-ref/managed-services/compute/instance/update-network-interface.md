---
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/update-network-interface.md
---
# yc compute instance update-network-interface

Update the specified network interface of virtual machine instance

#### Command Usage

Syntax: 

`yc compute instance update-network-interface <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Instance id.|
|`--name`|<b>`string`</b><br/>Instance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--network-interface-index`|<b>`string`</b><br/>Index of interface to update.|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet to attach the interface to.|
|`--subnet-name`|<b>`string`</b><br/>Name of the subnet to attach the interface to.|
|`--ipv4-address`|<b>`string`</b><br/>Assigns the given internal IPv4 address to the interface that is updated. If 'auto' used as value, some unassigned address from the subnet is used.|
|`--clear-ipv4-address`|Clear IPv4 address on the network interface|
|`--nat-ip-version`|<b>`string`</b><br/>Specifies IP version for One-to-One NAT. Can be either 'ipv4' or 'ipv6'. This flag can be applied to network interfaces with ipv4 address or both addresses.|
|`--nat-address`|<b>`string`</b><br/>Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address or both addresses.|
|`--security-group-id`|<b>`value[,value]`</b><br/>Security groups for the network interface, --security-group-id id1 --security-group-id=id2|
|`--clear-security-groups`|Clear security groups for the network interface|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
