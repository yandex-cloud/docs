# yc compute host-group get

Show information about the specified host group

#### Command Usage

Syntax: 

`yc compute host-group get <HOST-GROUP-NAME>|<HOST-GROUP-ID> [<HOST-GROUP-NAME>|<HOST-GROUP-ID>...] [Global Flags...]`

Aliases: 

- `describe`
- `show`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Host group id.|
|`--name`|<b>`string`</b><br/>Host group name.|

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
