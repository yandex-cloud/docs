---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-clickhouse/cli-ref/shards/index.md
---

# yc managed-clickhouse shards

Manage shards in a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse shards <command>`

Aliases: 

- `shard`

#### Command Tree

- [yc managed-clickhouse shards add](add.md) — Create new shard(s) for the cluster in the specified availability zones.
- [yc managed-clickhouse shards delete](delete.md) — Delete a shard.
- [yc managed-clickhouse shards get](get.md) — Get information about a shard in a ClickHouse cluster.
- [yc managed-clickhouse shards list](list.md) — List shards for a ClickHouse cluster.
- [yc managed-clickhouse shards update](update.md) — Modify configuration or attributes of a ClickHouse shard.
- [yc managed-clickhouse shards update-config](update-config.md) — Update the configurationg for a shard.

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
