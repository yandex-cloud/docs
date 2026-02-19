---
editable: false
noIndex: true
---

# yc beta managed-postgresql cluster

A set of methods for managing PostgreSQL Cluster resources.

#### Command Usage

Syntax:

`yc beta managed-postgresql cluster <command>`

#### Command Tree

- [yc beta managed-postgresql cluster add-hosts](add-hosts.md) — Creates new hosts for a cluster.

- [yc beta managed-postgresql cluster backup](backup.md) — Creates a backup for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster create](create.md) — Creates a PostgreSQL cluster in the specified folder.

- [yc beta managed-postgresql cluster delete](delete.md) — Deletes the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster delete-hosts](delete-hosts.md) — Deletes the specified hosts for a cluster.

- [yc beta managed-postgresql cluster get](get.md) — Returns the specified PostgreSQL Cluster resource.

- [yc beta managed-postgresql cluster list](list.md) — Retrieves the list of PostgreSQL Cluster resources that belong

- [yc beta managed-postgresql cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster list-backups](list-backups.md) — Retrieves the list of available backups for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified cluster.

- [yc beta managed-postgresql cluster list-logs](list-logs.md) — Retrieves logs for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

- [yc beta managed-postgresql cluster move](move.md) — Moves the specified PostgreSQL cluster to the specified folder.

- [yc beta managed-postgresql cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules planned maintenance operation.

- [yc beta managed-postgresql cluster restore](restore.md) — Creates a new PostgreSQL cluster using the specified backup.

- [yc beta managed-postgresql cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster start](start.md) — Start the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster start-failover](start-failover.md) — Start a manual failover on the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster stop](stop.md) — Stop the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster update](update.md) — Updates the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified PostgreSQL cluster.

- [yc beta managed-postgresql cluster update-hosts](update-hosts.md) — Updates the specified hosts.

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