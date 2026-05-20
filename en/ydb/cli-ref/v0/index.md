---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/ydb/cli-ref/v0/index
editable: false
---

# yc ydb v0

Manage YDB databases.

#### Command Usage

Syntax:

`yc ydb v0 <group>`

#### Command Tree

- [yc ydb v0 backup](backup/index.md) — Manage YDB backups.

  - [yc ydb v0 backup add-access-binding](backup/add-access-binding.md) — Add access binding for the specified YDB backup.

  - [yc ydb v0 backup delete](backup/delete.md) — Delete the specified YDB backups.

  - [yc ydb v0 backup get](backup/get.md) — Get information about the specified YDB backup.

  - [yc ydb v0 backup list](backup/list.md) — List YDB backups in a folder.

  - [yc ydb v0 backup list-access-bindings](backup/list-access-bindings.md) — List access bindings for the specified YDB backup.

  - [yc ydb v0 backup remove-access-binding](backup/remove-access-binding.md) — Remove access binding for the specified YDB backup.

  - [yc ydb v0 backup set-access-bindings](backup/set-access-bindings.md) — Set access bindings for the specified YDB backup and delete all existing access bindings if there were any.

- [yc ydb v0 database](database/index.md) — Manage YDB databases.

  - [yc ydb v0 database add-access-binding](database/add-access-binding.md) — Add access binding for the specified YDB database.

  - [yc ydb v0 database add-labels](database/add-labels.md) — Add labels to specified YDB database.

  - [yc ydb v0 database backup](database/backup.md) — Backup YDB database.

  - [yc ydb v0 database create](database/create.md) — Create YDB database.

  - [yc ydb v0 database delete](database/delete.md) — Delete the specified YDB database.

  - [yc ydb v0 database get](database/get.md) — Get information about the specified YDB database.

  - [yc ydb v0 database list](database/list.md) — List YDB databases in a folder.

  - [yc ydb v0 database list-access-bindings](database/list-access-bindings.md) — List access bindings for the specified YDB database.

  - [yc ydb v0 database move](database/move.md) — Move YDB database to another folder.

  - [yc ydb v0 database remove-access-binding](database/remove-access-binding.md) — Remove access binding for the specified YDB database.

  - [yc ydb v0 database remove-labels](database/remove-labels.md) — Remove labels from specified YDB database.

  - [yc ydb v0 database restore](database/restore.md) — Restore backup.

  - [yc ydb v0 database set-access-bindings](database/set-access-bindings.md) — Set access bindings for the specified YDB database and delete all existing access bindings if there were any.

  - [yc ydb v0 database start](database/start.md) — Start the specified YDB database.

  - [yc ydb v0 database stop](database/stop.md) — Stop the specified YDB database.

  - [yc ydb v0 database update](database/update.md) — Update the specified YDB database.

- [yc ydb v0 resource-preset](resource-preset/index.md) — View YDB resource presets.

  - [yc ydb v0 resource-preset get](resource-preset/get.md) — Get information about the specified YDB resource preset.

  - [yc ydb v0 resource-preset list](resource-preset/list.md) — List YDB resource presets.

- [yc ydb v0 storage-type](storage-type/index.md) — View YDB storage types.

  - [yc ydb v0 storage-type get](storage-type/get.md) — Get information about the specified YDB storage type preset.

  - [yc ydb v0 storage-type list](storage-type/list.md) — List YDB storage types.

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
