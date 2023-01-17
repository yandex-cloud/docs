---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-clickhouse/database/index.md
---

# yc managed-clickhouse database

Manage ClickHouse databases.

#### Command Usage

Syntax: 

`yc managed-clickhouse database <command>`

Aliases: 

- `databases`

#### Command Tree

- [yc managed-clickhouse database get](get.md) — Get information about a ClickHouse database.
- [yc managed-clickhouse database list](list.md) — List databases for a ClickHouse cluster.
- [yc managed-clickhouse database create](create.md) — Create a database in a ClickHouse cluster.
- [yc managed-clickhouse database delete](delete.md) — Delete a ClickHouse database.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
