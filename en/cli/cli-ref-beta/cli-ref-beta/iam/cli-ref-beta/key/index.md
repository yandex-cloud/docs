---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/key/index.md
---

# yc beta iam key

A set of methods for managing Key resources.

#### Command Usage

Syntax: 

`yc beta iam key <command>`

#### Command Tree

- [yc beta iam key create](create.md) — Creates a key pair for the specified service account.
- [yc beta iam key delete](delete.md) — Deletes the specified key pair.
- [yc beta iam key get](get.md) — Returns the specified Key resource.
- [yc beta iam key list](list.md) — Retrieves the list of Key resources for the specified service account.
- [yc beta iam key list-operations](list-operations.md) — Lists operations for the specified key.
- [yc beta iam key update](update.md) — Updates the specified key pair.

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
