# yc vpc route-table

Manage route tables.

#### Command Usage

Syntax: 

`yc vpc route-table <command>`

Aliases: 

- `route-tables`

#### Command Tree

- [yc vpc route-table get](get.md) — Get information about a route table.
- [yc vpc route-table list](list.md) — List route tables in a folder.
- [yc vpc route-table create](create.md) — Create a route table.
- [yc vpc route-table update](update.md) — Modify configuration or attributes of a route table.
- [yc vpc route-table add-labels](add-labels.md) — Add labels to a route table.
- [yc vpc route-table remove-labels](remove-labels.md) — Remove labels from a route table.
- [yc vpc route-table delete](delete.md) — Delete a route table.
- [yc vpc route-table list-operations](list-operations.md) — List operations for a route table.
- [yc vpc route-table move](move.md) — Move a route table to another folder.

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
