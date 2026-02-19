---
editable: false
noIndex: true
---

# yc beta managed-redis cluster

A set of methods for managing Redis clusters.

#### Command Usage

Syntax:

`yc beta managed-redis cluster <command>`

#### Command Tree

- [yc beta managed-redis cluster add-hosts](add-hosts.md) — Creates new hosts for a cluster.

- [yc beta managed-redis cluster add-shard](add-shard.md) — Creates a new shard.

- [yc beta managed-redis cluster backup](backup.md) — Creates a backup for the specified Redis cluster.

- [yc beta managed-redis cluster create](create.md) — Creates a Redis cluster in the specified folder.

- [yc beta managed-redis cluster delete](delete.md) — Deletes the specified Redis cluster.

- [yc beta managed-redis cluster delete-hosts](delete-hosts.md) — Deletes the specified hosts for a cluster.

- [yc beta managed-redis cluster delete-shard](delete-shard.md) — Deletes the specified shard.

- [yc beta managed-redis cluster enable-sharding](enable-sharding.md) — Enable Sharding on non sharded cluster

- [yc beta managed-redis cluster get](get.md) — Returns the specified Redis cluster.

- [yc beta managed-redis cluster get-shard](get-shard.md) — Returns the specified shard.

- [yc beta managed-redis cluster list](list.md) — Retrieves the list of Redis clusters that belong

- [yc beta managed-redis cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Redis cluster.

- [yc beta managed-redis cluster list-backups](list-backups.md) — Retrieves the list of available backups for the specified Redis cluster.

- [yc beta managed-redis cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified cluster.

- [yc beta managed-redis cluster list-logs](list-logs.md) — Retrieves logs for the specified Redis cluster.

- [yc beta managed-redis cluster list-operations](list-operations.md) — Retrieves the list of operations for the specified cluster.

- [yc beta managed-redis cluster list-shards](list-shards.md) — Retrieves a list of shards.

- [yc beta managed-redis cluster move](move.md) — Moves a Redis cluster to the specified folder.

- [yc beta managed-redis cluster rebalance](rebalance.md) — Rebalances the cluster. Evenly distributes all the hash slots between the shards.

- [yc beta managed-redis cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules planned maintenance operation.

- [yc beta managed-redis cluster restore](restore.md) — Creates a new Redis cluster using the specified backup.

- [yc beta managed-redis cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Redis cluster.

- [yc beta managed-redis cluster start](start.md) — Start the specified Redis cluster.

- [yc beta managed-redis cluster start-failover](start-failover.md) — Start a manual failover on the specified Redis cluster.

- [yc beta managed-redis cluster stop](stop.md) — Stop the specified Redis cluster.

- [yc beta managed-redis cluster update](update.md) — Updates the specified Redis cluster.

- [yc beta managed-redis cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Redis cluster.

- [yc beta managed-redis cluster update-hosts](update-hosts.md) — Updates the specified hosts.

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