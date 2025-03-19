---
editable: false
---

# yc cloudrouter routing-instance update

Modify configuration or attributes of a routingInstance.

#### Command Usage

Syntax: 

`yc cloudrouter routing-instance update <ROUTING_INSTANCE-NAME>|<ROUTING_INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>RoutingInstance id.|
|`--name`|<b>`string`</b><br/>RoutingInstance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the routing-instance.|
|`--description`|<b>`string`</b><br/>New description for the routing-instance.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the routing-instance as key-value pairs. Existing set of labels will be completely overwritten.|
|`--region`|<b>`string`</b><br/>Region of the routing-instance.|
|`--cic-prc`|<b>`value[,value]`</b><br/>CIC private connection ids of the routing-instance.|
|`--vpc-net`|<b>`value[,value]`</b><br/>VPC network info of the routing-instance.|

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
