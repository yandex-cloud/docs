# yc cdn origin update

Update origin. PUT behaviour - specify all parameters

#### Command Usage

Syntax: 

`yc cdn origin update [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`int`</b><br/>Specifies the origin id.|
|`--source`|<b>`string`</b><br/>Specifies the source of the origin.|
|`--enabled`|Specifies if origin is enabled.|
|`--backup`|Specifies if origin is backup one.|
|`--meta-bucket-name`|<b>`string`</b><br/>Specifies meta bucket name.|
|`--meta-website-name`|<b>`string`</b><br/>Specifies meta website name.|
|`--meta-balancer-id`|<b>`string`</b><br/>Specifies meta balancer id.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
