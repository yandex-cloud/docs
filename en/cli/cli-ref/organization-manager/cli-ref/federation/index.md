---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/federation/index.md
---

# yc organization-manager federation

Manage federations

#### Command Usage

Syntax: 

`yc organization-manager federation <group>`

Aliases: 

- `federations`

#### Command Tree

- [yc organization-manager federation group-mapping](group-mapping/index.md) — Manage group mappings for federation
	- [yc organization-manager federation group-mapping add-mapping-items](group-mapping/add-mapping-items.md) — Add group mapping items to the specified federation
	- [yc organization-manager federation group-mapping create](group-mapping/create.md) — Create a group mapping for specified federation
	- [yc organization-manager federation group-mapping delete](group-mapping/delete.md) — Delete a group mapping for specified federation
	- [yc organization-manager federation group-mapping get](group-mapping/get.md) — Show group mapping information about the specified federation
	- [yc organization-manager federation group-mapping list-mapping-items](group-mapping/list-mapping-items.md) — List group mapping items for specified federation
	- [yc organization-manager federation group-mapping remove-mapping-items](group-mapping/remove-mapping-items.md) — Remove group mapping items from the specified federation
	- [yc organization-manager federation group-mapping update](group-mapping/update.md) — Update a group mapping for specified federation
- [yc organization-manager federation saml](saml/index.md) — Manage SAML-compatible identity federations
	- [yc organization-manager federation saml add-domain](saml/add-domain.md) — Add a domain to the specified federation
	- [yc organization-manager federation saml add-labels](saml/add-labels.md) — Add labels to specified federation
	- [yc organization-manager federation saml add-user-accounts](saml/add-user-accounts.md) — Add user accounts to the specified federation
	- [yc organization-manager federation saml create](saml/create.md) — Create a federation
	- [yc organization-manager federation saml delete](saml/delete.md) — Delete the specified federation
	- [yc organization-manager federation saml delete-domain](saml/delete-domain.md) — Delete a domain from the specified federation
	- [yc organization-manager federation saml delete-user-accounts](saml/delete-user-accounts.md) — Delete user accounts from the specified federation
	- [yc organization-manager federation saml get](saml/get.md) — Show information about the specified federation
	- [yc organization-manager federation saml get-domain](saml/get-domain.md) — Show information about the specified domain in the federation
	- [yc organization-manager federation saml list](saml/list.md) — List federations
	- [yc organization-manager federation saml list-domains](saml/list-domains.md) — List domains in the specified federation
	- [yc organization-manager federation saml list-operations](saml/list-operations.md) — List operations for the specified federation
	- [yc organization-manager federation saml list-user-accounts](saml/list-user-accounts.md) — List user accounts of the specified federation
	- [yc organization-manager federation saml reactivate-user-accounts](saml/reactivate-user-accounts.md) — Reactivate specified user accounts
	- [yc organization-manager federation saml remove-labels](saml/remove-labels.md) — Remove labels from specified federation
	- [yc organization-manager federation saml suspend-user-accounts](saml/suspend-user-accounts.md) — Suspend specified user accounts
	- [yc organization-manager federation saml update](saml/update.md) — Update the specified federation
	- [yc organization-manager federation saml validate-domain](saml/validate-domain.md) — Validate a domain in the specified federation

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
