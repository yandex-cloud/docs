---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-redis/shards/index.md
---
# yc managed-redis shards

Manage shards in a Redis cluster.

#### Command Usage

Syntax: 

`yc managed-redis shards <command>`

Aliases: 

- `shard`

#### Command Tree

- [yc managed-redis shards get](get.md) — Get information about a shard in a Redis cluster.
- [yc managed-redis shards list](list.md) — List shards for a Redis cluster.
- [yc managed-redis shards add](add.md) — Create new shard for the cluster in the specified availability zones.
- [yc managed-redis shards delete](delete.md) — Delete shard.

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
