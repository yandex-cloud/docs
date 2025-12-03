---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-sqlserver/cli-ref-beta/user/index.md
---

# yc beta managed-sqlserver user

A set of methods for managing SQL Server users.

#### Command Usage

Syntax: 

`yc beta managed-sqlserver user <command>`

#### Command Tree

- [yc beta managed-sqlserver user create](create.md) — Creates an SQL Server user in the specified cluster.
- [yc beta managed-sqlserver user delete](delete.md) — Deletes the specified SQL Server user.
- [yc beta managed-sqlserver user get](get.md) — Returns the specified SQL Server user.
- [yc beta managed-sqlserver user grant-permission](grant-permission.md) — Grants a permission to the specified SQL Server user.
- [yc beta managed-sqlserver user list](list.md) — Retrieves a list of SQL Server users in the specified cluster.
- [yc beta managed-sqlserver user revoke-permission](revoke-permission.md) — Revokes a permission from the specified SQL Server user.
- [yc beta managed-sqlserver user update](update.md) — Modifies the specified SQL Server user.

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
