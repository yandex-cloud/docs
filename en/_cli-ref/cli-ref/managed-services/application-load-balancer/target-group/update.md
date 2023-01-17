---
editable: false
---

# yc application-load-balancer target-group update

Update the specified target group

#### Command Usage

Syntax: 

`yc application-load-balancer target-group update <TARGET-GROUP-NAME>|<TARGET-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Target group id.|
|`--name`|<b>`string`</b><br/>Target group name.|
|`--new-name`|<b>`string`</b><br/>A new name of the target group.|
|`--description`|<b>`string`</b><br/>A description of the target group.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of targets.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-id</code>:     Subnet id.</li> <li><code>subnet-name</code>:     Subnet name.</li> <li><code>ip-address</code>:     IP Address.</li> <li><code>private-ip-address</code>:     Private IPv4 address.</li> </ul>|
|`--clear-targets`|Remove all targets.|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
