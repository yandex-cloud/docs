---
editable: false
---

# yc vpc network

Manage networks.

#### Command Usage

Syntax: 

`yc vpc network <command>`

Aliases: 

- `networks`
- `net`

#### Command Tree

- [yc vpc network get](get.md) — Get information about a network.
- [yc vpc network list](list.md) — List networks in a folder.
- [yc vpc network create](create.md) — Create a network.
- [yc vpc network update](update.md) — Modify configuration or attributes of a network.
- [yc vpc network add-labels](add-labels.md) — Assign labels to a network.
- [yc vpc network remove-labels](remove-labels.md) — Remove labels from a network.
- [yc vpc network delete](delete.md) — Delete a network.
- [yc vpc network list-subnets](list-subnets.md) — List subnets in a network.
- [yc vpc network list-security-groups](list-security-groups.md) — List security groups in a network.
- [yc vpc network list-route-tables](list-route-tables.md) — List route tables in a network.
- [yc vpc network list-operations](list-operations.md) — List operations for a network.
- [yc vpc network move](move.md) — Move a network to another folder.

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
