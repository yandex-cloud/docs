---
editable: false
noIndex: true
---

# yc beta managed-sqlserver cluster

A set of methods for managing SQL Server clusters.

#### Command Usage

Syntax:

`yc beta managed-sqlserver cluster <command>`

#### Command Tree

- [yc beta managed-sqlserver cluster backup](backup.md) — Creates a backup for the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster create](create.md) — Creates an SQL Server cluster in the specified folder.

- [yc beta managed-sqlserver cluster delete](delete.md) — Deletes the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster get](get.md) — Returns the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster list](list.md) — Retrieves the list of SQL Server clusters that belong to the specified folder.

- [yc beta managed-sqlserver cluster list-backups](list-backups.md) — Retrieves the list of available backups for the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster list-hosts](list-hosts.md) — Retrieves the list of hosts for the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster list-logs](list-logs.md) — Retrieves logs for the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster list-operations](list-operations.md) — Retrieves the list of operations for the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster move](move.md) — Moves the specified SQL Server cluster to the specified folder.

- [yc beta managed-sqlserver cluster restore](restore.md) — Creates a new SQL Server cluster using the specified backup.

- [yc beta managed-sqlserver cluster start](start.md) — Starts the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster start-failover](start-failover.md) — Starts a manual failover for a cluster.

- [yc beta managed-sqlserver cluster stop](stop.md) — Stops the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster update](update.md) — Modifies the specified SQL Server cluster.

- [yc beta managed-sqlserver cluster update-hosts](update-hosts.md) — Updates the specified hosts.

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