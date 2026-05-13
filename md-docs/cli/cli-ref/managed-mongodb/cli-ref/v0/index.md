# yc managed-mongodb v0

Manage MongoDB clusters, hosts, databases, backups and users.

#### Command Usage

Syntax:

`yc managed-mongodb v0 <group>`

#### Command Tree

- [yc managed-mongodb v0 backup](backup/index.md) — Manage MongoDB backups.

  - [yc managed-mongodb v0 backup delete](backup/delete.md) — Delete MongoDB backup.

  - [yc managed-mongodb v0 backup get](backup/get.md) — Get information about the specified MongoDB backup.

  - [yc managed-mongodb v0 backup list](backup/list.md) — List MongoDB backups available in a folder.

- [yc managed-mongodb v0 cluster](cluster/index.md) — Manage MongoDB clusters.

  - [yc managed-mongodb v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified MongoDB cluster

  - [yc managed-mongodb v0 cluster add-labels](cluster/add-labels.md) — Assign labels to a MongoDB cluster.

  - [yc managed-mongodb v0 cluster backup](cluster/backup.md) — Create a backup for the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster create](cluster/create.md) — Create a MongoDB cluster.

  - [yc managed-mongodb v0 cluster delete](cluster/delete.md) — Delete the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster enable-sharding](cluster/enable-sharding.md) — Enable sharding for MongoDB cluster.

  - [yc managed-mongodb v0 cluster get](cluster/get.md) — Get information about the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster list](cluster/list.md) — List MongoDB clusters in a folder.

  - [yc managed-mongodb v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified MongoDB cluster

  - [yc managed-mongodb v0 cluster list-backups](cluster/list-backups.md) — List available backups for the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster list-logs](cluster/list-logs.md) — Retrieve logs for the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified MongoDB cluster.

  - [yc managed-mongodb v0 cluster move](cluster/move.md) — Move the specified MongoDB cluster into the folder

  - [yc managed-mongodb v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified MongoDB cluster

  - [yc managed-mongodb v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from specified MongoDB cluster

  - [yc managed-mongodb v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-mongodb v0 cluster restore](cluster/restore.md) — Restore a MongoDB cluster from a backup.

  - [yc managed-mongodb v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified MongoDB cluster and delete all existing access bindings if there were any

  - [yc managed-mongodb v0 cluster start](cluster/start.md) — Start the specified MongoDB cluster

  - [yc managed-mongodb v0 cluster stop](cluster/stop.md) — Stop the specified MongoDB cluster

  - [yc managed-mongodb v0 cluster update](cluster/update.md) — Modify configuration or attributes of a MongoDB cluster.

  - [yc managed-mongodb v0 cluster update-config](cluster/update-config.md) — Update the configuration of a MongoDB cluster.

- [yc managed-mongodb v0 database](database/index.md) — Manage MongoDB databases.

  - [yc managed-mongodb v0 database create](database/create.md) — Create a database in a MongoDB cluster.

  - [yc managed-mongodb v0 database delete](database/delete.md) — Delete a MongoDB database.

  - [yc managed-mongodb v0 database get](database/get.md) — Get information about a MongoDB database.

  - [yc managed-mongodb v0 database list](database/list.md) — List databases for a MongoDB cluster.

- [yc managed-mongodb v0 hosts](hosts/index.md) — Manage hosts of a MongoDB cluster.

  - [yc managed-mongodb v0 hosts add](hosts/add.md) — Add new hosts to the cluster in specified availability zones.

  - [yc managed-mongodb v0 hosts delete](hosts/delete.md) — Remove specified hosts from the a cluster.

  - [yc managed-mongodb v0 hosts list](hosts/list.md) — List hosts for a MongoDB cluster. Use format for additional info

  - [yc managed-mongodb v0 hosts resetup](hosts/resetup.md) — Resetup specified MongoD hosts.

  - [yc managed-mongodb v0 hosts restart](hosts/restart.md) — Restart specified MongoD hosts.

  - [yc managed-mongodb v0 hosts stepdown](hosts/stepdown.md) — Stepdown specified MongoD hosts.

  - [yc managed-mongodb v0 hosts update](hosts/update.md) — Update specified hosts in the cluster.

- [yc managed-mongodb v0 resource-preset](resource-preset/index.md) — Learn about MongoDB resource presets.

  - [yc managed-mongodb v0 resource-preset get](resource-preset/get.md) — Get information about a MongoDB resource preset.

  - [yc managed-mongodb v0 resource-preset list](resource-preset/list.md) — List available resource presets for Managed Service for MongoDB.

- [yc managed-mongodb v0 shards](shards/index.md) — Manage shards in a MongoDB cluster.

  - [yc managed-mongodb v0 shards add](shards/add.md) — Create new shard for the cluster in the specified availability zones.

  - [yc managed-mongodb v0 shards delete](shards/delete.md) — Delete a shard.

  - [yc managed-mongodb v0 shards get](shards/get.md) — Get information about a shard in a MongoDB cluster.

  - [yc managed-mongodb v0 shards list](shards/list.md) — List shards for a MongoDB cluster.

- [yc managed-mongodb v0 user](user/index.md) — Manage MongoDB users.

  - [yc managed-mongodb v0 user create](user/create.md) — Create a MongoDB user.

  - [yc managed-mongodb v0 user delete](user/delete.md) — Delete a MongoDB user.

  - [yc managed-mongodb v0 user get](user/get.md) — Get information about a MongoDB user.

  - [yc managed-mongodb v0 user grant-permission](user/grant-permission.md) — Grant a permission to the specified MongoDB user.

  - [yc managed-mongodb v0 user list](user/list.md) — List users for a MongoDB cluster.

  - [yc managed-mongodb v0 user revoke-permission](user/revoke-permission.md) — Revoke a permission from the specified MongoDB user.

  - [yc managed-mongodb v0 user update](user/update.md) — Modify attributes of a MongoDB user.

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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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