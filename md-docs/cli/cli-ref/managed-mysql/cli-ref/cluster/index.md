[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [managed-mysql](../index.md) > cluster > Overview

# yc managed-mysql cluster

Manage MySQL clusters

#### Command Usage

Syntax:

`yc managed-mysql cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-mysql cluster add-access-binding](add-access-binding.md) — Add access binding for the specified MySQL cluster

- [yc managed-mysql cluster add-labels](add-labels.md) — Add labels to MySQL cluster

- [yc managed-mysql cluster backup](backup.md) — Create a backup for the specified MySQL cluster

- [yc managed-mysql cluster create](create.md) — Create MySQL cluster

- [yc managed-mysql cluster delete](delete.md) — Delete the specified MySQL cluster

- [yc managed-mysql cluster get](get.md) — Show information about the specified MySQL cluster

- [yc managed-mysql cluster list](list.md) — List MySQL clusters

- [yc managed-mysql cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified MySQL cluster

- [yc managed-mysql cluster list-backups](list-backups.md) — List available backups for the specified MySQL cluster

- [yc managed-mysql cluster list-logs](list-logs.md) — Retrieves logs for the specified MySQL cluster

- [yc managed-mysql cluster list-operations](list-operations.md) — List operations for the specified MySQL cluster

- [yc managed-mysql cluster move](move.md) — Move the specified MySQL cluster into the folder

- [yc managed-mysql cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified MySQL cluster

- [yc managed-mysql cluster remove-labels](remove-labels.md) — Remove labels from MySQL cluster

- [yc managed-mysql cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

- [yc managed-mysql cluster restore](restore.md) — Restore MySQL cluster

- [yc managed-mysql cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified MySQL cluster and delete all existing access bindings if there were any

- [yc managed-mysql cluster start](start.md) — Start the specified MySQL cluster

- [yc managed-mysql cluster start-failover](start-failover.md) — Start manual failover for the specified MySQL cluster

- [yc managed-mysql cluster stop](stop.md) — Stop the specified MySQL cluster

- [yc managed-mysql cluster stream-logs](stream-logs.md) — Stream logs for the specified MySQL cluster

- [yc managed-mysql cluster update](update.md) — Update the specified MySQL cluster

- [yc managed-mysql cluster update-config](update-config.md) — Update the specified MySQL cluster config

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