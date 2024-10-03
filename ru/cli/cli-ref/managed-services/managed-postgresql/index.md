---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-postgresql/index.md
---

# yc managed-postgresql

Manage PostgreSQL clusters, hosts, databases, backups and users.

#### Command Usage

Syntax: 

`yc managed-postgresql <group>`

Aliases: 

- `postgresql`
- `postgres`

#### Command Tree

- [yc managed-postgresql cluster](cluster/index.md) — Manage PostgreSQL clusters
	- [yc managed-postgresql cluster get](cluster/get.md) — Show information about the specified PostgreSQL cluster
	- [yc managed-postgresql cluster list](cluster/list.md) — List PostgreSQL clusters
	- [yc managed-postgresql cluster create](cluster/create.md) — Create PostgreSQL cluster
	- [yc managed-postgresql cluster restore](cluster/restore.md) — Restore PostgreSQL cluster
	- [yc managed-postgresql cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified PostgreSQL cluster
	- [yc managed-postgresql cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
	- [yc managed-postgresql cluster update](cluster/update.md) — Update the specified PostgreSQL cluster
	- [yc managed-postgresql cluster update-config](cluster/update-config.md) — Update the specified PostgreSQL cluster config
	- [yc managed-postgresql cluster add-labels](cluster/add-labels.md) — Add labels to PostgreSQL cluster
	- [yc managed-postgresql cluster remove-labels](cluster/remove-labels.md) — Remove labels from PostgreSQL cluster
	- [yc managed-postgresql cluster delete](cluster/delete.md) — Delete the specified PostgreSQL cluster
	- [yc managed-postgresql cluster backup](cluster/backup.md) — Create a backup for the specified PostgreSQL cluster
	- [yc managed-postgresql cluster list-backups](cluster/list-backups.md) — List available backups for the specified PostgreSQL cluster
	- [yc managed-postgresql cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified PostgreSQL cluster
	- [yc managed-postgresql cluster list-operations](cluster/list-operations.md) — List operations for the specified PostgreSQL cluster
	- [yc managed-postgresql cluster move](cluster/move.md) — Move the specified PostgreSQL cluster into the folder
	- [yc managed-postgresql cluster start](cluster/start.md) — Start the specified PostgreSQL cluster
	- [yc managed-postgresql cluster stop](cluster/stop.md) — Stop the specified PostgreSQL cluster
- [yc managed-postgresql hosts](hosts/index.md) — Manage PostgreSQL cluster hosts
	- [yc managed-postgresql hosts list](hosts/list.md) — List hosts for the specified PostgreSQL cluster
	- [yc managed-postgresql hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones
	- [yc managed-postgresql hosts update](hosts/update.md) — Update the specified hosts
	- [yc managed-postgresql hosts delete](hosts/delete.md) — Delete the specified hosts
	- [yc managed-postgresql hosts update-config](hosts/update-config.md) — Updates PostgreSQL config for the specified hosts
- [yc managed-postgresql database](database/index.md) — Manage PostgreSQL databases
	- [yc managed-postgresql database get](database/get.md) — Show information about the specified PostgreSQL database
	- [yc managed-postgresql database list](database/list.md) — List PostgreSQL databases
	- [yc managed-postgresql database create](database/create.md) — Create PostgreSQL database
	- [yc managed-postgresql database update](database/update.md) — Update the specified PostgreSQL database
	- [yc managed-postgresql database delete](database/delete.md) — Delete the specified PostgreSQL database
- [yc managed-postgresql user](user/index.md) — Manage PostgreSQL users
	- [yc managed-postgresql user get](user/get.md) — Show information about the specified PostgreSQL user
	- [yc managed-postgresql user list](user/list.md) — List users for the specified PostgreSQL cluster
	- [yc managed-postgresql user create](user/create.md) — Create a PostgreSQL user
	- [yc managed-postgresql user update](user/update.md) — Update the specified PostgreSQL user
	- [yc managed-postgresql user delete](user/delete.md) — Delete the specified PostgreSQL user
	- [yc managed-postgresql user grant-permission](user/grant-permission.md) — Grant permission to the specified PostgreSQL user
	- [yc managed-postgresql user revoke-permission](user/revoke-permission.md) — Revoke permission from the specified PostgreSQL user
- [yc managed-postgresql backup](backup/index.md) — Manage PostgreSQL backups
	- [yc managed-postgresql backup get](backup/get.md) — Show information about the specified PostgreSQL backup
	- [yc managed-postgresql backup list](backup/list.md) — List available backups
	- [yc managed-postgresql backup delete](backup/delete.md) — Delete the specified PostgreSQL backup
- [yc managed-postgresql resource-preset](resource-preset/index.md) — Manage PostgreSQL resource presets
	- [yc managed-postgresql resource-preset get](resource-preset/get.md) — Show information about the specified PostgreSQL resource preset
	- [yc managed-postgresql resource-preset list](resource-preset/list.md) — List available PostgreSQL resource presets.

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
