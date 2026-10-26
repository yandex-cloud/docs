[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Sharded PostgreSQL](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > cluster > Overview

# yc managed-sharded-postgresql v0 cluster

Manage Sharded PostgreSQL clusters

#### Command Usage

Syntax:

`yc managed-sharded-postgresql v0 cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-sharded-postgresql v0 cluster add-labels](add-labels.md) — Add labels to Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster add-subcluster](add-subcluster.md) — Add a new subcluster to the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster backup](backup.md) — Create a backup for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster create](create.md) — Create Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster delete](delete.md) — Delete the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster get](get.md) — Show information about the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster list](list.md) — List Sharded PostgreSQL clusters

- [yc managed-sharded-postgresql v0 cluster list-backups](list-backups.md) — List available backups for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster list-logs](list-logs.md) — Retrieves logs for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster list-operations](list-operations.md) — List operations for the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster remove-labels](remove-labels.md) — Remove labels from Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

- [yc managed-sharded-postgresql v0 cluster restore](restore.md) — Restore Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster update](update.md) — Update the specified Sharded PostgreSQL cluster

- [yc managed-sharded-postgresql v0 cluster update-config](update-config.md) — Update the specified Sharded PostgreSQL cluster config

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#