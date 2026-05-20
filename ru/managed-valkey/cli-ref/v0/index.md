---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-redis/cli-ref/v0/index
editable: false
---

# yc managed-redis v0

Manage Redis clusters, hosts, databases, backups and users.

#### Command Usage

Syntax:

`yc managed-redis v0 <group>`

#### Command Tree

- [yc managed-redis v0 backup](backup/index.md) — Manage Redis backups

  - [yc managed-redis v0 backup delete](backup/delete.md) — Delete Redis backup.

  - [yc managed-redis v0 backup get](backup/get.md) — Show information about the specified Redis backup

  - [yc managed-redis v0 backup list](backup/list.md) — List available backups

- [yc managed-redis v0 cluster](cluster/index.md) — Manage Redis clusters

  - [yc managed-redis v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Redis cluster

  - [yc managed-redis v0 cluster add-labels](cluster/add-labels.md) — Add labels to Redis cluster

  - [yc managed-redis v0 cluster backup](cluster/backup.md) — Create a backup for the specified Redis cluster

  - [yc managed-redis v0 cluster create](cluster/create.md) — Create Redis cluster

  - [yc managed-redis v0 cluster delete](cluster/delete.md) — Delete the specified Redis cluster

  - [yc managed-redis v0 cluster enable-sharding](cluster/enable-sharding.md) — Enable sharding on specified Redis cluster

  - [yc managed-redis v0 cluster get](cluster/get.md) — Show information about the specified Redis cluster

  - [yc managed-redis v0 cluster list](cluster/list.md) — List Redis clusters

  - [yc managed-redis v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Redis cluster

  - [yc managed-redis v0 cluster list-backups](cluster/list-backups.md) — List available backups for the specified Redis cluster

  - [yc managed-redis v0 cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Redis cluster

  - [yc managed-redis v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified Redis cluster

  - [yc managed-redis v0 cluster move](cluster/move.md) — Move the specified Redis cluster into the folder

  - [yc managed-redis v0 cluster rebalance](cluster/rebalance.md) — Rebalance the specified Redis cluster

  - [yc managed-redis v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Redis cluster

  - [yc managed-redis v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from Redis cluster

  - [yc managed-redis v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-redis v0 cluster restore](cluster/restore.md) — Restore Redis cluster

  - [yc managed-redis v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Redis cluster and delete all existing access bindings if there were any

  - [yc managed-redis v0 cluster start](cluster/start.md) — Start the specified Redis cluster

  - [yc managed-redis v0 cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified Redis cluster

  - [yc managed-redis v0 cluster stop](cluster/stop.md) — Stop the specified Redis cluster

  - [yc managed-redis v0 cluster update](cluster/update.md) — Update the specified Redis cluster

  - [yc managed-redis v0 cluster update-config](cluster/update-config.md) — Update the specified Redis cluster config

- [yc managed-redis v0 hosts](hosts/index.md) — Manage Redis cluster hosts

  - [yc managed-redis v0 hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones

  - [yc managed-redis v0 hosts delete](hosts/delete.md) — Delete the specified hosts

  - [yc managed-redis v0 hosts list](hosts/list.md) — List hosts for the specified Redis cluster

  - [yc managed-redis v0 hosts update](hosts/update.md) — Update the specified hosts

- [yc managed-redis v0 resource-preset](resource-preset/index.md) — Manage Redis resource presets

  - [yc managed-redis v0 resource-preset get](resource-preset/get.md) — Show information about the specified Redis resource preset

  - [yc managed-redis v0 resource-preset list](resource-preset/list.md) — List available Redis resource presets

- [yc managed-redis v0 shards](shards/index.md) — Manage shards in a Redis cluster.

  - [yc managed-redis v0 shards add](shards/add.md) — Create new shard for the cluster in the specified availability zones.

  - [yc managed-redis v0 shards delete](shards/delete.md) — Delete shard.

  - [yc managed-redis v0 shards get](shards/get.md) — Get information about a shard in a Redis cluster.

  - [yc managed-redis v0 shards list](shards/list.md) — List shards for a Redis cluster.

- [yc managed-redis v0 user](user/index.md) — Manage Redis users

  - [yc managed-redis v0 user create](user/create.md) — Create a Redis user

  - [yc managed-redis v0 user delete](user/delete.md) — Delete the specified Redis user

  - [yc managed-redis v0 user get](user/get.md) — Show information about the specified Redis user

  - [yc managed-redis v0 user list](user/list.md) — List users for the specified Redis cluster

  - [yc managed-redis v0 user update](user/update.md) — Update the specified Redis user

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
