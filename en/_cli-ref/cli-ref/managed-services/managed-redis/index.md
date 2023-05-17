---
editable: false
---

# yc managed-redis

Manage Redis clusters, hosts, databases, backups and users.

#### Command Usage

Syntax: 

`yc managed-redis <group>`

Aliases: 

- `redis`

#### Command Tree

- [yc managed-redis cluster](cluster/index.md) — Manage Redis clusters
	- [yc managed-redis cluster get](cluster/get.md) — Show information about the specified Redis cluster
	- [yc managed-redis cluster list](cluster/list.md) — List Redis clusters
	- [yc managed-redis cluster create](cluster/create.md) — Create Redis cluster
	- [yc managed-redis cluster restore](cluster/restore.md) — Restore Redis cluster
	- [yc managed-redis cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified Redis cluster
	- [yc managed-redis cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
	- [yc managed-redis cluster update](cluster/update.md) — Update the specified Redis cluster
	- [yc managed-redis cluster update-config](cluster/update-config.md) — Update the specified Redis cluster config
	- [yc managed-redis cluster add-labels](cluster/add-labels.md) — Add labels to Redis cluster
	- [yc managed-redis cluster remove-labels](cluster/remove-labels.md) — Remove labels from Redis cluster
	- [yc managed-redis cluster delete](cluster/delete.md) — Delete the specified Redis cluster
	- [yc managed-redis cluster rebalance](cluster/rebalance.md) — Rebalance the specified Redis cluster
	- [yc managed-redis cluster backup](cluster/backup.md) — Create a backup for the specified Redis cluster
	- [yc managed-redis cluster list-backups](cluster/list-backups.md) — List available backups for the specified Redis cluster
	- [yc managed-redis cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Redis cluster
	- [yc managed-redis cluster list-operations](cluster/list-operations.md) — List operations for the specified Redis cluster
	- [yc managed-redis cluster move](cluster/move.md) — Move the specified Redis cluster into the folder
	- [yc managed-redis cluster start](cluster/start.md) — Start the specified Redis cluster
	- [yc managed-redis cluster stop](cluster/stop.md) — Stop the specified Redis cluster
- [yc managed-redis hosts](hosts/index.md) — Manage Redis cluster hosts
	- [yc managed-redis hosts list](hosts/list.md) — List hosts for the specified Redis cluster
	- [yc managed-redis hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones
	- [yc managed-redis hosts update](hosts/update.md) — Update the specified hosts
	- [yc managed-redis hosts delete](hosts/delete.md) — Delete the specified hosts
- [yc managed-redis backup](backup/index.md) — Manage Redis backups
	- [yc managed-redis backup get](backup/get.md) — Show information about the specified Redis backup
	- [yc managed-redis backup list](backup/list.md) — List available backups
- [yc managed-redis resource-preset](resource-preset/index.md) — Manage Redis resource presets
	- [yc managed-redis resource-preset get](resource-preset/get.md) — Show information about the specified Redis resource preset
	- [yc managed-redis resource-preset list](resource-preset/list.md) — List available Redis resource presets
- [yc managed-redis shards](shards/index.md) — Manage shards in a Redis cluster.
	- [yc managed-redis shards get](shards/get.md) — Get information about a shard in a Redis cluster.
	- [yc managed-redis shards list](shards/list.md) — List shards for a Redis cluster.
	- [yc managed-redis shards add](shards/add.md) — Create new shard for the cluster in the specified availability zones.
	- [yc managed-redis shards delete](shards/delete.md) — Delete shard.

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
