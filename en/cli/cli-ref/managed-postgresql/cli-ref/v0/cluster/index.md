---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-postgresql/cli-ref/v0/cluster/
---

# yc managed-postgresql v0 cluster

Manage PostgreSQL clusters

#### Command Usage

Syntax:

`yc managed-postgresql cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-postgresql v0 cluster add-access-binding](add-access-binding.md) — Add access binding for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster add-labels](add-labels.md) — Add labels to PostgreSQL cluster

- [yc managed-postgresql v0 cluster backup](backup.md) — Create a backup for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster create](create.md) — Create PostgreSQL cluster

- [yc managed-postgresql v0 cluster delete](delete.md) — Delete the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster get](get.md) — Show information about the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster list](list.md) — List PostgreSQL clusters

- [yc managed-postgresql v0 cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster list-backups](list-backups.md) — List available backups for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster list-logs](list-logs.md) — Retrieves logs for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster list-operations](list-operations.md) — List operations for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster move](move.md) — Move the specified PostgreSQL cluster into the folder

- [yc managed-postgresql v0 cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster remove-labels](remove-labels.md) — Remove labels from PostgreSQL cluster

- [yc managed-postgresql v0 cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

- [yc managed-postgresql v0 cluster restore](restore.md) — Restore PostgreSQL cluster

- [yc managed-postgresql v0 cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified PostgreSQL cluster and delete all existing access bindings if there were any

- [yc managed-postgresql v0 cluster start](start.md) — Start the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster start-failover](start-failover.md) — Start manual failover for the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster stop](stop.md) — Stop the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster update](update.md) — Update the specified PostgreSQL cluster

- [yc managed-postgresql v0 cluster update-config](update-config.md) — Update the specified PostgreSQL cluster config

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