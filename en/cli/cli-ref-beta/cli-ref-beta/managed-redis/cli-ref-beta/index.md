---
editable: false
noIndex: true
---

# yc beta managed-redis

Manage Redis clusters, hosts, databases, backups and users

#### Command Usage

Syntax:

`yc beta managed-redis <group>`

#### Command Tree

- [yc beta managed-redis backup](backup/index.md) — A set of methods for managing Redis backups.

  - [yc beta managed-redis backup delete](backup/delete.md) — Returns the list of available backups for the specified Redis cluster.

  - [yc beta managed-redis backup get](backup/get.md) — Returns the specified Redis backup.

  - [yc beta managed-redis backup list](backup/list.md) — Retrieves the list of Redis backups available for the specified folder.

- [yc beta managed-redis cluster](cluster/index.md) — A set of methods for managing Redis clusters.

  - [yc beta managed-redis cluster add-hosts](cluster/add-hosts.md) — Creates new hosts for a cluster.

  - [yc beta managed-redis cluster add-shard](cluster/add-shard.md) — Creates a new shard.

  - [yc beta managed-redis cluster backup](cluster/backup.md) — Creates a backup for the specified Redis cluster.

  - [yc beta managed-redis cluster create](cluster/create.md) — Creates a Redis cluster in the specified folder.

  - [yc beta managed-redis cluster delete](cluster/delete.md) — Deletes the specified Redis cluster.

  - [yc beta managed-redis cluster delete-hosts](cluster/delete-hosts.md) — Deletes the specified hosts for a cluster.

  - [yc beta managed-redis cluster delete-shard](cluster/delete-shard.md) — Deletes the specified shard.

  - [yc beta managed-redis cluster enable-sharding](cluster/enable-sharding.md) — Enable Sharding on non sharded cluster

  - [yc beta managed-redis cluster get](cluster/get.md) — Returns the specified Redis cluster.

  - [yc beta managed-redis cluster get-shard](cluster/get-shard.md) — Returns the specified shard.

  - [yc beta managed-redis cluster list](cluster/list.md) — Retrieves the list of Redis clusters that belong

  - [yc beta managed-redis cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Redis cluster.

  - [yc beta managed-redis cluster list-backups](cluster/list-backups.md) — Retrieves the list of available backups for the specified Redis cluster.

  - [yc beta managed-redis cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified cluster.

  - [yc beta managed-redis cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Redis cluster.

  - [yc beta managed-redis cluster list-operations](cluster/list-operations.md) — Retrieves the list of operations for the specified cluster.

  - [yc beta managed-redis cluster list-shards](cluster/list-shards.md) — Retrieves a list of shards.

  - [yc beta managed-redis cluster move](cluster/move.md) — Moves a Redis cluster to the specified folder.

  - [yc beta managed-redis cluster rebalance](cluster/rebalance.md) — Rebalances the cluster. Evenly distributes all the hash slots between the shards.

  - [yc beta managed-redis cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules planned maintenance operation.

  - [yc beta managed-redis cluster restore](cluster/restore.md) — Creates a new Redis cluster using the specified backup.

  - [yc beta managed-redis cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Redis cluster.

  - [yc beta managed-redis cluster start](cluster/start.md) — Start the specified Redis cluster.

  - [yc beta managed-redis cluster start-failover](cluster/start-failover.md) — Start a manual failover on the specified Redis cluster.

  - [yc beta managed-redis cluster stop](cluster/stop.md) — Stop the specified Redis cluster.

  - [yc beta managed-redis cluster update](cluster/update.md) — Updates the specified Redis cluster.

  - [yc beta managed-redis cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Redis cluster.

  - [yc beta managed-redis cluster update-hosts](cluster/update-hosts.md) — Updates the specified hosts.

- [yc beta managed-redis resource-preset](resource-preset/index.md) — A set of methods for working with resource presets.

  - [yc beta managed-redis resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta managed-redis resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

- [yc beta managed-redis user](user/index.md) — A set of methods for managing Redis User resources.

  - [yc beta managed-redis user create](user/create.md) — Creates a Redis user in the specified cluster.

  - [yc beta managed-redis user delete](user/delete.md) — Deletes the specified Redis user.

  - [yc beta managed-redis user get](user/get.md) — Returns the specified Redis User resource.

  - [yc beta managed-redis user list](user/list.md) — Retrieves the list of Redis User resources in the specified cluster.

  - [yc beta managed-redis user update](user/update.md) — Updates the specified Redis user.

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