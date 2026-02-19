---
editable: false
noIndex: true
---

# yc beta ydb

Manage YDB databases

#### Command Usage

Syntax:

`yc beta ydb <group>`

#### Command Tree

- [yc beta ydb backup](backup/index.md) — A set of methods for managing backups.

  - [yc beta ydb backup delete](backup/delete.md) — Deletes the specified backup.

  - [yc beta ydb backup get](backup/get.md) — Returns the specified backup.

  - [yc beta ydb backup list](backup/list.md) — Retrieves a list of backups.

  - [yc beta ydb backup list-access-bindings](backup/list-access-bindings.md) — 

  - [yc beta ydb backup list-paths](backup/list-paths.md) — 

  - [yc beta ydb backup set-access-bindings](backup/set-access-bindings.md) — 

  - [yc beta ydb backup update-access-bindings](backup/update-access-bindings.md) — 

- [yc beta ydb database](database/index.md) — A set of methods for managing databases.

  - [yc beta ydb database backup](database/backup.md) — 

  - [yc beta ydb database create](database/create.md) — Creates a new database.

  - [yc beta ydb database delete](database/delete.md) — Deletes the specified database.

  - [yc beta ydb database get](database/get.md) — Returns the specified database.

  - [yc beta ydb database list](database/list.md) — Retrieves a list of databases.

  - [yc beta ydb database list-access-bindings](database/list-access-bindings.md) — 

  - [yc beta ydb database move](database/move.md) — 

  - [yc beta ydb database restore](database/restore.md) — Restores the specified backup

  - [yc beta ydb database set-access-bindings](database/set-access-bindings.md) — 

  - [yc beta ydb database start](database/start.md) — Starts the specified database.

  - [yc beta ydb database stop](database/stop.md) — Stops the specified database.

  - [yc beta ydb database update](database/update.md) — Modifies the specified database.

  - [yc beta ydb database update-access-bindings](database/update-access-bindings.md) — 

- [yc beta ydb location](location/index.md) — 

  - [yc beta ydb location get](location/get.md) — Returns the specified location.

  - [yc beta ydb location list](location/list.md) — Returns the list of available locations.

- [yc beta ydb resource-preset](resource-preset/index.md) — 

  - [yc beta ydb resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta ydb resource-preset list](resource-preset/list.md) — Returns the list of available resource presets.

- [yc beta ydb storage-type](storage-type/index.md) — 

  - [yc beta ydb storage-type get](storage-type/get.md) — Returns the specified storage types.

  - [yc beta ydb storage-type list](storage-type/list.md) — Returns the list of available storage types.

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