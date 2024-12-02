---
editable: false
---

# yc compute host-group

Manage host groups

#### Command Usage

Syntax: 

`yc compute host-group <command>`

Aliases: 

- `host-groups`
- `hg`

#### Command Tree

- [yc compute host-group add-access-binding](add-access-binding.md) — Add access binding for the specified host group
- [yc compute host-group add-labels](add-labels.md) — Add labels to the specified host group
- [yc compute host-group create](create.md) — Create a host group
- [yc compute host-group delete](delete.md) — Delete the specified host group
- [yc compute host-group get](get.md) — Show information about the specified host group
- [yc compute host-group list](list.md) — List host groups
- [yc compute host-group list-access-bindings](list-access-bindings.md) — List access bindings for the specified host group
- [yc compute host-group list-hosts](list-hosts.md) — List hosts of the specified host group
- [yc compute host-group list-instances](list-instances.md) — List instances of the specified host group
- [yc compute host-group list-operations](list-operations.md) — List operations for the specified host group
- [yc compute host-group remove-access-binding](remove-access-binding.md) — Remove access binding for the specified host group
- [yc compute host-group remove-labels](remove-labels.md) — Remove labels from the specified host group
- [yc compute host-group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified host group and delete all existing access bindings if there were any
- [yc compute host-group update](update.md) — Update the specified host group
- [yc compute host-group update-host](update-host.md) — Update host of the specified host group

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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
