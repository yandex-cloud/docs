---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster

A set of methods for managing ClickHouse clusters.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster <command>`

#### Command Tree

- [yc beta managed-clickhouse cluster add-hosts](add-hosts.md) — Creates new hosts for a cluster.

- [yc beta managed-clickhouse cluster add-shard](add-shard.md) — Creates a new shard in the specified cluster.

- [yc beta managed-clickhouse cluster add-shards](add-shards.md) — Creates one or more shards in the specified cluster.

- [yc beta managed-clickhouse cluster add-zookeeper](add-zookeeper.md) — Adds a ZooKeeper subcluster to the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster backup](backup.md) — Creates a backup for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster create](create.md) — Creates a ClickHouse cluster in the specified folder.

- [yc beta managed-clickhouse cluster create-external-dictionary](create-external-dictionary.md) — Creates an external dictionary for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster create-shard-group](create-shard-group.md) — Creates a new shard group in the specified cluster.

- [yc beta managed-clickhouse cluster delete](delete.md) — Deletes the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster delete-external-dictionary](delete-external-dictionary.md) — Deletes the specified external dictionary.

- [yc beta managed-clickhouse cluster delete-hosts](delete-hosts.md) — Deletes the specified hosts for a cluster.

- [yc beta managed-clickhouse cluster delete-shard](delete-shard.md) — Deletes the specified shard.

- [yc beta managed-clickhouse cluster delete-shard-group](delete-shard-group.md) — Deletes the specified shard group.

- [yc beta managed-clickhouse cluster delete-shards](delete-shards.md) — Deletes the specified shards (one or more).

- [yc beta managed-clickhouse cluster get](get.md) — Returns the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster get-shard](get-shard.md) — Returns the specified shard.

- [yc beta managed-clickhouse cluster get-shard-group](get-shard-group.md) — Returns the specified shard group.

- [yc beta managed-clickhouse cluster list](list.md) — Retrieves a list of ClickHouse clusters that belong

- [yc beta managed-clickhouse cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster list-backups](list-backups.md) — Retrieves the list of available backups for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster list-external-dictionaries](list-external-dictionaries.md) — Retrieves a list of external dictionaries that belong to specified cluster.

- [yc beta managed-clickhouse cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified cluster.

- [yc beta managed-clickhouse cluster list-logs](list-logs.md) — Retrieves logs for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

- [yc beta managed-clickhouse cluster list-shard-groups](list-shard-groups.md) — Retrieves a list of shard groups that belong to specified cluster.

- [yc beta managed-clickhouse cluster list-shards](list-shards.md) — Retrieves a list of shards that belong to the specified cluster.

- [yc beta managed-clickhouse cluster move](move.md) — Moves a ClickHouse cluster to the specified folder.

- [yc beta managed-clickhouse cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules planned maintenance operation.

- [yc beta managed-clickhouse cluster restart-hosts](restart-hosts.md) — 

- [yc beta managed-clickhouse cluster restore](restore.md) — Creates a new ClickHouse cluster using the specified backup.

- [yc beta managed-clickhouse cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster start](start.md) — Starts the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster stop](stop.md) — Stops the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster update](update.md) — Updates the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster update-external-dictionary](update-external-dictionary.md) — Updates an external dictionary for the specified ClickHouse cluster.

- [yc beta managed-clickhouse cluster update-hosts](update-hosts.md) — Updates the specified hosts.

- [yc beta managed-clickhouse cluster update-shard](update-shard.md) — Modifies the specified shard.

- [yc beta managed-clickhouse cluster update-shard-group](update-shard-group.md) — Updates the specified shard group.

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