# yc managed-clickhouse v0

Manage ClickHouse clusters, hosts, databases, backups, users and ml-models.

#### Command Usage

Syntax:

`yc managed-clickhouse v0 <group>`

#### Command Tree

- [yc managed-clickhouse v0 backup](backup/index.md) — Manage ClickHouse backups.

  - [yc managed-clickhouse v0 backup delete](backup/delete.md) — Delete ClickHouse backup.

  - [yc managed-clickhouse v0 backup get](backup/get.md) — Get information about a ClickHouse backup.

  - [yc managed-clickhouse v0 backup list](backup/list.md) — List ClickHouse backups available in a folder.

- [yc managed-clickhouse v0 cluster](cluster/index.md) — Manage ClickHouse clusters.

  - [yc managed-clickhouse v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified ClickHouse cluster

  - [yc managed-clickhouse v0 cluster add-extension](cluster/add-extension.md) — Add an extension to a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster add-external-dictionary](cluster/add-external-dictionary.md) — Add an external dictionary to a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster add-graphite-rollup](cluster/add-graphite-rollup.md) — Apply graphite configuration to a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster add-labels](cluster/add-labels.md) — Assign labels to a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster add-zookeeper](cluster/add-zookeeper.md) — Adds Zookeeper hosts for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster backup](cluster/backup.md) — Create a backup for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster clear-compression](cluster/clear-compression.md) — Clear compression settings for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster clear-query-masking-rules](cluster/clear-query-masking-rules.md) — Clear query masking rules settings for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster create](cluster/create.md) — Create a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster delete](cluster/delete.md) — Delete a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster get](cluster/get.md) — Get information about a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster get-extension](cluster/get-extension.md) — Get information about a ClickHouse cluster extension.

  - [yc managed-clickhouse v0 cluster list](cluster/list.md) — List ClickHouse clusters in a folder.

  - [yc managed-clickhouse v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified ClickHouse cluster

  - [yc managed-clickhouse v0 cluster list-backups](cluster/list-backups.md) — List available backups for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster list-extensions](cluster/list-extensions.md) — List extensions in a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster list-external-dictionaries](cluster/list-external-dictionaries.md) — Retrieve a list of external dictionaries that belong to ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster list-logs](cluster/list-logs.md) — Retrieve logs for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster list-operations](cluster/list-operations.md) — List operations for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster move](cluster/move.md) — Move the specified ClickHouse cluster into the folder

  - [yc managed-clickhouse v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified ClickHouse cluster

  - [yc managed-clickhouse v0 cluster remove-extension](cluster/remove-extension.md) — Remove an extension from a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster remove-external-dictionary](cluster/remove-external-dictionary.md) — Remove an external dictionary from a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster remove-graphite-rollup](cluster/remove-graphite-rollup.md) — Remove graphite rollup configuration from a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-clickhouse v0 cluster restore](cluster/restore.md) — Restore a ClickHouse cluster from a backup.

  - [yc managed-clickhouse v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified ClickHouse cluster and delete all existing access bindings if there were any

  - [yc managed-clickhouse v0 cluster set-compression](cluster/set-compression.md) — Set compression settings for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster set-query-masking-rules](cluster/set-query-masking-rules.md) — Set query masking rules settings for a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster start](cluster/start.md) — Start the specified ClickHouse cluster

  - [yc managed-clickhouse v0 cluster stop](cluster/stop.md) — Stop the specified ClickHouse cluster

  - [yc managed-clickhouse v0 cluster update](cluster/update.md) — Modify configuration or attributes of a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster update-config](cluster/update-config.md) — Update the configuration of a ClickHouse cluster.

  - [yc managed-clickhouse v0 cluster update-extension](cluster/update-extension.md) — Modify configuration or attributes of a ClickHouse cluster extension.

  - [yc managed-clickhouse v0 cluster update-external-dictionary](cluster/update-external-dictionary.md) — Update an external dictionary in a ClickHouse cluster.

- [yc managed-clickhouse v0 database](database/index.md) — Manage ClickHouse databases.

  - [yc managed-clickhouse v0 database create](database/create.md) — Create a database in a ClickHouse cluster.

  - [yc managed-clickhouse v0 database delete](database/delete.md) — Delete a ClickHouse database.

  - [yc managed-clickhouse v0 database get](database/get.md) — Get information about a ClickHouse database.

  - [yc managed-clickhouse v0 database list](database/list.md) — List databases for a ClickHouse cluster.

- [yc managed-clickhouse v0 extension](extension/index.md) — Manage available ClickHouse extensions.

  - [yc managed-clickhouse v0 extension get](extension/get.md) — Get information about a ClickHouse extension.

  - [yc managed-clickhouse v0 extension list](extension/list.md) — List available ClickHouse extensions.

- [yc managed-clickhouse v0 format-schema](format-schema/index.md) — Manage ClickHouse format schemas.

  - [yc managed-clickhouse v0 format-schema create](format-schema/create.md) — Create format schema in a ClickHouse cluster.

  - [yc managed-clickhouse v0 format-schema delete](format-schema/delete.md) — Delete ClickHouse format schema.

  - [yc managed-clickhouse v0 format-schema get](format-schema/get.md) — Get information about a ClickHouse format schema.

  - [yc managed-clickhouse v0 format-schema list](format-schema/list.md) — List format schemas in a ClickHouse cluster.

  - [yc managed-clickhouse v0 format-schema update](format-schema/update.md) — Modify configuration or attributes of a ClickHouse format schema.

