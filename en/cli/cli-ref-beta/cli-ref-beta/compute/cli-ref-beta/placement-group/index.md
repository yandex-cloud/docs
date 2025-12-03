---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/placement-group/index.md
---

# yc beta compute placement-group

A set of methods for managing placement groups.

#### Command Usage

Syntax: 

`yc beta compute placement-group <command>`

#### Command Tree

- [yc beta compute placement-group create](create.md) — Creates a placement group in the specified folder.
- [yc beta compute placement-group delete](delete.md) — Deletes the specified placement group.
- [yc beta compute placement-group get](get.md) — Returns the specified placement group.
- [yc beta compute placement-group list](list.md) — Retrieves the list of placement groups in the specified folder.
- [yc beta compute placement-group list-access-bindings](list-access-bindings.md) — Lists access bindings for the placement group.
- [yc beta compute placement-group list-instances](list-instances.md) — Lists instances for the specified placement group.
- [yc beta compute placement-group list-operations](list-operations.md) — Lists operations for the specified placement group.
- [yc beta compute placement-group set-access-bindings](set-access-bindings.md) — Sets access bindings for the placement group.
- [yc beta compute placement-group update](update.md) — Updates the specified placement group.
- [yc beta compute placement-group update-access-bindings](update-access-bindings.md) — Updates access bindings for the placement group.

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
