---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-sqlserver/index.md
---

# yc managed-sqlserver

Manage SQLServer clusters, databases, backups and users.

#### Command Usage

Syntax: 

`yc managed-sqlserver <group>`

Aliases: 

- `sqlserver`

#### Command Tree

- [yc managed-sqlserver cluster](cluster/index.md) — Manage SQLServer clusters
	- [yc managed-sqlserver cluster get](cluster/get.md) — Show information about the specified SQLServer cluster
	- [yc managed-sqlserver cluster list](cluster/list.md) — List SQLServer clusters
	- [yc managed-sqlserver cluster create](cluster/create.md) — Create SQLServer cluster
	- [yc managed-sqlserver cluster restore](cluster/restore.md) — Restore SQLServer cluster
	- [yc managed-sqlserver cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified SQLServer cluster
	- [yc managed-sqlserver cluster update](cluster/update.md) — Update the specified SQLServer cluster
	- [yc managed-sqlserver cluster update-config](cluster/update-config.md) — Update the specified SQLServer cluster config
	- [yc managed-sqlserver cluster add-labels](cluster/add-labels.md) — Add labels to SQLServer cluster
	- [yc managed-sqlserver cluster remove-labels](cluster/remove-labels.md) — Remove labels from SQLServer cluster
	- [yc managed-sqlserver cluster delete](cluster/delete.md) — Delete the specified SQLServer cluster
	- [yc managed-sqlserver cluster backup](cluster/backup.md) — Create a backup for the specified SQLServer cluster
	- [yc managed-sqlserver cluster list-backups](cluster/list-backups.md) — List available backups for the specified SQLServer cluster
	- [yc managed-sqlserver cluster list-operations](cluster/list-operations.md) — List operations for the specified SQLServer cluster
	- [yc managed-sqlserver cluster start](cluster/start.md) — Start the specified SQLServer cluster
	- [yc managed-sqlserver cluster stop](cluster/stop.md) — Stop the specified SQLServer cluster
- [yc managed-sqlserver host](host/index.md) — Manage SQLServer cluster hosts
	- [yc managed-sqlserver host list](host/list.md) — List hosts for the specified SQLServer cluster
	- [yc managed-sqlserver host update](host/update.md) — Update the specified hosts
- [yc managed-sqlserver database](database/index.md) — Manage SQLServer databases
	- [yc managed-sqlserver database get](database/get.md) — Show information about the specified SQLServer database
	- [yc managed-sqlserver database list](database/list.md) — List SQLServer databases
	- [yc managed-sqlserver database create](database/create.md) — Create SQLServer database
	- [yc managed-sqlserver database restore](database/restore.md) — Restore SQLServer database
	- [yc managed-sqlserver database backup-export](database/backup-export.md) — Export SQLServer database backup to Object Storage
	- [yc managed-sqlserver database backup-import](database/backup-import.md) — Import SQLServer database from external backup in Object Storage
	- [yc managed-sqlserver database delete](database/delete.md) — Delete the specified SQLServer database
- [yc managed-sqlserver user](user/index.md) — Manage SQLServer users
	- [yc managed-sqlserver user get](user/get.md) — Show information about the specified SQLServer user
	- [yc managed-sqlserver user list](user/list.md) — List users for the specified SQLServer cluster
	- [yc managed-sqlserver user create](user/create.md) — Create a SQLServer user
	- [yc managed-sqlserver user update](user/update.md) — Update the specified SQLServer user
	- [yc managed-sqlserver user delete](user/delete.md) — Delete the specified SQLServer user
	- [yc managed-sqlserver user grant-permission](user/grant-permission.md) — Grant database access to the specified SQLServer user
	- [yc managed-sqlserver user revoke-permission](user/revoke-permission.md) — Revoke database access from the specified SQLServer user
- [yc managed-sqlserver backup](backup/index.md) — Manage SQLServer backups
	- [yc managed-sqlserver backup get](backup/get.md) — Show information about the specified SQLServer backup
	- [yc managed-sqlserver backup list](backup/list.md) — List available backups
- [yc managed-sqlserver resource-preset](resource-preset/index.md) — Manage SQLServer resource presets
	- [yc managed-sqlserver resource-preset get](resource-preset/get.md) — Show information about the specified SQLServer resource preset
	- [yc managed-sqlserver resource-preset list](resource-preset/list.md) — List available SQLServer resource presets.

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
