---
editable: false
---

# yc container node-group

Manage node groups.

#### Command Usage

Syntax: 

`yc container node-group <command>`

Aliases: 

- `node-groups`

#### Command Tree

- [yc container node-group get](get.md) — Get information about a node group.
- [yc container node-group list](list.md) — List node groups available in a folder.
- [yc container node-group create](create.md) — Create a node group.
- [yc container node-group update](update.md) — Modify configuration or attributes of a node group.
- [yc container node-group add-metadata](add-metadata.md) — Add or update metadata of the node template of the specified node group.
- [yc container node-group remove-metadata](remove-metadata.md) — Remove keys from metadata of the node template of the specified node group.
- [yc container node-group add-labels](add-labels.md) — Add labels to the specified node group.
- [yc container node-group remove-labels](remove-labels.md) — Remove labels from the specified node group.
- [yc container node-group add-node-labels](add-node-labels.md) — Add NODE labels to the specified node group.
- [yc container node-group remove-node-labels](remove-node-labels.md) — Remove NODE labels from the specified node group.
- [yc container node-group delete](delete.md) — Delete a node group.
- [yc container node-group list-operations](list-operations.md) — List operations for the specified node group.
- [yc container node-group list-nodes](list-nodes.md) — List nodes for the specified node group.

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
