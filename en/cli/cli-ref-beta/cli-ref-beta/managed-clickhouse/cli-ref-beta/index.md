---
editable: false
noIndex: true
---

# yc beta managed-clickhouse

Manage ClickHouse clusters, hosts, databases, backups, users and ml-models

#### Command Usage

Syntax:

`yc beta managed-clickhouse <group>`

#### Command Tree

- [yc beta managed-clickhouse backup](backup/index.md) — A set of methods for managing ClickHouse Backup resources.

  - [yc beta managed-clickhouse backup delete](backup/delete.md) — Deletes the specified ClickHouse Backup.

  - [yc beta managed-clickhouse backup get](backup/get.md) — Returns the specified ClickHouse Backup resource.

  - [yc beta managed-clickhouse backup list](backup/list.md) — Retrieves the list of Backup resources available for the specified folder.

- [yc beta managed-clickhouse cluster](cluster/index.md) — A set of methods for managing ClickHouse clusters.

  - [yc beta managed-clickhouse cluster add-hosts](cluster/add-hosts.md) — Creates new hosts for a cluster.

  - [yc beta managed-clickhouse cluster add-shard](cluster/add-shard.md) — Creates a new shard in the specified cluster.

  - [yc beta managed-clickhouse cluster add-shards](cluster/add-shards.md) — Creates one or more shards in the specified cluster.

  - [yc beta managed-clickhouse cluster add-zookeeper](cluster/add-zookeeper.md) — Adds a ZooKeeper subcluster to the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster backup](cluster/backup.md) — Creates a backup for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster create](cluster/create.md) — Creates a ClickHouse cluster in the specified folder.

  - [yc beta managed-clickhouse cluster create-external-dictionary](cluster/create-external-dictionary.md) — Creates an external dictionary for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster create-shard-group](cluster/create-shard-group.md) — Creates a new shard group in the specified cluster.

  - [yc beta managed-clickhouse cluster delete](cluster/delete.md) — Deletes the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster delete-external-dictionary](cluster/delete-external-dictionary.md) — Deletes the specified external dictionary.

  - [yc beta managed-clickhouse cluster delete-hosts](cluster/delete-hosts.md) — Deletes the specified hosts for a cluster.

  - [yc beta managed-clickhouse cluster delete-shard](cluster/delete-shard.md) — Deletes the specified shard.

  - [yc beta managed-clickhouse cluster delete-shard-group](cluster/delete-shard-group.md) — Deletes the specified shard group.

  - [yc beta managed-clickhouse cluster delete-shards](cluster/delete-shards.md) — Deletes the specified shards (one or more).

  - [yc beta managed-clickhouse cluster get](cluster/get.md) — Returns the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster get-shard](cluster/get-shard.md) — Returns the specified shard.

  - [yc beta managed-clickhouse cluster get-shard-group](cluster/get-shard-group.md) — Returns the specified shard group.

  - [yc beta managed-clickhouse cluster list](cluster/list.md) — Retrieves a list of ClickHouse clusters that belong

  - [yc beta managed-clickhouse cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster list-backups](cluster/list-backups.md) — Retrieves the list of available backups for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster list-external-dictionaries](cluster/list-external-dictionaries.md) — Retrieves a list of external dictionaries that belong to specified cluster.

  - [yc beta managed-clickhouse cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified cluster.

  - [yc beta managed-clickhouse cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-clickhouse cluster list-shard-groups](cluster/list-shard-groups.md) — Retrieves a list of shard groups that belong to specified cluster.

  - [yc beta managed-clickhouse cluster list-shards](cluster/list-shards.md) — Retrieves a list of shards that belong to the specified cluster.

  - [yc beta managed-clickhouse cluster move](cluster/move.md) — Moves a ClickHouse cluster to the specified folder.

  - [yc beta managed-clickhouse cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules planned maintenance operation.

  - [yc beta managed-clickhouse cluster restart-hosts](cluster/restart-hosts.md) — 

  - [yc beta managed-clickhouse cluster restore](cluster/restore.md) — Creates a new ClickHouse cluster using the specified backup.

  - [yc beta managed-clickhouse cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster start](cluster/start.md) — Starts the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster stop](cluster/stop.md) — Stops the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster update](cluster/update.md) — Updates the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster update-external-dictionary](cluster/update-external-dictionary.md) — Updates an external dictionary for the specified ClickHouse cluster.

  - [yc beta managed-clickhouse cluster update-hosts](cluster/update-hosts.md) — Updates the specified hosts.

  - [yc beta managed-clickhouse cluster update-shard](cluster/update-shard.md) — Modifies the specified shard.

  - [yc beta managed-clickhouse cluster update-shard-group](cluster/update-shard-group.md) — Updates the specified shard group.

