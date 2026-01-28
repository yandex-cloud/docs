---
editable: false
sourcePath: en/_cli-ref/cli-ref/ydb/cli-ref/database/index.md
---

# yc ydb database

Manage YDB databases.

#### Command Usage

Syntax:

`yc ydb database <command>`

Aliases:

- `db`

#### Command Tree

- [yc ydb database add-access-binding](add-access-binding.md) — Add access binding for the specified YDB database.

- [yc ydb database add-labels](add-labels.md) — Add labels to specified YDB database.

- [yc ydb database backup](backup.md) — Backup YDB database.

- [yc ydb database create](create.md) — Create YDB database.

- [yc ydb database delete](delete.md) — Delete the specified YDB database.

- [yc ydb database get](get.md) — Get information about the specified YDB database.

- [yc ydb database list](list.md) — List YDB databases in a folder.

- [yc ydb database list-access-bindings](list-access-bindings.md) — List access bindings for the specified YDB database.

- [yc ydb database move](move.md) — Move YDB database to another folder.

- [yc ydb database remove-access-binding](remove-access-binding.md) — Remove access binding for the specified YDB database.

- [yc ydb database remove-labels](remove-labels.md) — Remove labels from specified YDB database.

- [yc ydb database restore](restore.md) — Restore backup.

- [yc ydb database set-access-bindings](set-access-bindings.md) — Set access bindings for the specified YDB database and delete all existing access bindings if there were any.

- [yc ydb database start](start.md) — Start the specified YDB database.

- [yc ydb database stop](stop.md) — Stop the specified YDB database.

- [yc ydb database update](update.md) — Update the specified YDB database.

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