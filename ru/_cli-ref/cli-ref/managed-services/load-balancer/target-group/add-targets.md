# yc load-balancer target-group add-targets

Add targets to the specified target group

#### Command Usage

Syntax: 

`yc load-balancer target-group add-targets <TARGET-GROUP-NAME>|<TARGET-GROUP-ID> [Flags...] [Global Flags...]`

Aliases: 

- `add`

#### Flags

| Flag | Description |
|----|----|
|`--target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Adds a target to the target group.  Possible property names:  subnet-name Specifies the subnet that the target will connect to.  subnet-id Specifies the ID of the subnet that the target will connect to.  address Specifies the IP address that the target will connect to  |
|`--id`|<b>`string`</b><br/> Target group id.|
|`--name`|<b>`string`</b><br/> Target group name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
