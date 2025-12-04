---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/trunk-connection/update.md
---

# yc beta cic trunk-connection update

Updates a TrunkConnection resource using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cic trunk-connection update <TRUNK-CONNECTION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--capacity`|<b>`enum`</b><br/>Capacity of the trunkConnection Possible Values: 'capacity-50-mbps', 'capacity-100-mbps', 'capacity-200-mbps', 'capacity-300-mbps', 'capacity-400-mbps', 'capacity-500-mbps', 'capacity-1-gbps', 'capacity-2-gbps', 'capacity-3-gbps', 'capacity-4-gbps', 'capacity-5-gbps', 'capacity-10-gbps', 'capacity-20-gbps', 'capacity-30-gbps', 'capacity-40-gbps', 'capacity-50-gbps', 'capacity-100-gbps', 'capacity-200-gbps'|
|`--deletion-protection`|Deletion protection flag.<br/>Optional.<br/>If set prohibits deletion of the trunkConnection.|
|`--description`|<b>`string`</b><br/>Optional description of the trunkConnection. 0-256 characters long.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, 'key:value' pairs.<br/>No more than 64 per resource.<br/>The maximum string length in characters for each value is 63.<br/>Each value must match the regular expression '[-_0-9a-z]*'.<br/>The string length in characters for each key must be 1-63.<br/>Each key must match the regular expression '[a-z][-_0-9a-z]*'.|
|`--name`|<b>`string`</b><br/>Name of the trunkConnection.<br/>The name must be unique within the folder.<br/>Value must match the regular expression ''\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?''.|
|`--point-of-presence-id`|<b>`string`</b><br/>ID of pointOfPresence that the trunkConnection is deployed on.<br/>Optional.<br/>If is not set scheduler selects it by himself.|
|`--region-id`|<b>`string`</b><br/>ID of the region that the trunkConnection belongs to.|
|`--trunk-connection-id`|<b>`string`</b><br/>ID of the TrunkConnection resource to return.|
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