- [yc beta managed-clickhouse cluster-extension](cluster-extension/index.md) — 

  - [yc beta managed-clickhouse cluster-extension create](cluster-extension/create.md) — 

  - [yc beta managed-clickhouse cluster-extension delete](cluster-extension/delete.md) — 

  - [yc beta managed-clickhouse cluster-extension get](cluster-extension/get.md) — 

  - [yc beta managed-clickhouse cluster-extension list](cluster-extension/list.md) — 

  - [yc beta managed-clickhouse cluster-extension set-extensions](cluster-extension/set-extensions.md) — Set the list of cluster extensions. Not specified extensions will be deleted.

  - [yc beta managed-clickhouse cluster-extension update](cluster-extension/update.md) — 

- [yc beta managed-clickhouse database](database/index.md) — A set of methods for managing ClickHouse Database resources.

  - [yc beta managed-clickhouse database create](database/create.md) — Creates a new ClickHouse database in the specified cluster.

  - [yc beta managed-clickhouse database delete](database/delete.md) — Deletes the specified ClickHouse database.

  - [yc beta managed-clickhouse database get](database/get.md) — Returns the specified ClickHouse Database resource.

  - [yc beta managed-clickhouse database list](database/list.md) — Retrieves the list of ClickHouse Database resources in the specified cluster.

- [yc beta managed-clickhouse extension](extension/index.md) — 

  - [yc beta managed-clickhouse extension get](extension/get.md) — 

  - [yc beta managed-clickhouse extension list](extension/list.md) — 

- [yc beta managed-clickhouse format-schema](format-schema/index.md) — A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data.

  - [yc beta managed-clickhouse format-schema create](format-schema/create.md) — Adds a format schema to a cluster.

  - [yc beta managed-clickhouse format-schema delete](format-schema/delete.md) — Deletes a format schema from a cluster.

  - [yc beta managed-clickhouse format-schema get](format-schema/get.md) — Returns detailed information about a given format schema.

  - [yc beta managed-clickhouse format-schema list](format-schema/list.md) — Returns a list of format schemas in a cluster.

  - [yc beta managed-clickhouse format-schema update](format-schema/update.md) — Changes a format schema.

- [yc beta managed-clickhouse ml-model](ml-model/index.md) — A set of methods for managing machine learning models.

  - [yc beta managed-clickhouse ml-model create](ml-model/create.md) — Creates a machine learning model in the specified cluster.

  - [yc beta managed-clickhouse ml-model delete](ml-model/delete.md) — Deletes the specified machine learning model.

  - [yc beta managed-clickhouse ml-model get](ml-model/get.md) — Returns the specified machine learning model.

  - [yc beta managed-clickhouse ml-model list](ml-model/list.md) — Retrieves the list of machine learning models in the specified cluster.

  - [yc beta managed-clickhouse ml-model update](ml-model/update.md) — Updates the specified machine learning model.

- [yc beta managed-clickhouse resource-preset](resource-preset/index.md) — A set of methods for managing ResourcePreset resources.

  - [yc beta managed-clickhouse resource-preset get](resource-preset/get.md) — Returns the specified ResourcePreset resource.

  - [yc beta managed-clickhouse resource-preset list](resource-preset/list.md) — Retrieves the list of available ResourcePreset resources.

- [yc beta managed-clickhouse user](user/index.md) — A set of methods for managing ClickHouse User resources.

  - [yc beta managed-clickhouse user create](user/create.md) — Creates a ClickHouse user in the specified cluster.

  - [yc beta managed-clickhouse user delete](user/delete.md) — Deletes the specified ClickHouse user.

  - [yc beta managed-clickhouse user get](user/get.md) — Returns the specified ClickHouse User resource.

  - [yc beta managed-clickhouse user grant-permission](user/grant-permission.md) — Grants a permission to the specified ClickHouse user.

  - [yc beta managed-clickhouse user list](user/list.md) — Retrieves the list of ClickHouse User resources in the specified cluster.

  - [yc beta managed-clickhouse user revoke-permission](user/revoke-permission.md) — Revokes a permission from the specified ClickHouse user.

  - [yc beta managed-clickhouse user update](user/update.md) — Updates the specified ClickHouse user.

- [yc beta managed-clickhouse versions](versions/index.md) — A set of methods for managing ClickHouse versions.

  - [yc beta managed-clickhouse versions list](versions/list.md) — Returns list of available ClickHouse versions.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#