---
editable: false
noIndex: true
---

# yc beta managed-sqlserver

Manage SQLServer clusters, databases, backups and users

#### Command Usage

Syntax:

`yc beta managed-sqlserver <group>`

#### Command Tree

- [yc beta managed-sqlserver backup](backup/index.md) — A set of methods for managing SQL Server backups.

  - [yc beta managed-sqlserver backup get](backup/get.md) — Returns the specified SQL Server backup.

  - [yc beta managed-sqlserver backup list](backup/list.md) — Retrieves the list of SQL Server backups available for the specified folder.

- [yc beta managed-sqlserver cluster](cluster/index.md) — A set of methods for managing SQL Server clusters.

  - [yc beta managed-sqlserver cluster backup](cluster/backup.md) — Creates a backup for the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster create](cluster/create.md) — Creates an SQL Server cluster in the specified folder.

  - [yc beta managed-sqlserver cluster delete](cluster/delete.md) — Deletes the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster get](cluster/get.md) — Returns the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster list](cluster/list.md) — Retrieves the list of SQL Server clusters that belong to the specified folder.

  - [yc beta managed-sqlserver cluster list-backups](cluster/list-backups.md) — Retrieves the list of available backups for the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster list-hosts](cluster/list-hosts.md) — Retrieves the list of hosts for the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster list-operations](cluster/list-operations.md) — Retrieves the list of operations for the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster move](cluster/move.md) — Moves the specified SQL Server cluster to the specified folder.

  - [yc beta managed-sqlserver cluster restore](cluster/restore.md) — Creates a new SQL Server cluster using the specified backup.

  - [yc beta managed-sqlserver cluster start](cluster/start.md) — Starts the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster start-failover](cluster/start-failover.md) — Starts a manual failover for a cluster.

  - [yc beta managed-sqlserver cluster stop](cluster/stop.md) — Stops the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster update](cluster/update.md) — Modifies the specified SQL Server cluster.

  - [yc beta managed-sqlserver cluster update-hosts](cluster/update-hosts.md) — Updates the specified hosts.

- [yc beta managed-sqlserver database](database/index.md) — A set of methods for managing SQL Server databases.

  - [yc beta managed-sqlserver database create](database/create.md) — Creates a new SQL Server database in the specified cluster.

  - [yc beta managed-sqlserver database delete](database/delete.md) — Deletes the specified SQL Server database.

  - [yc beta managed-sqlserver database export-backup](database/export-backup.md) — Exports the last database backup to an external backup.

  - [yc beta managed-sqlserver database get](database/get.md) — Returns the specified SQL Server database.

  - [yc beta managed-sqlserver database import-backup](database/import-backup.md) — Imports a new SQL Server database from an external backup.

  - [yc beta managed-sqlserver database list](database/list.md) — Retrieves the list of SQL Server databases in the specified cluster.

  - [yc beta managed-sqlserver database restore](database/restore.md) — Creates a new SQL Server database in the specified cluster from a backup.

- [yc beta managed-sqlserver resource-preset](resource-preset/index.md) — A set of methods for managing resource presets.

  - [yc beta managed-sqlserver resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta managed-sqlserver resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

- [yc beta managed-sqlserver user](user/index.md) — A set of methods for managing SQL Server users.

  - [yc beta managed-sqlserver user create](user/create.md) — Creates an SQL Server user in the specified cluster.

  - [yc beta managed-sqlserver user delete](user/delete.md) — Deletes the specified SQL Server user.

  - [yc beta managed-sqlserver user get](user/get.md) — Returns the specified SQL Server user.

  - [yc beta managed-sqlserver user grant-permission](user/grant-permission.md) — Grants a permission to the specified SQL Server user.

  - [yc beta managed-sqlserver user list](user/list.md) — Retrieves a list of SQL Server users in the specified cluster.

  - [yc beta managed-sqlserver user revoke-permission](user/revoke-permission.md) — Revokes a permission from the specified SQL Server user.

  - [yc beta managed-sqlserver user update](user/update.md) — Modifies the specified SQL Server user.

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