---
sourcePath: ru/_cli-ref/cli-ref/managed-services/compute/host-group/update.md
---
# yc compute host-group update

Update the specified host group

#### Command Usage

Syntax: 

`yc compute host-group update <HOST-GROUP-NAME>|<HOST-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Host group id.|
|`--name`|<b>`string`</b><br/> Host group name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> A new name of the host group.|
|`--description`|<b>`string`</b><br/> Specifies a textual description of the host group.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--fixed-size`|<b>`int`</b><br/> Indicates the new size of the host group.|

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
