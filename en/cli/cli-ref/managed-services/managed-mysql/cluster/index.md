---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-mysql/cluster/index.md
---

# yc managed-mysql cluster

Manage MySQL clusters

#### Command Usage

Syntax: 

`yc managed-mysql cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-mysql cluster get](get.md) — Show information about the specified MySQL cluster
- [yc managed-mysql cluster list](list.md) — List MySQL clusters
- [yc managed-mysql cluster create](create.md) — Create MySQL cluster
- [yc managed-mysql cluster restore](restore.md) — Restore MySQL cluster
- [yc managed-mysql cluster start-failover](start-failover.md) — Start manual failover for the specified MySQL cluster
- [yc managed-mysql cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
- [yc managed-mysql cluster update](update.md) — Update the specified MySQL cluster
- [yc managed-mysql cluster update-config](update-config.md) — Update the specified MySQL cluster config
- [yc managed-mysql cluster add-labels](add-labels.md) — Add labels to MySQL cluster
- [yc managed-mysql cluster remove-labels](remove-labels.md) — Remove labels from MySQL cluster
- [yc managed-mysql cluster delete](delete.md) — Delete the specified MySQL cluster
- [yc managed-mysql cluster backup](backup.md) — Create a backup for the specified MySQL cluster
- [yc managed-mysql cluster list-backups](list-backups.md) — List available backups for the specified MySQL cluster
- [yc managed-mysql cluster list-logs](list-logs.md) — Retrieves logs for the specified MySQL cluster
- [yc managed-mysql cluster list-operations](list-operations.md) — List operations for the specified MySQL cluster
- [yc managed-mysql cluster move](move.md) — Move the specified MySQL cluster into the folder
- [yc managed-mysql cluster start](start.md) — Start the specified MySQL cluster
- [yc managed-mysql cluster stop](stop.md) — Stop the specified MySQL cluster

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
