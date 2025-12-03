---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/export/index.md
---

# yc beta logging export

A set of methods for managing log exports.

#### Command Usage

Syntax: 

`yc beta logging export <command>`

#### Command Tree

- [yc beta logging export create](create.md) — Creates a export in the specified folder.
- [yc beta logging export delete](delete.md) — Deletes the specified export.
- [yc beta logging export get](get.md) — Returns the specified export.
- [yc beta logging export list](list.md) — Retrieves the list of exports in the specified folder.
- [yc beta logging export list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified export.
- [yc beta logging export list-operations](list-operations.md) — Lists operations for the specified export.
- [yc beta logging export run](run.md) — Run new logs export from log group to sink
- [yc beta logging export set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified export.
- [yc beta logging export update](update.md) — Updates the specified export.
- [yc beta logging export update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified export.

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
