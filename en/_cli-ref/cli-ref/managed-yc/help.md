# yc help

Help provides help for any command in the application. Simply type yc help [path to command] for full details.

#### Command Usage

Syntax: 

`yc help [command] [flags]`

#### Global Flags

| Flag | Description |
|----|----|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
