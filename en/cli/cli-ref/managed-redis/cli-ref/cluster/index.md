---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-redis/cli-ref/cluster/index.md
---

# yc managed-redis cluster

Manage Redis clusters

#### Command Usage

Syntax: 

`yc managed-redis cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-redis cluster add-labels](add-labels.md) — Add labels to Redis cluster
- [yc managed-redis cluster backup](backup.md) — Create a backup for the specified Redis cluster
- [yc managed-redis cluster create](create.md) — Create Redis cluster
- [yc managed-redis cluster delete](delete.md) — Delete the specified Redis cluster
- [yc managed-redis cluster enable-sharding](enable-sharding.md) — Enable sharding on specified Redis cluster
- [yc managed-redis cluster get](get.md) — Show information about the specified Redis cluster
- [yc managed-redis cluster list](list.md) — List Redis clusters
- [yc managed-redis cluster list-backups](list-backups.md) — List available backups for the specified Redis cluster
- [yc managed-redis cluster list-logs](list-logs.md) — Retrieves logs for the specified Redis cluster
- [yc managed-redis cluster list-operations](list-operations.md) — List operations for the specified Redis cluster
- [yc managed-redis cluster move](move.md) — Move the specified Redis cluster into the folder
- [yc managed-redis cluster rebalance](rebalance.md) — Rebalance the specified Redis cluster
- [yc managed-redis cluster remove-labels](remove-labels.md) — Remove labels from Redis cluster
- [yc managed-redis cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
- [yc managed-redis cluster restore](restore.md) — Restore Redis cluster
- [yc managed-redis cluster start](start.md) — Start the specified Redis cluster
- [yc managed-redis cluster start-failover](start-failover.md) — Start manual failover for the specified Redis cluster
- [yc managed-redis cluster stop](stop.md) — Stop the specified Redis cluster
- [yc managed-redis cluster update](update.md) — Update the specified Redis cluster
- [yc managed-redis cluster update-config](update-config.md) — Update the specified Redis cluster config

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
