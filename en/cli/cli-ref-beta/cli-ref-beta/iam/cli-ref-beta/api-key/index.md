---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/api-key/index.md
---

# yc beta iam api-key

A set of methods for managing API keys.

#### Command Usage

Syntax: 

`yc beta iam api-key <command>`

#### Command Tree

- [yc beta iam api-key create](create.md) — Creates an API key for the specified service account.
- [yc beta iam api-key delete](delete.md) — Deletes the specified API key.
- [yc beta iam api-key get](get.md) — Returns the specified API key.
- [yc beta iam api-key list](list.md) — Retrieves the list of API keys for the specified service account.
- [yc beta iam api-key list-operations](list-operations.md) — Retrieves the list of operations for the specified API key.
- [yc beta iam api-key list-scopes](list-scopes.md) — Retrieves the list of scopes.
- [yc beta iam api-key update](update.md) — Updates the specified API key.

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
