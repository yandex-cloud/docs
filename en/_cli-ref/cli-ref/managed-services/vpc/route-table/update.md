# yc vpc route-table update

Modify configuration or attributes of a route table.

#### Command Usage

Syntax: 

`yc vpc route-table update <ROUTE-TABLE-NAME>|<ROUTE-TABLE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Route table id.|
|`--name`|<b>`string`</b><br/>Route table name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the route table.|
|`--description`|<b>`string`</b><br/>New description for the route table.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the route table as key-value pairs. Existing set of labels will be completely overwritten.|
|`--clear-routes`|Clear all routes from a table.|
|`--route`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New list of static routes for table.<br/><br/>Possible property names:<br/><ul> <li><code>destination</code>:     Destination subnet in CIDR notation.</li> <li><code>next-hop</code>:     Next hop IP address.</li> <li><code>gateway-id</code>:     ID of the gateway to use as next hop.</li> <li><code>gateway-name</code>:     Name of the gateway to use as next hop.</li> </ul>|

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
