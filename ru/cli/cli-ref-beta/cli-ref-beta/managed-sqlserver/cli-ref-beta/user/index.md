---
editable: false
noIndex: true
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

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#