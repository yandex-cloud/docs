---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-clickhouse/index.md
---

# yc managed-clickhouse

Manage ClickHouse clusters, hosts, databases, backups, users and ml-models.

#### Command Usage

Syntax: 

`yc managed-clickhouse <group>`

Aliases: 

- `clickhouse`

#### Command Tree

- [yc managed-clickhouse cluster](cluster/index.md) — Manage ClickHouse clusters.
	- [yc managed-clickhouse cluster get](cluster/get.md) — Get information about a ClickHouse cluster.
	- [yc managed-clickhouse cluster list](cluster/list.md) — List ClickHouse clusters in a folder.
	- [yc managed-clickhouse cluster create](cluster/create.md) — Create a ClickHouse cluster.
	- [yc managed-clickhouse cluster restore](cluster/restore.md) — Restore a ClickHouse cluster from a backup.
	- [yc managed-clickhouse cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
	- [yc managed-clickhouse cluster update](cluster/update.md) — Modify configuration or attributes of a ClickHouse cluster.
	- [yc managed-clickhouse cluster update-config](cluster/update-config.md) — Update the configuration of a ClickHouse cluster.
	- [yc managed-clickhouse cluster add-labels](cluster/add-labels.md) — Assign labels to a ClickHouse cluster.
	- [yc managed-clickhouse cluster remove-labels](cluster/remove-labels.md) — Remove labels from a ClickHouse cluster.
	- [yc managed-clickhouse cluster delete](cluster/delete.md) — Delete a ClickHouse cluster.
	- [yc managed-clickhouse cluster add-zookeeper](cluster/add-zookeeper.md) — Adds Zookeeper hosts for a ClickHouse cluster.
	- [yc managed-clickhouse cluster backup](cluster/backup.md) — Create a backup for a ClickHouse cluster.
	- [yc managed-clickhouse cluster list-backups](cluster/list-backups.md) — List available backups for a ClickHouse cluster.
	- [yc managed-clickhouse cluster list-logs](cluster/list-logs.md) — Retrieve logs for a ClickHouse cluster.
	- [yc managed-clickhouse cluster list-operations](cluster/list-operations.md) — List operations for a ClickHouse cluster.
	- [yc managed-clickhouse cluster clear-compression](cluster/clear-compression.md) — Clear compression settings for a ClickHouse cluster.
	- [yc managed-clickhouse cluster set-compression](cluster/set-compression.md) — Set compression settings for a ClickHouse cluster.
	- [yc managed-clickhouse cluster add-external-dictionary](cluster/add-external-dictionary.md) — Add an external dictionary to a ClickHouse cluster.
	- [yc managed-clickhouse cluster remove-external-dictionary](cluster/remove-external-dictionary.md) — Remove an external dictionary from a ClickHouse cluster.
	- [yc managed-clickhouse cluster add-graphite-rollup](cluster/add-graphite-rollup.md) — Apply graphite configuration to a ClickHouse cluster.
	- [yc managed-clickhouse cluster remove-graphite-rollup](cluster/remove-graphite-rollup.md) — Remove graphite rollup configuration from a ClickHouse cluster.
	- [yc managed-clickhouse cluster move](cluster/move.md) — Move the specified ClickHouse cluster into the folder
	- [yc managed-clickhouse cluster start](cluster/start.md) — Start the specified ClickHouse cluster
	- [yc managed-clickhouse cluster stop](cluster/stop.md) — Stop the specified ClickHouse cluster
- [yc managed-clickhouse hosts](hosts/index.md) — Manage hosts of a ClickHouse cluster.
	- [yc managed-clickhouse hosts list](hosts/list.md) — List hosts for a ClickHouse cluster.
	- [yc managed-clickhouse hosts add](hosts/add.md) — Add new hosts to the cluster in specified availability zones.
	- [yc managed-clickhouse hosts update](hosts/update.md) — Update the specified hosts
	- [yc managed-clickhouse hosts delete](hosts/delete.md) — Remove specified hosts from the a cluster.
- [yc managed-clickhouse shards](shards/index.md) — Manage shards in a ClickHouse cluster.
	- [yc managed-clickhouse shards get](shards/get.md) — Get information about a shard in a ClickHouse cluster.
	- [yc managed-clickhouse shards list](shards/list.md) — List shards for a ClickHouse cluster.
	- [yc managed-clickhouse shards add](shards/add.md) — Create new shard for the cluster in the specified availability zones.
	- [yc managed-clickhouse shards update](shards/update.md) — Modify configuration or attributes of a ClickHouse shard.
	- [yc managed-clickhouse shards update-config](shards/update-config.md) — Update the configurationg for a shard.
	- [yc managed-clickhouse shards delete](shards/delete.md) — Delete a shard.
- [yc managed-clickhouse shard-groups](shard-groups/index.md) — Manage shard groups in a ClickHouse cluster.
	- [yc managed-clickhouse shard-groups get](shard-groups/get.md) — Get information about a shard group in a ClickHouse cluster.
	- [yc managed-clickhouse shard-groups list](shard-groups/list.md) — List shard groups for a ClickHouse cluster.
	- [yc managed-clickhouse shard-groups create](shard-groups/create.md) — Create new shard group for the cluster in the specified availability zones.
	- [yc managed-clickhouse shard-groups update](shard-groups/update.md) — Modify configuration or attributes of a ClickHouse shard group.
	- [yc managed-clickhouse shard-groups delete](shard-groups/delete.md) — Delete a shard group.
- [yc managed-clickhouse database](database/index.md) — Manage ClickHouse databases.
	- [yc managed-clickhouse database get](database/get.md) — Get information about a ClickHouse database.
	- [yc managed-clickhouse database list](database/list.md) — List databases for a ClickHouse cluster.
	- [yc managed-clickhouse database create](database/create.md) — Create a database in a ClickHouse cluster.
	- [yc managed-clickhouse database delete](database/delete.md) — Delete a ClickHouse database.
- [yc managed-clickhouse user](user/index.md) — Manage ClickHouse users.
	- [yc managed-clickhouse user get](user/get.md) — Get information about a ClickHouse user.
	- [yc managed-clickhouse user list](user/list.md) — List users for a ClickHouse cluster.
	- [yc managed-clickhouse user create](user/create.md) — Create a ClickHouse user.
	- [yc managed-clickhouse user update](user/update.md) — Modify attributes of a ClickHouse user.
	- [yc managed-clickhouse user delete](user/delete.md) — Delete a ClickHouse user.
	- [yc managed-clickhouse user grant-permission](user/grant-permission.md) — Grant a permission to a ClickHouse user.
	- [yc managed-clickhouse user revoke-permission](user/revoke-permission.md) — Revoke a permission from a ClickHouse user.
	- [yc managed-clickhouse user add-quota](user/add-quota.md) — Add quota to a ClickHouse user.
	- [yc managed-clickhouse user update-quota](user/update-quota.md) — Update ClickHouse user quota by interval.
	- [yc managed-clickhouse user remove-quota](user/remove-quota.md) — Remove quota from a ClickHouse user by interval.
- [yc managed-clickhouse backup](backup/index.md) — Manage ClickHouse backups.
	- [yc managed-clickhouse backup get](backup/get.md) — Get information about a ClickHouse backup.
	- [yc managed-clickhouse backup list](backup/list.md) — List ClickHouse backups available in a folder.
- [yc managed-clickhouse resource-preset](resource-preset/index.md) — Learn about ClickHouse resource presets.
	- [yc managed-clickhouse resource-preset get](resource-preset/get.md) — Get information about a ClickHouse resource preset.
	- [yc managed-clickhouse resource-preset list](resource-preset/list.md) — List available resource presets for Managed Service for ClickHouse.
- [yc managed-clickhouse ml-model](ml-model/index.md) — Manage ClickHouse machine learning models.
	- [yc managed-clickhouse ml-model get](ml-model/get.md) — Get information about a ClickHouse machine learning model.
	- [yc managed-clickhouse ml-model list](ml-model/list.md) — List machine learning models in a ClickHouse cluster.
	- [yc managed-clickhouse ml-model create](ml-model/create.md) — Create machine learning model in a ClickHouse cluster.
	- [yc managed-clickhouse ml-model update](ml-model/update.md) — Modify configuration or attributes of a ClickHouse machine learning model.
	- [yc managed-clickhouse ml-model delete](ml-model/delete.md) — Delete ClickHouse machine learning model.
- [yc managed-clickhouse format-schema](format-schema/index.md) — Manage ClickHouse format schemas.
	- [yc managed-clickhouse format-schema get](format-schema/get.md) — Get information about a ClickHouse format schema.
	- [yc managed-clickhouse format-schema list](format-schema/list.md) — List format schemas in a ClickHouse cluster.
	- [yc managed-clickhouse format-schema create](format-schema/create.md) — Create format schema in a ClickHouse cluster.
	- [yc managed-clickhouse format-schema update](format-schema/update.md) — Modify configuration or attributes of a ClickHouse format schema.
	- [yc managed-clickhouse format-schema delete](format-schema/delete.md) — Delete ClickHouse format schema.
- [yc managed-clickhouse version](version/index.md) — Manage available ClickHouse versions.
	- [yc managed-clickhouse version list](version/list.md) — List available ClickHouse versions.

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
