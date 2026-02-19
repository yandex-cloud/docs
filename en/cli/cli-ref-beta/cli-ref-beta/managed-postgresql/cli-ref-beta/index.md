---
editable: false
noIndex: true
---

# yc beta managed-postgresql

Manage PostgreSQL clusters, hosts, databases, backups and users

#### Command Usage

Syntax:

`yc beta managed-postgresql <group>`

#### Command Tree

- [yc beta managed-postgresql backup](backup/index.md) — A set of methods for managing PostgreSQL Backup resources.

  - [yc beta managed-postgresql backup delete](backup/delete.md) — Deletes the specified PostgreSQL cluster backup.

  - [yc beta managed-postgresql backup get](backup/get.md) — Returns the specified PostgreSQL Backup resource.

  - [yc beta managed-postgresql backup list](backup/list.md) — Retrieves the list of Backup resources available for the specified folder.

- [yc beta managed-postgresql backup-retention-policy](backup-retention-policy/index.md) — A set of methods for managing PostgreSQL Cluster backup retention policies.

  - [yc beta managed-postgresql backup-retention-policy create](backup-retention-policy/create.md) — Add a new retention policy.

  - [yc beta managed-postgresql backup-retention-policy delete](backup-retention-policy/delete.md) — Delete retention policy.

  - [yc beta managed-postgresql backup-retention-policy list](backup-retention-policy/list.md) — List all retention policies.

- [yc beta managed-postgresql cluster](cluster/index.md) — A set of methods for managing PostgreSQL Cluster resources.

  - [yc beta managed-postgresql cluster add-hosts](cluster/add-hosts.md) — Creates new hosts for a cluster.

  - [yc beta managed-postgresql cluster backup](cluster/backup.md) — Creates a backup for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster create](cluster/create.md) — Creates a PostgreSQL cluster in the specified folder.

  - [yc beta managed-postgresql cluster delete](cluster/delete.md) — Deletes the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster delete-hosts](cluster/delete-hosts.md) — Deletes the specified hosts for a cluster.

  - [yc beta managed-postgresql cluster get](cluster/get.md) — Returns the specified PostgreSQL Cluster resource.

  - [yc beta managed-postgresql cluster list](cluster/list.md) — Retrieves the list of PostgreSQL Cluster resources that belong

  - [yc beta managed-postgresql cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster list-backups](cluster/list-backups.md) — Retrieves the list of available backups for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified cluster.

  - [yc beta managed-postgresql cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-postgresql cluster move](cluster/move.md) — Moves the specified PostgreSQL cluster to the specified folder.

  - [yc beta managed-postgresql cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules planned maintenance operation.

  - [yc beta managed-postgresql cluster restore](cluster/restore.md) — Creates a new PostgreSQL cluster using the specified backup.

  - [yc beta managed-postgresql cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster start](cluster/start.md) — Start the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster start-failover](cluster/start-failover.md) — Start a manual failover on the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster stop](cluster/stop.md) — Stop the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster update](cluster/update.md) — Updates the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified PostgreSQL cluster.

  - [yc beta managed-postgresql cluster update-hosts](cluster/update-hosts.md) — Updates the specified hosts.

- [yc beta managed-postgresql database](database/index.md) — A set of methods for managing PostgreSQL Database resources.

  - [yc beta managed-postgresql database create](database/create.md) — Creates a new PostgreSQL database in the specified cluster.

  - [yc beta managed-postgresql database delete](database/delete.md) — Deletes the specified PostgreSQL database.

  - [yc beta managed-postgresql database get](database/get.md) — Returns the specified PostgreSQL Database resource.

  - [yc beta managed-postgresql database list](database/list.md) — Retrieves the list of PostgreSQL Database resources in the specified cluster.

  - [yc beta managed-postgresql database update](database/update.md) — Updates the specified PostgreSQL database.

- [yc beta managed-postgresql performance-diagnostics](performance-diagnostics/index.md) — A set of methods for PostgreSQL performance diagnostics.

  - [yc beta managed-postgresql performance-diagnostics list-raw-session-states](performance-diagnostics/list-raw-session-states.md) — Retrieves raw statistics on sessions. Corresponds to the [pg_stat_activity view](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

  - [yc beta managed-postgresql performance-diagnostics list-raw-statements](performance-diagnostics/list-raw-statements.md) — Retrieves statistics on planning and execution of SQL statements (queries).

- [yc beta managed-postgresql resource-preset](resource-preset/index.md) — A set of methods for managing ResourcePreset resources.

  - [yc beta managed-postgresql resource-preset get](resource-preset/get.md) — Returns the specified ResourcePreset resource.

  - [yc beta managed-postgresql resource-preset list](resource-preset/list.md) — Retrieves the list of available ResourcePreset resources.

- [yc beta managed-postgresql user](user/index.md) — A set of methods for managing PostgreSQL User resources.

  - [yc beta managed-postgresql user create](user/create.md) — Creates a PostgreSQL user in the specified cluster.

  - [yc beta managed-postgresql user delete](user/delete.md) — Deletes the specified PostgreSQL user.

  - [yc beta managed-postgresql user get](user/get.md) — Returns the specified PostgreSQL User resource.

  - [yc beta managed-postgresql user grant-permission](user/grant-permission.md) — Grants permission to the specified PostgreSQL user.

  - [yc beta managed-postgresql user list](user/list.md) — Retrieves the list of PostgreSQL User resources in the specified cluster.

  - [yc beta managed-postgresql user revoke-permission](user/revoke-permission.md) — Revokes permission from the specified PostgreSQL user.

  - [yc beta managed-postgresql user update](user/update.md) — Updates the specified PostgreSQL user.

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