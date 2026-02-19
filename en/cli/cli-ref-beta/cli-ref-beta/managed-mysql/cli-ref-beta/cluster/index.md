---
editable: false
noIndex: true
---

# yc beta managed-mysql cluster

A set of methods for managing MySQL clusters.

#### Command Usage

Syntax:

`yc beta managed-mysql cluster <command>`

#### Command Tree

- [yc beta managed-mysql cluster add-hosts](add-hosts.md) — Adds new hosts in a cluster.

- [yc beta managed-mysql cluster backup](backup.md) — Creates a backup for a cluster.

- [yc beta managed-mysql cluster create](create.md) — Creates a cluster in a folder.

- [yc beta managed-mysql cluster delete](delete.md) — Deletes a cluster.

- [yc beta managed-mysql cluster delete-hosts](delete-hosts.md) — Deletes the specified hosts for a cluster.

- [yc beta managed-mysql cluster get](get.md) — Retrieves information about a cluster.

- [yc beta managed-mysql cluster list](list.md) — Retrieves the list of clusters in a folder.

- [yc beta managed-mysql cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified MySQL cluster.

- [yc beta managed-mysql cluster list-backups](list-backups.md) — Retrieves a list of backups for a cluster.

- [yc beta managed-mysql cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for a cluster.

- [yc beta managed-mysql cluster list-logs](list-logs.md) — Retrieves logs for a cluster.

- [yc beta managed-mysql cluster list-operations](list-operations.md) — Retrieves a list of operations for a cluster.

- [yc beta managed-mysql cluster move](move.md) — Moves a cluster to a folder.

- [yc beta managed-mysql cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules planned maintenance operation.

- [yc beta managed-mysql cluster restore](restore.md) — Restores a backup to a new cluster.

- [yc beta managed-mysql cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified MySQL cluster.

- [yc beta managed-mysql cluster start](start.md) — Starts a cluster.

- [yc beta managed-mysql cluster start-failover](start-failover.md) — Starts a manual failover for a cluster.

- [yc beta managed-mysql cluster stop](stop.md) — Stops a cluster.

- [yc beta managed-mysql cluster update](update.md) — Updates a cluster.

- [yc beta managed-mysql cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified MySQL cluster.

- [yc beta managed-mysql cluster update-hosts](update-hosts.md) — Updates the specified hosts.

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