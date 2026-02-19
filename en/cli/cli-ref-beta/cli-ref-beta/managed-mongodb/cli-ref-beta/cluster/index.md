---
editable: false
noIndex: true
---

# yc beta managed-mongodb cluster

A set of methods for managing MongoDB Cluster resources.

#### Command Usage

Syntax:

`yc beta managed-mongodb cluster <command>`

#### Command Tree

- [yc beta managed-mongodb cluster add-hosts](add-hosts.md) — Creates new hosts for a cluster.

- [yc beta managed-mongodb cluster add-shard](add-shard.md) — Creates a new shard.

- [yc beta managed-mongodb cluster backup](backup.md) — Creates a backup for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster create](create.md) — Creates a MongoDB cluster in the specified folder.

- [yc beta managed-mongodb cluster delete](delete.md) — Deletes the specified MongoDB cluster.

- [yc beta managed-mongodb cluster delete-hosts](delete-hosts.md) — Deletes the specified hosts for a cluster.

- [yc beta managed-mongodb cluster delete-shard](delete-shard.md) — Deletes the specified shard.

- [yc beta managed-mongodb cluster enable-sharding](enable-sharding.md) — Enables sharding for the cluster:

- [yc beta managed-mongodb cluster get](get.md) — Returns the specified MongoDB Cluster resource.

- [yc beta managed-mongodb cluster get-shard](get-shard.md) — Returns the specified shard.

- [yc beta managed-mongodb cluster list](list.md) — Retrieves the list of MongoDB Cluster resources that belong

- [yc beta managed-mongodb cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster list-backups](list-backups.md) — Retrieves the list of available backups for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified cluster.

- [yc beta managed-mongodb cluster list-logs](list-logs.md) — Retrieves logs for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

- [yc beta managed-mongodb cluster list-shards](list-shards.md) — Retrieves a list of shards.

- [yc beta managed-mongodb cluster move](move.md) — Moves the specified MongoDB cluster to the specified folder.

- [yc beta managed-mongodb cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules planned maintenance operation.

- [yc beta managed-mongodb cluster resetup-hosts](resetup-hosts.md) — Resetups hosts.

- [yc beta managed-mongodb cluster restart-hosts](restart-hosts.md) — Restarts hosts.

- [yc beta managed-mongodb cluster restore](restore.md) — Creates a new MongoDB cluster using the specified backup.

- [yc beta managed-mongodb cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster start](start.md) — Start the specified MongoDB cluster.

- [yc beta managed-mongodb cluster stepdown-hosts](stepdown-hosts.md) — Stepdown hosts.

- [yc beta managed-mongodb cluster stop](stop.md) — Stop the specified MongoDB cluster.

- [yc beta managed-mongodb cluster update](update.md) — Updates the specified MongoDB cluster.

- [yc beta managed-mongodb cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified MongoDB cluster.

- [yc beta managed-mongodb cluster update-hosts](update-hosts.md) — Updates the specified parameters for the host.

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