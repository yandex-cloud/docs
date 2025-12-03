---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/group/index.md
---

# yc beta logging group

A set of methods for managing log groups.

#### Command Usage

Syntax: 

`yc beta logging group <command>`

#### Command Tree

- [yc beta logging group create](create.md) — Creates a log group in the specified folder.
- [yc beta logging group delete](delete.md) — Deletes the specified log group.
- [yc beta logging group get](get.md) — Returns the specified log group.
- [yc beta logging group list](list.md) — Retrieves the list of log groups in the specified folder.
- [yc beta logging group list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified log group.
- [yc beta logging group list-operations](list-operations.md) — Lists operations for the specified log group.
- [yc beta logging group list-resources](list-resources.md) — Retrieves the resources (type and IDs) in the specified log group.
- [yc beta logging group set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified log group.
- [yc beta logging group stats](stats.md) — Returns stats for the specified log group.
- [yc beta logging group update](update.md) — Updates the specified log group.
- [yc beta logging group update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified log group.

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
