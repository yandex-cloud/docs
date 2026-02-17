---
editable: false
---

# yc managed-sharded-postgresql cluster

Manage Sharded PostgreSQL clusters

#### Command Usage

Syntax:

`yc managed-sharded-postgresql cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-sharded-postgresql cluster add-labels](add-labels.md) — Add labels to Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster add-subcluster](add-subcluster.md) — Add a new subcluster to the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster backup](backup.md) — Create a backup for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster create](create.md) — Create Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster delete](delete.md) — Delete the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster get](get.md) — Show information about the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster list](list.md) — List Sharded PostgreSQL clusters

- [yc managed-sharded-postgresql cluster list-backups](list-backups.md) — List available backups for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster list-logs](list-logs.md) — Retrieves logs for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster list-operations](list-operations.md) — List operations for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster remove-labels](remove-labels.md) — Remove labels from Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

- [yc managed-sharded-postgresql cluster restore](restore.md) — Restore Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster update](update.md) — Update the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql cluster update-config](update-config.md) — Update the specified Sharded PostgreSQL cluster config

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