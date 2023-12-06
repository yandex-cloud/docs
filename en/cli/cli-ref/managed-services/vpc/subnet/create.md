---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/subnet/create.md
---

# yc vpc subnet create

Create a subnet in the specified network.

#### Command Usage

Syntax: 

`yc vpc subnet create <SUBNET-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the subnet.|
|`--description`|<b>`string`</b><br/>Description of the subnet.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of network labels as key-value pairs.|
|`--zone`|<b>`string`</b><br/>ID of the availability zone where the new subnet should reside.|
|`--network-id`|<b>`string`</b><br/>ID of the network to which the subnetwork belongs.|
|`--network-name`|<b>`string`</b><br/>Name of the network to which the subnetwork belongs.|
|`--route-table-id`|<b>`string`</b><br/>ID of the route table to which the subnetwork belongs.|
|`--route-table-name`|<b>`string`</b><br/>Name of the route table to which the subnetwork belongs.|
|`--range`|<b>`value[,value]`</b><br/>The IP address space allocated to this subnet in CIDR notation.|
|`--domain-name`|<b>`string`</b><br/>Domain name for a subnet.|
|`--domain-name-server`|<b>`value[,value]`</b><br/>Domain name server for a subnet.|
|`--ntp-server`|<b>`value[,value]`</b><br/>Ntp server for a subnet.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
