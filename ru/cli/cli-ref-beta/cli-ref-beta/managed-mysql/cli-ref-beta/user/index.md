---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/user/index.md
---

# yc beta managed-mysql user

A set of methods for managing MySQL users.

#### Command Usage

Syntax: 

`yc beta managed-mysql user <command>`

#### Command Tree

- [yc beta managed-mysql user create](create.md) — Creates a user in a cluster.
- [yc beta managed-mysql user delete](delete.md) — Deletes a user in a cluster.
- [yc beta managed-mysql user get](get.md) — Retrieves information about the specified user.
- [yc beta managed-mysql user grant-permission](grant-permission.md) — Grants permission to access a database to a user in a cluster.
- [yc beta managed-mysql user list](list.md) — Retrieves the list of users in a cluster.
- [yc beta managed-mysql user revoke-permission](revoke-permission.md) — Revokes permission to access a database from a user in a cluster.
- [yc beta managed-mysql user update](update.md) — Updates a user in a cluster.

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
