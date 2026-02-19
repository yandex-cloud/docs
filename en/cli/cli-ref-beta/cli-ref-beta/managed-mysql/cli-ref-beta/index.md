---
editable: false
noIndex: true
---

# yc beta managed-mysql

Manage MySQL clusters, hosts, databases, backups and users

#### Command Usage

Syntax:

`yc beta managed-mysql <group>`

#### Command Tree

- [yc beta managed-mysql backup](backup/index.md) — A set of methods for managing MySQL backups.

  - [yc beta managed-mysql backup delete](backup/delete.md) — Deletes the specified MySQL cluster backup.

  - [yc beta managed-mysql backup get](backup/get.md) — Retrieves information about the specified backup.

  - [yc beta managed-mysql backup list](backup/list.md) — Retrieves the list of backups in a folder.

- [yc beta managed-mysql cluster](cluster/index.md) — A set of methods for managing MySQL clusters.

  - [yc beta managed-mysql cluster add-hosts](cluster/add-hosts.md) — Adds new hosts in a cluster.

  - [yc beta managed-mysql cluster backup](cluster/backup.md) — Creates a backup for a cluster.

  - [yc beta managed-mysql cluster create](cluster/create.md) — Creates a cluster in a folder.

  - [yc beta managed-mysql cluster delete](cluster/delete.md) — Deletes a cluster.

  - [yc beta managed-mysql cluster delete-hosts](cluster/delete-hosts.md) — Deletes the specified hosts for a cluster.

  - [yc beta managed-mysql cluster get](cluster/get.md) — Retrieves information about a cluster.

  - [yc beta managed-mysql cluster list](cluster/list.md) — Retrieves the list of clusters in a folder.

  - [yc beta managed-mysql cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified MySQL cluster.

  - [yc beta managed-mysql cluster list-backups](cluster/list-backups.md) — Retrieves a list of backups for a cluster.

  - [yc beta managed-mysql cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for a cluster.

  - [yc beta managed-mysql cluster list-logs](cluster/list-logs.md) — Retrieves logs for a cluster.

  - [yc beta managed-mysql cluster list-operations](cluster/list-operations.md) — Retrieves a list of operations for a cluster.

  - [yc beta managed-mysql cluster move](cluster/move.md) — Moves a cluster to a folder.

  - [yc beta managed-mysql cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules planned maintenance operation.

  - [yc beta managed-mysql cluster restore](cluster/restore.md) — Restores a backup to a new cluster.

  - [yc beta managed-mysql cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified MySQL cluster.

  - [yc beta managed-mysql cluster start](cluster/start.md) — Starts a cluster.

  - [yc beta managed-mysql cluster start-failover](cluster/start-failover.md) — Starts a manual failover for a cluster.

  - [yc beta managed-mysql cluster stop](cluster/stop.md) — Stops a cluster.

  - [yc beta managed-mysql cluster update](cluster/update.md) — Updates a cluster.

  - [yc beta managed-mysql cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified MySQL cluster.

  - [yc beta managed-mysql cluster update-hosts](cluster/update-hosts.md) — Updates the specified hosts.

- [yc beta managed-mysql database](database/index.md) — A set of methods for managing MySQL databases in a cluster.

  - [yc beta managed-mysql database create](database/create.md) — Creates a new database in a cluster.

  - [yc beta managed-mysql database delete](database/delete.md) — Deletes a database from a cluster.

  - [yc beta managed-mysql database get](database/get.md) — Retrieves information about the specified database.

  - [yc beta managed-mysql database list](database/list.md) — Retrieves the list of databases in a cluster.

- [yc beta managed-mysql resource-preset](resource-preset/index.md) — A set of methods for managing MySQL resource presets.

  - [yc beta managed-mysql resource-preset get](resource-preset/get.md) — Retrieves information about a resource preset.

  - [yc beta managed-mysql resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

- [yc beta managed-mysql user](user/index.md) — A set of methods for managing MySQL users.

  - [yc beta managed-mysql user create](user/create.md) — Creates a user in a cluster.

  - [yc beta managed-mysql user delete](user/delete.md) — Deletes a user in a cluster.

  - [yc beta managed-mysql user get](user/get.md) — Retrieves information about the specified user.

  - [yc beta managed-mysql user grant-permission](user/grant-permission.md) — Grants permission to access a database to a user in a cluster.

  - [yc beta managed-mysql user list](user/list.md) — Retrieves the list of users in a cluster.

  - [yc beta managed-mysql user revoke-permission](user/revoke-permission.md) — Revokes permission to access a database from a user in a cluster.

  - [yc beta managed-mysql user update](user/update.md) — Updates a user in a cluster.

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