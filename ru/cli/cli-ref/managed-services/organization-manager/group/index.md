---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/group/index.md
---

# yc organization-manager group

Manage groups in organizations

#### Command Usage

Syntax: 

`yc organization-manager group <command>`

Aliases: 

- `groups`

#### Command Tree

- [yc organization-manager group get](get.md) — Show information about the specified group
- [yc organization-manager group list](list.md) — List groups
- [yc organization-manager group create](create.md) — Create a group
- [yc organization-manager group update](update.md) — Update the specified group
- [yc organization-manager group delete](delete.md) — Delete the specified group
- [yc organization-manager group list-operations](list-operations.md) — List operations for the specified group
- [yc organization-manager group list-access-bindings](list-access-bindings.md) — List access bindings for the specified group
- [yc organization-manager group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified group and delete all existing access bindings if there were any
- [yc organization-manager group add-access-binding](add-access-binding.md) — Add access binding for the specified group
- [yc organization-manager group remove-access-binding](remove-access-binding.md) — Remove access binding for the specified group
- [yc organization-manager group list-members](list-members.md) — List members of the specified group
- [yc organization-manager group add-members](add-members.md) — Add members to the specified group
- [yc organization-manager group remove-members](remove-members.md) — Remove members from the specified group

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
