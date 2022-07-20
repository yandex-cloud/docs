---
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/address/move.md
---
# yc vpc address move

Move an address to another folder.

#### Command Usage

Syntax: 

`yc vpc address move <ADDRESS-NAME>|<ADDRESS-ID> --destination-folder-id VALUE [Global Flags...]`

Aliases: 

- `mv`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Address id.|
|`--name`|<b>`string`</b><br/>Address name.|
|`--destination-folder-id`|<b>`string`</b><br/>Destination folder id.|
|`--destination-folder-name`|<b>`string`</b><br/>Destination folder name.|
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
