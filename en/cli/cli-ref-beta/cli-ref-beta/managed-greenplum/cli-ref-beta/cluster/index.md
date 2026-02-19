---
editable: false
noIndex: true
---

# yc beta managed-greenplum cluster

A set of methods for managing Greenplum® clusters.

#### Command Usage

Syntax:

`yc beta managed-greenplum cluster <command>`

#### Command Tree

- [yc beta managed-greenplum cluster backup](backup.md) — Creates a backup for the specified Greenplum cluster.

- [yc beta managed-greenplum cluster create](create.md) — Creates a Greenplum® cluster in the specified folder.

- [yc beta managed-greenplum cluster delete](delete.md) — Deletes the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster expand](expand.md) — Expands the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster get](get.md) — Returns the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster list](list.md) — Retrieves a list of Greenplum® clusters that belong to the specified folder.

- [yc beta managed-greenplum cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster list-backups](list-backups.md) — Retrieves a list of available backups for the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster list-logs](list-logs.md) — Retrieves logs for the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster list-master-hosts](list-master-hosts.md) — Retrieves a list of master hosts for the specified cluster.

- [yc beta managed-greenplum cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

- [yc beta managed-greenplum cluster list-segment-hosts](list-segment-hosts.md) — Retrieves a list of segment hosts for the specified cluster.

- [yc beta managed-greenplum cluster move](move.md) — Moves the specified Greenplum® cluster to the specified folder.

- [yc beta managed-greenplum cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule planned maintenance operation.

- [yc beta managed-greenplum cluster restore](restore.md) — Creates a new Greenplum® cluster using the specified backup.

- [yc beta managed-greenplum cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster start](start.md) — Starts the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster stop](stop.md) — Stops the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster update](update.md) — Updates the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Greenplum® cluster.

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