# yc compute disk-placement-group

Manage disk placement groups

#### Command Usage

Syntax: 

`yc compute disk-placement-group <command>`

Aliases: 

- `disk-placement-groups`

#### Command Tree

- [yc compute disk-placement-group get](get.md) — Show information about the specified disk placement group
- [yc compute disk-placement-group list](list.md) — List disk placement groups
- [yc compute disk-placement-group create](create.md) — Create a disk placement group
- [yc compute disk-placement-group update](update.md) — Update the specified disk placement group
- [yc compute disk-placement-group add-labels](add-labels.md) — Add labels to the specified disk placement group
- [yc compute disk-placement-group remove-labels](remove-labels.md) — Remove labels from the specified disk placement group
- [yc compute disk-placement-group delete](delete.md) — Delete the specified disk placement group
- [yc compute disk-placement-group list-disks](list-disks.md) — List disks of the specified disk placement group
- [yc compute disk-placement-group list-operations](list-operations.md) — List operations for the specified disk placement group

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
