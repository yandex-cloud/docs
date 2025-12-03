---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/audit-trails/cli-ref-beta/index.md
---

# yc beta audit-trails

Manage Audit Trails resources

#### Command Usage

Syntax: 

`yc beta audit-trails <group>`

#### Command Tree

- [yc beta audit-trails trail](trail/index.md) — A set of methods for managing trails.
	- [yc beta audit-trails trail create](trail/create.md) — Creates a trail in the specified folder.
	- [yc beta audit-trails trail delete](trail/delete.md) — Deletes the specified trail.
	- [yc beta audit-trails trail get](trail/get.md) — Returns the specified trail.
	- [yc beta audit-trails trail list](trail/list.md) — Retrieves the list of trails in the specified folder.
	- [yc beta audit-trails trail list-access-bindings](trail/list-access-bindings.md) — Lists existing access bindings for the specified trail.
	- [yc beta audit-trails trail list-operations](trail/list-operations.md) — Lists operations for the specified trail.
	- [yc beta audit-trails trail set-access-bindings](trail/set-access-bindings.md) — Sets access bindings for the trail.
	- [yc beta audit-trails trail update](trail/update.md) — Updates the specified trail.
	- [yc beta audit-trails trail update-access-bindings](trail/update-access-bindings.md) — Updates access bindings for the trail.

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