- [yc managed-clickhouse v0 hosts](hosts/index.md) — Manage hosts of a ClickHouse cluster.

  - [yc managed-clickhouse v0 hosts add](hosts/add.md) — Add new hosts to the cluster in specified availability zones.

  - [yc managed-clickhouse v0 hosts delete](hosts/delete.md) — Remove specified hosts from the cluster.

  - [yc managed-clickhouse v0 hosts list](hosts/list.md) — List hosts for a ClickHouse cluster.

  - [yc managed-clickhouse v0 hosts restart](hosts/restart.md) — Restart specified hosts of the cluster.

  - [yc managed-clickhouse v0 hosts update](hosts/update.md) — Update the specified hosts

- [yc managed-clickhouse v0 ml-model](ml-model/index.md) — Manage ClickHouse machine learning models.

  - [yc managed-clickhouse v0 ml-model create](ml-model/create.md) — Create machine learning model in a ClickHouse cluster.

  - [yc managed-clickhouse v0 ml-model delete](ml-model/delete.md) — Delete ClickHouse machine learning model.

  - [yc managed-clickhouse v0 ml-model get](ml-model/get.md) — Get information about a ClickHouse machine learning model.

  - [yc managed-clickhouse v0 ml-model list](ml-model/list.md) — List machine learning models in a ClickHouse cluster.

  - [yc managed-clickhouse v0 ml-model update](ml-model/update.md) — Modify configuration or attributes of a ClickHouse machine learning model.

- [yc managed-clickhouse v0 resource-preset](resource-preset/index.md) — Learn about ClickHouse resource presets.

  - [yc managed-clickhouse v0 resource-preset get](resource-preset/get.md) — Get information about a ClickHouse resource preset.

  - [yc managed-clickhouse v0 resource-preset list](resource-preset/list.md) — List available resource presets for Managed Service for ClickHouse.

- [yc managed-clickhouse v0 shard-groups](shard-groups/index.md) — Manage shard groups in a ClickHouse cluster.

  - [yc managed-clickhouse v0 shard-groups create](shard-groups/create.md) — Create new shard group for the cluster in the specified availability zones.

  - [yc managed-clickhouse v0 shard-groups delete](shard-groups/delete.md) — Delete a shard group.

  - [yc managed-clickhouse v0 shard-groups get](shard-groups/get.md) — Get information about a shard group in a ClickHouse cluster.

  - [yc managed-clickhouse v0 shard-groups list](shard-groups/list.md) — List shard groups for a ClickHouse cluster.

  - [yc managed-clickhouse v0 shard-groups update](shard-groups/update.md) — Modify configuration or attributes of a ClickHouse shard group.

- [yc managed-clickhouse v0 shards](shards/index.md) — Manage shards in a ClickHouse cluster.

  - [yc managed-clickhouse v0 shards add](shards/add.md) — Create new shard(s) for the cluster in the specified availability zones.

  - [yc managed-clickhouse v0 shards delete](shards/delete.md) — Delete a shard.

  - [yc managed-clickhouse v0 shards get](shards/get.md) — Get information about a shard in a ClickHouse cluster.

  - [yc managed-clickhouse v0 shards list](shards/list.md) — List shards for a ClickHouse cluster.

  - [yc managed-clickhouse v0 shards update](shards/update.md) — Modify configuration or attributes of a ClickHouse shard.

  - [yc managed-clickhouse v0 shards update-config](shards/update-config.md) — Update the configurationg for a shard.

- [yc managed-clickhouse v0 user](user/index.md) — Manage ClickHouse users.

  - [yc managed-clickhouse v0 user add-quota](user/add-quota.md) — Add quota to a ClickHouse user.

  - [yc managed-clickhouse v0 user create](user/create.md) — Create a ClickHouse user.

  - [yc managed-clickhouse v0 user delete](user/delete.md) — Delete a ClickHouse user.

  - [yc managed-clickhouse v0 user get](user/get.md) — Get information about a ClickHouse user.

  - [yc managed-clickhouse v0 user grant-permission](user/grant-permission.md) — Grant a permission to a ClickHouse user.

  - [yc managed-clickhouse v0 user list](user/list.md) — List users for a ClickHouse cluster.

  - [yc managed-clickhouse v0 user remove-quota](user/remove-quota.md) — Remove quota from a ClickHouse user by interval.

  - [yc managed-clickhouse v0 user revoke-permission](user/revoke-permission.md) — Revoke a permission from a ClickHouse user.

  - [yc managed-clickhouse v0 user update](user/update.md) — Modify attributes of a ClickHouse user.

  - [yc managed-clickhouse v0 user update-quota](user/update-quota.md) — Update ClickHouse user quota by interval.

- [yc managed-clickhouse v0 version](version/index.md) — Manage available ClickHouse versions.

  - [yc managed-clickhouse v0 version list](version/list.md) — List available ClickHouse versions.

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