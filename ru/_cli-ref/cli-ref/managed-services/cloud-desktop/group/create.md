# yc cloud-desktop group create

Create a desktop group

#### Command Usage

Syntax: 

`yc cloud-desktop group create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Desktop name.|
|`--description`|<b>`string`</b><br/> Desktop description.|
|`--resource-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Resources specification for desktop group.  Possible property names:  memory Specifies how much memory desktop should have. (required)  cores Amount of cores to attach to the desktop. (required)  core-fraction Amount of core-fraction to attach to the desktop. (required)  |
|`--network-interface-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Resources specification for desktop group.  Possible property names:  network-id Network id (required)  subnet-id Subnet IDs (required)  |
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
