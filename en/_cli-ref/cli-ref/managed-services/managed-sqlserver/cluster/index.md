# yc managed-sqlserver cluster

Manage SQLServer clusters

#### Command Usage

Syntax: 

`yc managed-sqlserver cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-sqlserver cluster get](get.md) — Show information about the specified SQLServer cluster
- [yc managed-sqlserver cluster list](list.md) — List SQLServer clusters
- [yc managed-sqlserver cluster create](create.md) — Create SQLServer cluster
- [yc managed-sqlserver cluster restore](restore.md) — Restore SQLServer cluster
- [yc managed-sqlserver cluster start-failover](start-failover.md) — Start manual failover for the specified SQLServer cluster
- [yc managed-sqlserver cluster update](update.md) — Update the specified SQLServer cluster
- [yc managed-sqlserver cluster update-config](update-config.md) — Update the specified SQLServer cluster config
- [yc managed-sqlserver cluster add-labels](add-labels.md) — Add labels to SQLServer cluster
- [yc managed-sqlserver cluster remove-labels](remove-labels.md) — Remove labels from SQLServer cluster
- [yc managed-sqlserver cluster delete](delete.md) — Delete the specified SQLServer cluster
- [yc managed-sqlserver cluster backup](backup.md) — Create a backup for the specified SQLServer cluster
- [yc managed-sqlserver cluster list-backups](list-backups.md) — List available backups for the specified SQLServer cluster
- [yc managed-sqlserver cluster list-operations](list-operations.md) — List operations for the specified SQLServer cluster
- [yc managed-sqlserver cluster start](start.md) — Start the specified SQLServer cluster
- [yc managed-sqlserver cluster stop](stop.md) — Stop the specified SQLServer cluster

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
