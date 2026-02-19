---
editable: false
noIndex: true
---

# yc beta managed-clickhouse user

A set of methods for managing ClickHouse User resources.
NOTE: these methods are available only if user management through SQL is disabled.

#### Command Usage

Syntax:

`yc beta managed-clickhouse user <command>`

#### Command Tree

- [yc beta managed-clickhouse user create](create.md) — Creates a ClickHouse user in the specified cluster.

- [yc beta managed-clickhouse user delete](delete.md) — Deletes the specified ClickHouse user.

- [yc beta managed-clickhouse user get](get.md) — Returns the specified ClickHouse User resource.

- [yc beta managed-clickhouse user grant-permission](grant-permission.md) — Grants a permission to the specified ClickHouse user.

- [yc beta managed-clickhouse user list](list.md) — Retrieves the list of ClickHouse User resources in the specified cluster.

- [yc beta managed-clickhouse user revoke-permission](revoke-permission.md) — Revokes a permission from the specified ClickHouse user.

- [yc beta managed-clickhouse user update](update.md) — Updates the specified ClickHouse user.

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