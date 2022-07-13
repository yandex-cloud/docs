---
sourcePath: en/_cli-ref/cli-ref/managed-services/lockbox/secret/update.md
---
# yc lockbox secret update

Update the specified secret

#### Command Usage

Syntax: 

`yc lockbox secret update <SECRET-NAME>|<SECRET-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Secret id.|
|`--name`|<b>`string`</b><br/> Secret name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> New name of the secret.|
|`--description`|<b>`string`</b><br/> New description of the secret.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of new label KEY=VALUE pairs to update.|
|`--deletion-protection`| Enable deletion protection for the secret.|
|`--no-deletion-protection`| Disable deletion protection for the secret.|

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
