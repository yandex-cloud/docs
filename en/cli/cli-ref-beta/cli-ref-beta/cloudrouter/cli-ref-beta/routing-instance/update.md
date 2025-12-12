---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloudrouter/cli-ref-beta/routing-instance/update.md
---

# yc beta cloudrouter routing-instance update

Updates a RoutingInstance resource using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cloudrouter routing-instance update <ROUTING-INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cic-private-connection-info`|<b>`shorthand/json`</b><br/>List of the info about privateConnections which are attached to the RoutingInstance.<br/>Shorthand Syntax:<br/>[<br/>{<br/>cic-private-connection-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"cic-private-connection-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>cic-private-connection-id -> (string)<br/>ID of the cicPrivateConnection that is attached to the routingInstance.|
|`--description`|<b>`string`</b><br/>Optional description of the RoutingInstance. 0-256 characters long.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'.|
|`--name`|<b>`string`</b><br/>Name of the RoutingInstance. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''.|
|`--region-id`|<b>`string`</b><br/>ID of the region that the routingInstance belongs to.|
|`--routing-instance-id`|<b>`string`</b><br/>ID of the RoutingInstance resource to return.|
|`--vpc-info`|<b>`shorthand/json`</b><br/>List of the info about vpcNetworks which are attached to the RoutingInstance.<br/>Shorthand Syntax:<br/>[<br/>{<br/>az-infos = [<br/>{<br/>manual-info = {<br/>az-id = str,<br/>prefixes = str,...<br/>}<br/>}, ...<br/>],<br/>vpc-network-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"az-infos": [<br/>{<br/>"manual-info": {<br/>"az-id": "str",<br/>"prefixes": [<br/>"str", ...<br/>]<br/>}<br/>}, ...<br/>],<br/>"vpc-network-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>az-infos -> ([]struct)<br/>List of the az-related info about vpcNetworks which are attached to routingInstance<br/>manual-info -> (struct)<br/>VpcInfo which is set by user<br/>az-id -> (string)<br/>ID of the AZ<br/>prefixes -> ([]string)<br/>List of prefixes to announce<br/>vpc-network-id -> (string)<br/>ID of the vpcNetwork that is attached to the routingInstance.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
