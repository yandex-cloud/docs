---
sourcePath: en/_cli-ref/cli-ref/managed-services/datatransfer/endpoint/create/index.md
---
# yc datatransfer endpoint create

Create endpoint

#### Command Usage

Syntax: 

`yc datatransfer endpoint create <command>`

#### Command Tree

- [yc datatransfer endpoint create postgres-source](postgres-source.md) — Create PostgreSQL source
- [yc datatransfer endpoint create postgres-target](postgres-target.md) — Create PostgreSQL target
- [yc datatransfer endpoint create mysql-source](mysql-source.md) — Create MySQL source
- [yc datatransfer endpoint create mysql-target](mysql-target.md) — Create MySQL target
- [yc datatransfer endpoint create mongo-source](mongo-source.md) — Create MongoDB source
- [yc datatransfer endpoint create mongo-target](mongo-target.md) — Create MongoDB target
- [yc datatransfer endpoint create clickhouse-source](clickhouse-source.md) — Create Clickhouse source
- [yc datatransfer endpoint create clickhouse-target](clickhouse-target.md) — Create Clickhouse target

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
