# yc logging group

Manage log groups

#### Command Usage

Syntax: 

`yc logging group <command>`

#### Command Tree

- [yc logging group get](get.md) — Show information about the specified log group
- [yc logging group list](list.md) — List log groups
- [yc logging group create](create.md) — Create log group
- [yc logging group update](update.md) — Update log group
- [yc logging group delete](delete.md) — Delete log group
- [yc logging group stats](stats.md) — Show consumed resources for log group(s)
- [yc logging group list-resources](list-resources.md) — List log group resources
- [yc logging group list-access-bindings](list-access-bindings.md) — List log group access bindings
- [yc logging group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any
- [yc logging group add-access-binding](add-access-binding.md) — Add access binding for the specified log group
- [yc logging group remove-access-binding](remove-access-binding.md) — Removes access binding from the specified log group
- [yc logging group list-operations](list-operations.md) — List log group operations

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
