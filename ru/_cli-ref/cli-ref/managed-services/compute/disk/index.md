# yc compute disk

Manage disks

#### Command Usage

Syntax: 

`yc compute disk <command>`

Aliases: 

- `disks`

#### Command Tree

- [yc compute disk get](get.md) — Show information about the specified disk
- [yc compute disk list](list.md) — List disks
- [yc compute disk create](create.md) — Create a disk
- [yc compute disk update](update.md) — Update the specified disk
- [yc compute disk add-labels](add-labels.md) — Add labels to specified disk
- [yc compute disk remove-labels](remove-labels.md) — Remove labels from specified disk
- [yc compute disk resize](resize.md) — Resize the specified disk
- [yc compute disk delete](delete.md) — Delete the specified disk
- [yc compute disk move](move.md) — Move the specified disk into the folder
- [yc compute disk list-operations](list-operations.md) — List operations for the specified disk

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
