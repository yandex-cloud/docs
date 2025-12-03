---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/index.md
---

# yc beta organization-manager federation



#### Command Usage

Syntax: 

`yc beta organization-manager federation <group>`

#### Command Tree

- [yc beta organization-manager federation group-mapping](group-mapping/index.md) — RPC service dedicated for federation group mapping.
	- [yc beta organization-manager federation group-mapping create](group-mapping/create.md) — Adds a group mapping for a federation
	- [yc beta organization-manager federation group-mapping delete](group-mapping/delete.md) — Deletes a group mapping. This will remove all the mapping items
	- [yc beta organization-manager federation group-mapping get](group-mapping/get.md) — Returns a group mapping configured for the specific federation
	- [yc beta organization-manager federation group-mapping list-items](group-mapping/list-items.md) — Returns all the group mappings items
	- [yc beta organization-manager federation group-mapping update](group-mapping/update.md) — Updates an existing group mapping for a federation
	- [yc beta organization-manager federation group-mapping update-items](group-mapping/update-items.md) — Updates group mapping items for a specified federation
- [yc beta organization-manager federation saml](saml/index.md) — 

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
