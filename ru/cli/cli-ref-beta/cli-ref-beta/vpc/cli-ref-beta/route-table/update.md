---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/route-table/update.md
---

# yc beta vpc route-table update

Updates the specified route table.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta vpc route-table update <ROUTE-TABLE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the route table.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the route table. The name must be unique within the folder.|
|`--route-table-id`|<b>`string`</b><br/>ID of the RouteTable resource to update.|
|`--static-routes`|<b>`shorthand/json`</b><br/>List of static routes.<br/>Shorthand Syntax:<br/>[<br/>{<br/>destination = destination-prefix=str,<br/>labels = {key=str, key=...},<br/>next-hop = gateway-id=str \| next-hop-address=str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"destination": {<br/>"destination-prefix": "str"<br/>},<br/>"labels": {<br/>"\<key\>": "str", ...<br/>},<br/>"next-hop": {<br/>"gateway-id": "str",<br/>"next-hop-address": "str"<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>labels -> (map[string,string])<br/>Resource labels as '' key:value '' pairs. Maximum of 64 per resource.<br/>destination -> (oneof\<destination-prefix\>)<br/>Oneof destination field<br/>destination-prefix -> (string)<br/>Destination subnet in CIDR notation<br/>next-hop -> (oneof<gateway-id\|next-hop-address>)<br/>Oneof next-hop field<br/>next-hop-address -> (string)<br/>Next hop IP address<br/>gateway-id -> (string)<br/>Next hop gateway id|
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
