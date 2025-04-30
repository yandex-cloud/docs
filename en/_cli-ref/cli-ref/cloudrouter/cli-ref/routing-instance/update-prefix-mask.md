---
editable: false
---

# yc cloudrouter routing-instance update-prefix-mask

Update mask of a VPC network prefix of the routingInstance.

#### Command Usage

Syntax: 

`yc cloudrouter routing-instance update-prefix-mask <ROUTING_INSTANCE-NAME>|<ROUTING_INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>RoutingInstance id.|
|`--name`|<b>`string`</b><br/>RoutingInstance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--vpc-net-id`|<b>`string`</b><br/>ID of a VPC network.|
|`--zone`|<b>`string`</b><br/>ID of AZ.|
|`--prefix`|<b>`string`</b><br/>Prefix to update.|
|`--new-mask`|<b>`int32`</b><br/>The new mask.|
|`--remove-sub-prefixes`|Specifies whether existing sub-prefixes covered by the mask should be removed.|

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
