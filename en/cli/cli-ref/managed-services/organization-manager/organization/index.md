---
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/organization/index.md
---
# yc organization-manager organization

Manage organizations

#### Command Usage

Syntax: 

`yc organization-manager organization <command>`

Aliases: 

- `organizations`

#### Command Tree

- [yc organization-manager organization get](get.md) — Show information about the specified organization
- [yc organization-manager organization list](list.md) — List organizations
- [yc organization-manager organization update](update.md) — Update the specified organization
- [yc organization-manager organization list-access-bindings](list-access-bindings.md) — List access bindings for the specified organization
- [yc organization-manager organization set-access-bindings](set-access-bindings.md) — Set access bindings for the specified organization and delete all existing access bindings if there were any
- [yc organization-manager organization add-access-binding](add-access-binding.md) — Add access binding for the specified organization
- [yc organization-manager organization remove-access-binding](remove-access-binding.md) — Remove access binding for the specified organization
- [yc organization-manager organization list-operations](list-operations.md) — List operations for the specified organization
- [yc organization-manager organization leave](leave.md) — Remove user accounts from the specified organization. Operation is performed by the account that wants to leave.

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
