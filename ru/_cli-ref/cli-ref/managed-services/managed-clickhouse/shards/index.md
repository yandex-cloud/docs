# yc managed-clickhouse shards

Manage shards in a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse shards <command>`

Aliases: 

- `shard`

#### Command Tree

- [yc managed-clickhouse shards get](get.md) — Get information about a shard in a ClickHouse cluster.
- [yc managed-clickhouse shards list](list.md) — List shards for a ClickHouse cluster.
- [yc managed-clickhouse shards add](add.md) — Create new shard for the cluster in the specified availability zones.
- [yc managed-clickhouse shards update](update.md) — Modify configuration or attributes of a ClickHouse shard.
- [yc managed-clickhouse shards update-config](update-config.md) — Update the configurationg for a shard.
- [yc managed-clickhouse shards delete](delete.md) — Delete a shard.

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
