# yc resource-manager folder

Manage folders

#### Command Usage

Syntax: 

`yc resource-manager folder <command>`

Aliases: 

- `folders`

#### Command Tree

- [yc resource-manager folder get](get.md) — Show information about the specified folder
- [yc resource-manager folder list](list.md) — List folders
- [yc resource-manager folder create](create.md) — Create a folder
- [yc resource-manager folder update](update.md) — Update the specified folder
- [yc resource-manager folder add-labels](add-labels.md) — Add labels to specified folder
- [yc resource-manager folder remove-labels](remove-labels.md) — Remove labels from specified folder
- [yc resource-manager folder delete](delete.md) — Delete the specified folder
- [yc resource-manager folder list-access-bindings](list-access-bindings.md) — List access bindings for the specified folder
- [yc resource-manager folder set-access-bindings](set-access-bindings.md) — Set access bindings for the specified folder and delete all existing access bindings if there were any
- [yc resource-manager folder add-access-binding](add-access-binding.md) — Add access binding for the specified folder
- [yc resource-manager folder remove-access-binding](remove-access-binding.md) — Remove access binding for the specified folder
- [yc resource-manager folder list-operations](list-operations.md) — List operations for the specified folder

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
