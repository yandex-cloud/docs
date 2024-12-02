---
editable: false
---

# yc organization-manager

Manage Yandex Organization Manager resources

#### Command Usage

Syntax: 

`yc organization-manager <group>`

#### Command Tree

- [yc organization-manager federation](federation/index.md) — Manage federations
- [yc organization-manager group](group/index.md) — Manage groups in organizations
	- [yc organization-manager group add-access-binding](group/add-access-binding.md) — Add access binding for the specified group
	- [yc organization-manager group add-members](group/add-members.md) — Add members to the specified group
	- [yc organization-manager group create](group/create.md) — Create a group
	- [yc organization-manager group delete](group/delete.md) — Delete the specified group
	- [yc organization-manager group get](group/get.md) — Show information about the specified group
	- [yc organization-manager group list](group/list.md) — List groups
	- [yc organization-manager group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified group
	- [yc organization-manager group list-members](group/list-members.md) — List members of the specified group
	- [yc organization-manager group list-operations](group/list-operations.md) — List operations for the specified group
	- [yc organization-manager group remove-access-binding](group/remove-access-binding.md) — Remove access binding for the specified group
	- [yc organization-manager group remove-members](group/remove-members.md) — Remove members from the specified group
	- [yc organization-manager group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified group and delete all existing access bindings if there were any
	- [yc organization-manager group update](group/update.md) — Update the specified group
- [yc organization-manager organization](organization/index.md) — Manage organizations
	- [yc organization-manager organization add-access-binding](organization/add-access-binding.md) — Add access binding for the specified organization
	- [yc organization-manager organization add-labels](organization/add-labels.md) — Add labels to specified organization
	- [yc organization-manager organization get](organization/get.md) — Show information about the specified organization
	- [yc organization-manager organization leave](organization/leave.md) — Remove user accounts from the specified organization. Operation is performed by the account that wants to leave.
	- [yc organization-manager organization list](organization/list.md) — List organizations
	- [yc organization-manager organization list-access-bindings](organization/list-access-bindings.md) — List access bindings for the specified organization
	- [yc organization-manager organization list-operations](organization/list-operations.md) — List operations for the specified organization
	- [yc organization-manager organization remove-access-binding](organization/remove-access-binding.md) — Remove access binding for the specified organization
	- [yc organization-manager organization remove-labels](organization/remove-labels.md) — Remove labels from specified organization
	- [yc organization-manager organization set-access-bindings](organization/set-access-bindings.md) — Set access bindings for the specified organization and delete all existing access bindings if there were any
	- [yc organization-manager organization update](organization/update.md) — Update the specified organization
- [yc organization-manager oslogin](oslogin/index.md) — Setting up OS Login
	- [yc organization-manager oslogin get-settings](oslogin/get-settings.md) — Show information about OS Login settings for the specified organization.
	- [yc organization-manager oslogin update-settings](oslogin/update-settings.md) — Update OS Login settings for the specified organization.
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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
