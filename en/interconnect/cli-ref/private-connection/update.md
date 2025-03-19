---
editable: false
sourcePath: en/_cli-ref/cli-ref/cic/cli-ref/private-connection/update.md
---

# yc cic private-connection update

Modify configuration or attributes of a privateConnection.

#### Command Usage

Syntax: 

`yc cic private-connection update <PRIVATE-CONNECTION-NAME>|<PRIVATE-CONNECTION-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>PrivateConnection id.|
|`--name`|<b>`string`</b><br/>PrivateConnection name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the privateConnection.|
|`--description`|<b>`string`</b><br/>New description for the privateConnection.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the privateConnection as key-value pairs. Existing set of labels will be completely overwritten.|
|`--region`|<b>`string`</b><br/>Region of the privateConnection.|
|`--trunk-id`|<b>`string`</b><br/>Id of a trunk connection of the privateConnection.|
|`--vlan-id`|<b>`int`</b><br/>VLAN id that the privateConnection uses in multiplexing.|
|`--ipv4-peering`|<b>`key=value[,key=value...]`</b><br/>A list of IPv4 peering parameters of the privateConnection.|
|`--ipv4-static-routes`|<b>`value[,value]`</b><br/>IPv4 static routes (in ipPrefix/length format) of the privateConnection.|

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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
