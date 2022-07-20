---
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/index.md
---
# yc organization-manager

Manage Yandex Organization Manager resources

#### Command Usage

Syntax: 

`yc organization-manager <group>`

#### Command Tree

- [yc organization-manager organization](organization/index.md) — Manage organizations
	- [yc organization-manager organization get](organization/get.md) — Show information about the specified organization
	- [yc organization-manager organization list](organization/list.md) — List organizations
	- [yc organization-manager organization update](organization/update.md) — Update the specified organization
	- [yc organization-manager organization list-access-bindings](organization/list-access-bindings.md) — List access bindings for the specified organization
	- [yc organization-manager organization set-access-bindings](organization/set-access-bindings.md) — Set access bindings for the specified organization and delete all existing access bindings if there were any
	- [yc organization-manager organization add-access-binding](organization/add-access-binding.md) — Add access binding for the specified organization
	- [yc organization-manager organization remove-access-binding](organization/remove-access-binding.md) — Remove access binding for the specified organization
	- [yc organization-manager organization list-operations](organization/list-operations.md) — List operations for the specified organization
	- [yc organization-manager organization leave](organization/leave.md) — Remove user accounts from the specified organization. Operation is performed by the account that wants to leave.
- [yc organization-manager federation](federation/index.md) — Manage federations
- [yc organization-manager user](user/index.md) — Manage users in organizations
	- [yc organization-manager user list](user/list.md) — List user accounts of the specified organization
	- [yc organization-manager user remove](user/remove.md) — Remove user accounts from the specified organization

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
