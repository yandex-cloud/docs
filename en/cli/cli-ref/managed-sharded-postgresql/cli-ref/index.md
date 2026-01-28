---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-sharded-postgresql/cli-ref/index.md
---

# yc managed-sharded-postgresql

Manage Sharded PostgreSQL clusters, hosts, databases, backups and users.

#### Command Usage

Syntax:

`yc managed-sharded-postgresql <group|command>`

Aliases:

- `spqr`

- `sharded-postgresql`

#### Command Tree

- [yc managed-sharded-postgresql resource-preset](resource-preset.md) — Manage Sharded PostgreSQL resource presets

- [yc managed-sharded-postgresql backup](backup/index.md) — Manage Sharded PostgreSQL backups

  - [yc managed-sharded-postgresql backup delete](backup/delete.md) — Delete the specified Sharded PostgreSQL backup

  - [yc managed-sharded-postgresql backup get](backup/get.md) — Show information about the specified Sharded PostgreSQL backup

  - [yc managed-sharded-postgresql backup list](backup/list.md) — List available backups

- [yc managed-sharded-postgresql cluster](cluster/index.md) — Manage Sharded PostgreSQL clusters

  - [yc managed-sharded-postgresql cluster add-labels](cluster/add-labels.md) — Add labels to Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster add-subcluster](cluster/add-subcluster.md) — Add a new subcluster to the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster backup](cluster/backup.md) — Create a backup for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster create](cluster/create.md) — Create Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster delete](cluster/delete.md) — Delete the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster get](cluster/get.md) — Show information about the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster list](cluster/list.md) — List Sharded PostgreSQL clusters

  - [yc managed-sharded-postgresql cluster list-backups](cluster/list-backups.md) — List available backups for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster list-operations](cluster/list-operations.md) — List operations for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster remove-labels](cluster/remove-labels.md) — Remove labels from Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-sharded-postgresql cluster restore](cluster/restore.md) — Restore Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster update](cluster/update.md) — Update the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql cluster update-config](cluster/update-config.md) — Update the specified Sharded PostgreSQL cluster config

- [yc managed-sharded-postgresql database](database/index.md) — Manage Sharded PostgreSQL databases

  - [yc managed-sharded-postgresql database create](database/create.md) — Create Sharded PostgreSQL database

  - [yc managed-sharded-postgresql database delete](database/delete.md) — Delete the specified Sharded PostgreSQL database

  - [yc managed-sharded-postgresql database get](database/get.md) — Show information about the specified Sharded PostgreSQL database

  - [yc managed-sharded-postgresql database list](database/list.md) — List Sharded PostgreSQL databases

- [yc managed-sharded-postgresql hosts](hosts/index.md) — Manage Sharded PostgreSQL cluster hosts

  - [yc managed-sharded-postgresql hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones

  - [yc managed-sharded-postgresql hosts delete](hosts/delete.md) — Delete the specified hosts

  - [yc managed-sharded-postgresql hosts list](hosts/list.md) — List hosts for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql hosts update](hosts/update.md) — Update the specified hosts

- [yc managed-sharded-postgresql user](user/index.md) — Manage Sharded PostgreSQL users

  - [yc managed-sharded-postgresql user create](user/create.md) — Create a Sharded PostgreSQL user

  - [yc managed-sharded-postgresql user delete](user/delete.md) — Delete the specified Sharded PostgreSQL user

  - [yc managed-sharded-postgresql user get](user/get.md) — Show information about the specified Sharded PostgreSQL user

  - [yc managed-sharded-postgresql user list](user/list.md) — List users for the specified Sharded PostgreSQL cluster

  - [yc managed-sharded-postgresql user update](user/update.md) — Update the specified Sharded PostgreSQL user

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#