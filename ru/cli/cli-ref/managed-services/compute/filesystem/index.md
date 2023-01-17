---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/filesystem/index.md
---

# yc compute filesystem

Manage filesystems

#### Command Usage

Syntax: 

`yc compute filesystem <command>`

Aliases: 

- `filesystems`

#### Command Tree

- [yc compute filesystem get](get.md) — Show information about the specified filesystem
- [yc compute filesystem list](list.md) — List filesystems
- [yc compute filesystem list-operations](list-operations.md) — List operations for the specified filesystem
- [yc compute filesystem create](create.md) — Create a filesystem
- [yc compute filesystem delete](delete.md) — Delete the specified filesystem
- [yc compute filesystem update](update.md) — Update the specified filesystem
- [yc compute filesystem resize](resize.md) — Resize the specified filesystem
- [yc compute filesystem add-labels](add-labels.md) — Add labels to specified filesystem
- [yc compute filesystem remove-labels](remove-labels.md) — Remove labels from specified filesystem

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
