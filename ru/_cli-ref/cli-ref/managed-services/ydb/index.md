# yc ydb

Manage YDB databases.

#### Command Usage

Syntax: 

`yc ydb <group>`

#### Command Tree

- [yc ydb database](database/index.md) — Manage YDB databases.
	- [yc ydb database get](database/get.md) — Get information about the specified YDB database.
	- [yc ydb database list](database/list.md) — List YDB databases in a folder.
	- [yc ydb database create](database/create.md) — Create YDB database.
	- [yc ydb database backup](database/backup.md) — Backup YDB database.
	- [yc ydb database restore](database/restore.md) — Restore backup.
	- [yc ydb database update](database/update.md) — Update the specified YDB database.
	- [yc ydb database stop](database/stop.md) — Stop the specified YDB database.
	- [yc ydb database start](database/start.md) — Start the specified YDB database.
	- [yc ydb database delete](database/delete.md) — Delete the specified YDB database.
	- [yc ydb database add-labels](database/add-labels.md) — Add labels to specified YDB database.
	- [yc ydb database remove-labels](database/remove-labels.md) — Remove labels from specified YDB database.
	- [yc ydb database list-access-bindings](database/list-access-bindings.md) — List access bindings for the specified YDB database.
	- [yc ydb database set-access-bindings](database/set-access-bindings.md) — Set access bindings for the specified YDB database and delete all existing access bindings if there were any.
	- [yc ydb database add-access-binding](database/add-access-binding.md) — Add access binding for the specified YDB database.
	- [yc ydb database remove-access-binding](database/remove-access-binding.md) — Remove access binding for the specified YDB database.
- [yc ydb storage-type](storage-type/index.md) — View YDB storage types.
	- [yc ydb storage-type get](storage-type/get.md) — Get information about the specified YDB storage type preset.
	- [yc ydb storage-type list](storage-type/list.md) — List YDB storage types.
- [yc ydb resource-preset](resource-preset/index.md) — View YDB resource presets.
	- [yc ydb resource-preset get](resource-preset/get.md) — Get information about the specified YDB resource preset.
	- [yc ydb resource-preset list](resource-preset/list.md) — List YDB resource presets.
- [yc ydb backup](backup/index.md) — Manage YDB backups.
	- [yc ydb backup get](backup/get.md) — Get information about the specified YDB backup.
	- [yc ydb backup list](backup/list.md) — List YDB backups in a folder.
	- [yc ydb backup delete](backup/delete.md) — Delete the specified YDB backups.
	- [yc ydb backup list-access-bindings](backup/list-access-bindings.md) — List access bindings for the specified YDB backup.
	- [yc ydb backup set-access-bindings](backup/set-access-bindings.md) — Set access bindings for the specified YDB backup and delete all existing access bindings if there were any.
	- [yc ydb backup add-access-binding](backup/add-access-binding.md) — Add access binding for the specified YDB backup.
	- [yc ydb backup remove-access-binding](backup/remove-access-binding.md) — Remove access binding for the specified YDB backup.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
