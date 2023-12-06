---
editable: false
---

# yc managed-mongodb cluster

Manage MongoDB clusters.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-mongodb cluster get](get.md) — Get information about the specified MongoDB cluster.
- [yc managed-mongodb cluster list](list.md) — List MongoDB clusters in a folder.
- [yc managed-mongodb cluster create](create.md) — Create a MongoDB cluster.
- [yc managed-mongodb cluster restore](restore.md) — Restore a MongoDB cluster from a backup.
- [yc managed-mongodb cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
- [yc managed-mongodb cluster update](update.md) — Modify configuration or attributes of a MongoDB cluster.
- [yc managed-mongodb cluster update-config](update-config.md) — Update the configuration of a MongoDB cluster.
- [yc managed-mongodb cluster add-labels](add-labels.md) — Assign labels to a MongoDB cluster.
- [yc managed-mongodb cluster remove-labels](remove-labels.md) — Remove labels from specified MongoDB cluster
- [yc managed-mongodb cluster delete](delete.md) — Delete the specified MongoDB cluster.
- [yc managed-mongodb cluster backup](backup.md) — Create a backup for the specified MongoDB cluster.
- [yc managed-mongodb cluster list-backups](list-backups.md) — List available backups for the specified MongoDB cluster.
- [yc managed-mongodb cluster list-logs](list-logs.md) — Retrieve logs for the specified MongoDB cluster.
- [yc managed-mongodb cluster list-operations](list-operations.md) — List operations for the specified MongoDB cluster.
- [yc managed-mongodb cluster move](move.md) — Move the specified MongoDB cluster into the folder
- [yc managed-mongodb cluster start](start.md) — Start the specified MongoDB cluster
- [yc managed-mongodb cluster stop](stop.md) — Stop the specified MongoDB cluster
- [yc managed-mongodb cluster enable-sharding](enable-sharding.md) — Enable sharding for MongoDB cluster.

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
|`-h`,`--help`|Display help for the command.|
