---
editable: false
noIndex: true
---

# yc beta managed-mongodb

Manage MongoDB clusters, hosts, databases, backups and users

#### Command Usage

Syntax:

`yc beta managed-mongodb <group>`

#### Command Tree

- [yc beta managed-mongodb backup](backup/index.md) — A set of methods for managing MongoDB Backup resources.

  - [yc beta managed-mongodb backup delete](backup/delete.md) — Returns the list of available backups for the specified MongoDB cluster.

  - [yc beta managed-mongodb backup get](backup/get.md) — Returns the specified MongoDB backup.

  - [yc beta managed-mongodb backup list](backup/list.md) — Retrieves the list of backups available for the specified folder.

- [yc beta managed-mongodb cluster](cluster/index.md) — A set of methods for managing MongoDB Cluster resources.

  - [yc beta managed-mongodb cluster add-hosts](cluster/add-hosts.md) — Creates new hosts for a cluster.

  - [yc beta managed-mongodb cluster add-shard](cluster/add-shard.md) — Creates a new shard.

  - [yc beta managed-mongodb cluster backup](cluster/backup.md) — Creates a backup for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster create](cluster/create.md) — Creates a MongoDB cluster in the specified folder.

  - [yc beta managed-mongodb cluster delete](cluster/delete.md) — Deletes the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster delete-hosts](cluster/delete-hosts.md) — Deletes the specified hosts for a cluster.

  - [yc beta managed-mongodb cluster delete-shard](cluster/delete-shard.md) — Deletes the specified shard.

  - [yc beta managed-mongodb cluster enable-sharding](cluster/enable-sharding.md) — Enables sharding for the cluster:

  - [yc beta managed-mongodb cluster get](cluster/get.md) — Returns the specified MongoDB Cluster resource.

  - [yc beta managed-mongodb cluster get-shard](cluster/get-shard.md) — Returns the specified shard.

  - [yc beta managed-mongodb cluster list](cluster/list.md) — Retrieves the list of MongoDB Cluster resources that belong

  - [yc beta managed-mongodb cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster list-backups](cluster/list-backups.md) — Retrieves the list of available backups for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified cluster.

  - [yc beta managed-mongodb cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-mongodb cluster list-shards](cluster/list-shards.md) — Retrieves a list of shards.

  - [yc beta managed-mongodb cluster move](cluster/move.md) — Moves the specified MongoDB cluster to the specified folder.

  - [yc beta managed-mongodb cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules planned maintenance operation.

  - [yc beta managed-mongodb cluster resetup-hosts](cluster/resetup-hosts.md) — Resetups hosts.

  - [yc beta managed-mongodb cluster restart-hosts](cluster/restart-hosts.md) — Restarts hosts.

  - [yc beta managed-mongodb cluster restore](cluster/restore.md) — Creates a new MongoDB cluster using the specified backup.

  - [yc beta managed-mongodb cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster start](cluster/start.md) — Start the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster stepdown-hosts](cluster/stepdown-hosts.md) — Stepdown hosts.

  - [yc beta managed-mongodb cluster stop](cluster/stop.md) — Stop the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster update](cluster/update.md) — Updates the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified MongoDB cluster.

  - [yc beta managed-mongodb cluster update-hosts](cluster/update-hosts.md) — Updates the specified parameters for the host.

- [yc beta managed-mongodb database](database/index.md) — A set of methods for managing MongoDB Database resources.

  - [yc beta managed-mongodb database create](database/create.md) — Creates a new MongoDB database in the specified cluster.

  - [yc beta managed-mongodb database delete](database/delete.md) — Deletes the specified MongoDB database.

  - [yc beta managed-mongodb database get](database/get.md) — Returns the specified MongoDB Database resource.

  - [yc beta managed-mongodb database list](database/list.md) — Retrieves the list of MongoDB Database resources in the specified cluster.

- [yc beta managed-mongodb resource-preset](resource-preset/index.md) — A set of methods for managing ResourcePreset resources.

  - [yc beta managed-mongodb resource-preset get](resource-preset/get.md) — Returns the specified ResourcePreset resource.

  - [yc beta managed-mongodb resource-preset list](resource-preset/list.md) — Retrieves the list of available ResourcePreset resources.

- [yc beta managed-mongodb user](user/index.md) — A set of methods for managing MongoDB User resources.

  - [yc beta managed-mongodb user create](user/create.md) — Creates a MongoDB user in the specified cluster.

  - [yc beta managed-mongodb user delete](user/delete.md) — Deletes the specified MongoDB user.

  - [yc beta managed-mongodb user get](user/get.md) — Returns the specified MongoDB User resource.

  - [yc beta managed-mongodb user grant-permission](user/grant-permission.md) — Grants permission to the specified MongoDB user.

  - [yc beta managed-mongodb user list](user/list.md) — Retrieves the list of MongoDB User resources in the specified cluster.

  - [yc beta managed-mongodb user revoke-permission](user/revoke-permission.md) — Revokes permission from the specified MongoDB user.

  - [yc beta managed-mongodb user update](user/update.md) — Updates the specified MongoDB user.

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