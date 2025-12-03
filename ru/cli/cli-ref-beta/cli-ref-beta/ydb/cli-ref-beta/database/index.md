---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/ydb/cli-ref-beta/database/index.md
---

# yc beta ydb database

A set of methods for managing databases.

#### Command Usage

Syntax: 

`yc beta ydb database <command>`

#### Command Tree

- [yc beta ydb database backup](backup.md) — 
- [yc beta ydb database create](create.md) — Creates a new database.
- [yc beta ydb database delete](delete.md) — Deletes the specified database.
- [yc beta ydb database get](get.md) — Returns the specified database.
- [yc beta ydb database list](list.md) — Retrieves a list of databases.
- [yc beta ydb database list-access-bindings](list-access-bindings.md) — 
- [yc beta ydb database move](move.md) — 
- [yc beta ydb database restore](restore.md) — Restores the specified backup
- [yc beta ydb database set-access-bindings](set-access-bindings.md) — 
- [yc beta ydb database start](start.md) — Starts the specified database.
- [yc beta ydb database stop](stop.md) — Stops the specified database.
- [yc beta ydb database update](update.md) — Modifies the specified database.
- [yc beta ydb database update-access-bindings](update-access-bindings.md) — 

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
