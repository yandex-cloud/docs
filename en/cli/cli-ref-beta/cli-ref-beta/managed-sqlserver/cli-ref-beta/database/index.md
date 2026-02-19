---
editable: false
noIndex: true
---

# yc beta managed-sqlserver database

A set of methods for managing SQL Server databases.

#### Command Usage

Syntax:

`yc beta managed-sqlserver database <command>`

#### Command Tree

- [yc beta managed-sqlserver database create](create.md) — Creates a new SQL Server database in the specified cluster.

- [yc beta managed-sqlserver database delete](delete.md) — Deletes the specified SQL Server database.

- [yc beta managed-sqlserver database export-backup](export-backup.md) — Exports the last database backup to an external backup.

- [yc beta managed-sqlserver database get](get.md) — Returns the specified SQL Server database.

- [yc beta managed-sqlserver database import-backup](import-backup.md) — Imports a new SQL Server database from an external backup.

- [yc beta managed-sqlserver database list](list.md) — Retrieves the list of SQL Server databases in the specified cluster.

- [yc beta managed-sqlserver database restore](restore.md) — Creates a new SQL Server database in the specified cluster from a backup.

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