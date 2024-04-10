---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-mongodb/index.md
---

# yc managed-mongodb

Manage MongoDB clusters, hosts, databases, backups and users.

#### Command Usage

Syntax: 

`yc managed-mongodb <group>`

Aliases: 

- `mongodb`
- `mongo`

#### Command Tree

- [yc managed-mongodb cluster](cluster/index.md) — Manage MongoDB clusters.
	- [yc managed-mongodb cluster get](cluster/get.md) — Get information about the specified MongoDB cluster.
	- [yc managed-mongodb cluster list](cluster/list.md) — List MongoDB clusters in a folder.
	- [yc managed-mongodb cluster create](cluster/create.md) — Create a MongoDB cluster.
	- [yc managed-mongodb cluster restore](cluster/restore.md) — Restore a MongoDB cluster from a backup.
	- [yc managed-mongodb cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
	- [yc managed-mongodb cluster update](cluster/update.md) — Modify configuration or attributes of a MongoDB cluster.
	- [yc managed-mongodb cluster update-config](cluster/update-config.md) — Update the configuration of a MongoDB cluster.
	- [yc managed-mongodb cluster add-labels](cluster/add-labels.md) — Assign labels to a MongoDB cluster.
	- [yc managed-mongodb cluster remove-labels](cluster/remove-labels.md) — Remove labels from specified MongoDB cluster
	- [yc managed-mongodb cluster delete](cluster/delete.md) — Delete the specified MongoDB cluster.
	- [yc managed-mongodb cluster backup](cluster/backup.md) — Create a backup for the specified MongoDB cluster.
	- [yc managed-mongodb cluster list-backups](cluster/list-backups.md) — List available backups for the specified MongoDB cluster.
	- [yc managed-mongodb cluster list-logs](cluster/list-logs.md) — Retrieve logs for the specified MongoDB cluster.
	- [yc managed-mongodb cluster list-operations](cluster/list-operations.md) — List operations for the specified MongoDB cluster.
	- [yc managed-mongodb cluster move](cluster/move.md) — Move the specified MongoDB cluster into the folder
	- [yc managed-mongodb cluster start](cluster/start.md) — Start the specified MongoDB cluster
	- [yc managed-mongodb cluster stop](cluster/stop.md) — Stop the specified MongoDB cluster
	- [yc managed-mongodb cluster enable-sharding](cluster/enable-sharding.md) — Enable sharding for MongoDB cluster.
- [yc managed-mongodb hosts](hosts/index.md) — Manage hosts of a MongoDB cluster.
	- [yc managed-mongodb hosts list](hosts/list.md) — List hosts for a MongoDB cluster.
	- [yc managed-mongodb hosts add](hosts/add.md) — Add new hosts to the cluster in specified availability zones.
	- [yc managed-mongodb hosts update](hosts/update.md) — Update specified hosts in the cluster.
	- [yc managed-mongodb hosts delete](hosts/delete.md) — Remove specified hosts from the a cluster.
	- [yc managed-mongodb hosts resetup](hosts/resetup.md) — Resetup specified MongoD hosts.
	- [yc managed-mongodb hosts restart](hosts/restart.md) — Restart specified MongoD hosts.
	- [yc managed-mongodb hosts stepdown](hosts/stepdown.md) — Stepdown specified MongoD hosts.
- [yc managed-mongodb database](database/index.md) — Manage MongoDB databases.
	- [yc managed-mongodb database get](database/get.md) — Get information about a MongoDB database.
	- [yc managed-mongodb database list](database/list.md) — List databases for a MongoDB cluster.
	- [yc managed-mongodb database create](database/create.md) — Create a database in a MongoDB cluster.
	- [yc managed-mongodb database delete](database/delete.md) — Delete a MongoDB database.
- [yc managed-mongodb user](user/index.md) — Manage MongoDB users.
	- [yc managed-mongodb user get](user/get.md) — Get information about a MongoDB user.
	- [yc managed-mongodb user list](user/list.md) — List users for a MongoDB cluster.
	- [yc managed-mongodb user create](user/create.md) — Create a MongoDB user.
	- [yc managed-mongodb user update](user/update.md) — Modify attributes of a MongoDB user.
	- [yc managed-mongodb user delete](user/delete.md) — Delete a MongoDB user.
	- [yc managed-mongodb user grant-permission](user/grant-permission.md) — Grant a permission to the specified MongoDB user.
	- [yc managed-mongodb user revoke-permission](user/revoke-permission.md) — Revoke a permission from the specified MongoDB user.
- [yc managed-mongodb backup](backup/index.md) — Manage MongoDB backups.
	- [yc managed-mongodb backup get](backup/get.md) — Get information about the specified MongoDB backup.
	- [yc managed-mongodb backup delete](backup/delete.md) — Delete MongoDB backup.
	- [yc managed-mongodb backup list](backup/list.md) — List MongoDB backups available in a folder.
- [yc managed-mongodb resource-preset](resource-preset/index.md) — Learn about MongoDB resource presets.
	- [yc managed-mongodb resource-preset get](resource-preset/get.md) — Get information about a MongoDB resource preset.
	- [yc managed-mongodb resource-preset list](resource-preset/list.md) — List available resource presets for Managed Service for MongoDB.
- [yc managed-mongodb shards](shards/index.md) — Manage shards in a MongoDB cluster.
	- [yc managed-mongodb shards get](shards/get.md) — Get information about a shard in a MongoDB cluster.
	- [yc managed-mongodb shards list](shards/list.md) — List shards for a MongoDB cluster.
	- [yc managed-mongodb shards add](shards/add.md) — Create new shard for the cluster in the specified availability zones.
	- [yc managed-mongodb shards delete](shards/delete.md) — Delete a shard.

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
|`-h`,`--help`|Display help for the command.|
