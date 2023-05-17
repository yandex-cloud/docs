---
editable: false
---

# yc managed-clickhouse cluster

Manage ClickHouse clusters.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-clickhouse cluster get](get.md) — Get information about a ClickHouse cluster.
- [yc managed-clickhouse cluster list](list.md) — List ClickHouse clusters in a folder.
- [yc managed-clickhouse cluster create](create.md) — Create a ClickHouse cluster.
- [yc managed-clickhouse cluster restore](restore.md) — Restore a ClickHouse cluster from a backup.
- [yc managed-clickhouse cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
- [yc managed-clickhouse cluster update](update.md) — Modify configuration or attributes of a ClickHouse cluster.
- [yc managed-clickhouse cluster update-config](update-config.md) — Update the configuration of a ClickHouse cluster.
- [yc managed-clickhouse cluster add-labels](add-labels.md) — Assign labels to a ClickHouse cluster.
- [yc managed-clickhouse cluster remove-labels](remove-labels.md) — Remove labels from a ClickHouse cluster.
- [yc managed-clickhouse cluster delete](delete.md) — Delete a ClickHouse cluster.
- [yc managed-clickhouse cluster add-zookeeper](add-zookeeper.md) — Adds Zookeeper hosts for a ClickHouse cluster.
- [yc managed-clickhouse cluster backup](backup.md) — Create a backup for a ClickHouse cluster.
- [yc managed-clickhouse cluster list-backups](list-backups.md) — List available backups for a ClickHouse cluster.
- [yc managed-clickhouse cluster list-logs](list-logs.md) — Retrieve logs for a ClickHouse cluster.
- [yc managed-clickhouse cluster list-operations](list-operations.md) — List operations for a ClickHouse cluster.
- [yc managed-clickhouse cluster clear-compression](clear-compression.md) — Clear compression settings for a ClickHouse cluster.
- [yc managed-clickhouse cluster set-compression](set-compression.md) — Set compression settings for a ClickHouse cluster.
- [yc managed-clickhouse cluster list-external-dictionaries](list-external-dictionaries.md) — Retrieve a list of external dictionaries that belong to ClickHouse cluster.
- [yc managed-clickhouse cluster add-external-dictionary](add-external-dictionary.md) — Add an external dictionary to a ClickHouse cluster.
- [yc managed-clickhouse cluster remove-external-dictionary](remove-external-dictionary.md) — Remove an external dictionary from a ClickHouse cluster.
- [yc managed-clickhouse cluster add-graphite-rollup](add-graphite-rollup.md) — Apply graphite configuration to a ClickHouse cluster.
- [yc managed-clickhouse cluster remove-graphite-rollup](remove-graphite-rollup.md) — Remove graphite rollup configuration from a ClickHouse cluster.
- [yc managed-clickhouse cluster move](move.md) — Move the specified ClickHouse cluster into the folder
- [yc managed-clickhouse cluster start](start.md) — Start the specified ClickHouse cluster
- [yc managed-clickhouse cluster stop](stop.md) — Stop the specified ClickHouse cluster

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
