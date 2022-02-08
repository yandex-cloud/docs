# yc managed-mysql

Manage MySQL clusters, hosts, databases, backups and users.

#### Command Usage

Syntax: 

`yc managed-mysql <group>`

Aliases: 

- `mysql`

#### Command Tree

- [yc managed-mysql cluster](cluster/index.md) — Manage MySQL clusters
	- [yc managed-mysql cluster get](cluster/get.md) — Show information about the specified MySQL cluster
	- [yc managed-mysql cluster list](cluster/list.md) — List MySQL clusters
	- [yc managed-mysql cluster create](cluster/create.md) — Create MySQL cluster
	- [yc managed-mysql cluster restore](cluster/restore.md) — Restore MySQL cluster
	- [yc managed-mysql cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified MySQL cluster
	- [yc managed-mysql cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
	- [yc managed-mysql cluster update](cluster/update.md) — Update the specified MySQL cluster
	- [yc managed-mysql cluster update-config](cluster/update-config.md) — Update the specified MySQL cluster config
	- [yc managed-mysql cluster add-labels](cluster/add-labels.md) — Add labels to MySQL cluster
	- [yc managed-mysql cluster remove-labels](cluster/remove-labels.md) — Remove labels from MySQL cluster
	- [yc managed-mysql cluster delete](cluster/delete.md) — Delete the specified MySQL cluster
	- [yc managed-mysql cluster backup](cluster/backup.md) — Create a backup for the specified MySQL cluster
	- [yc managed-mysql cluster list-backups](cluster/list-backups.md) — List available backups for the specified MySQL cluster
	- [yc managed-mysql cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified MySQL cluster
	- [yc managed-mysql cluster list-operations](cluster/list-operations.md) — List operations for the specified MySQL cluster
	- [yc managed-mysql cluster move](cluster/move.md) — Move the specified MySQL cluster into the folder
	- [yc managed-mysql cluster start](cluster/start.md) — Start the specified MySQL cluster
	- [yc managed-mysql cluster stop](cluster/stop.md) — Stop the specified MySQL cluster
- [yc managed-mysql hosts](hosts/index.md) — Manage MySQL cluster hosts
	- [yc managed-mysql hosts list](hosts/list.md) — List hosts for the specified MySQL cluster
	- [yc managed-mysql hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones
	- [yc managed-mysql hosts update](hosts/update.md) — Update the specified hosts
	- [yc managed-mysql hosts delete](hosts/delete.md) — Delete the specified hosts
- [yc managed-mysql database](database/index.md) — Manage MySQL databases
	- [yc managed-mysql database get](database/get.md) — Show information about the specified MySQL database
	- [yc managed-mysql database list](database/list.md) — List MySQL databases
	- [yc managed-mysql database create](database/create.md) — Create MySQL database
	- [yc managed-mysql database delete](database/delete.md) — Delete the specified MySQL database
- [yc managed-mysql user](user/index.md) — Manage MySQL users
	- [yc managed-mysql user get](user/get.md) — Show information about the specified MySQL user
	- [yc managed-mysql user list](user/list.md) — List users for the specified MySQL cluster
	- [yc managed-mysql user create](user/create.md) — Create a MySQL user
	- [yc managed-mysql user update](user/update.md) — Update the specified MySQL user
	- [yc managed-mysql user delete](user/delete.md) — Delete the specified MySQL user
	- [yc managed-mysql user grant-permission](user/grant-permission.md) — Grant permission to the specified MySQL user
	- [yc managed-mysql user revoke-permission](user/revoke-permission.md) — Revoke permission from the specified MySQL user
- [yc managed-mysql backup](backup/index.md) — Manage MySQL backups
	- [yc managed-mysql backup get](backup/get.md) — Show information about the specified MySQL backup
	- [yc managed-mysql backup list](backup/list.md) — List available backups
- [yc managed-mysql resource-preset](resource-preset/index.md) — Manage MySQL resource presets
	- [yc managed-mysql resource-preset get](resource-preset/get.md) — Show information about the specified MySQL resource preset
	- [yc managed-mysql resource-preset list](resource-preset/list.md) — List available MySQL resource presets.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
