---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/index.md
---

# yc managed-greenplum

Manage Greenplum clusters and hosts.

#### Command Usage

Syntax: 

`yc managed-greenplum <group|command>`

Aliases: 

- `greenplum`
- `gp`

#### Command Tree

- [yc managed-greenplum connect](connect.md) — Connect to Greenplum cluster with iam-auth
- [yc managed-greenplum backup](backup/index.md) — Manage Greenplum cluster backups
	- [yc managed-greenplum backup delete](backup/delete.md) — Delete the specified Greenplum backup
	- [yc managed-greenplum backup get](backup/get.md) — Show information about the specified Greenplum backup
	- [yc managed-greenplum backup list](backup/list.md) — List available backups
- [yc managed-greenplum cluster](cluster/index.md) — Manage Greenplum clusters
	- [yc managed-greenplum cluster add-labels](cluster/add-labels.md) — Add labels to Greenplum cluster
	- [yc managed-greenplum cluster backup](cluster/backup.md) — Create a backup for the specified Greenplum cluster
	- [yc managed-greenplum cluster create](cluster/create.md) — Create Greenplum cluster
	- [yc managed-greenplum cluster delete](cluster/delete.md) — Delete the specified Greenplum cluster
	- [yc managed-greenplum cluster expand](cluster/expand.md) — Expands the specified Greenplum cluster
	- [yc managed-greenplum cluster get](cluster/get.md) — Show information about the specified Greenplum cluster
	- [yc managed-greenplum cluster list](cluster/list.md) — List Greenplum clusters
	- [yc managed-greenplum cluster list-backups](cluster/list-backups.md) — List available backups for the specified Greenplum cluster
	- [yc managed-greenplum cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Greenplum cluster
	- [yc managed-greenplum cluster list-operations](cluster/list-operations.md) — List operations for the specified Greenplum cluster
	- [yc managed-greenplum cluster move](cluster/move.md) — Move the specified Greenplum cluster into the folder
	- [yc managed-greenplum cluster remove-labels](cluster/remove-labels.md) — Remove labels from Greenplum cluster
	- [yc managed-greenplum cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule maintenance for the specified Greenplum cluster
	- [yc managed-greenplum cluster restore](cluster/restore.md) — Restore Greenplum cluster
	- [yc managed-greenplum cluster start](cluster/start.md) — Start the specified Greenplum cluster
	- [yc managed-greenplum cluster stop](cluster/stop.md) — Stop the specified Greenplum cluster
	- [yc managed-greenplum cluster update](cluster/update.md) — Update the specified Greenplum cluster
	- [yc managed-greenplum cluster update-config](cluster/update-config.md) — Update the specified Greenplum cluster config
- [yc managed-greenplum hba-rules](hba-rules/index.md) — Manage Greenplum hba rules
	- [yc managed-greenplum hba-rules create](hba-rules/create.md) — Create hba-rule for specified Greenplum cluster
	- [yc managed-greenplum hba-rules delete](hba-rules/delete.md) — Delete hba-rule for specified Greenplum cluster
	- [yc managed-greenplum hba-rules get](hba-rules/get.md) — Get hba-rule for specified Greenplum cluster
	- [yc managed-greenplum hba-rules list](hba-rules/list.md) — List hba-rules for specified Greenplum cluster
	- [yc managed-greenplum hba-rules update](hba-rules/update.md) — Update hba-rule for specified Greenplum cluster
- [yc managed-greenplum hosts](hosts/index.md) — Manage Greenplum cluster hosts.
- [yc managed-greenplum pxf-datasource](pxf-datasource/index.md) — Manage Greenplum pxf datasources
	- [yc managed-greenplum pxf-datasource delete](pxf-datasource/delete.md) — Delete pxf-datasource for specified Greenplum cluster
	- [yc managed-greenplum pxf-datasource get](pxf-datasource/get.md) — Get pxf-datasource for specified Greenplum cluster
	- [yc managed-greenplum pxf-datasource list](pxf-datasource/list.md) — List pxf-datasources for specified Greenplum cluster
- [yc managed-greenplum resource-groups](resource-groups/index.md) — Manage Greenplum resource groups
	- [yc managed-greenplum resource-groups create](resource-groups/create.md) — Create resource group for specified Greenplum cluster
	- [yc managed-greenplum resource-groups delete](resource-groups/delete.md) — Delete resource group for specified Greenplum cluster
	- [yc managed-greenplum resource-groups get](resource-groups/get.md) — Get resource group for specified Greenplum cluster
	- [yc managed-greenplum resource-groups list](resource-groups/list.md) — List resource group for specified Greenplum cluster
	- [yc managed-greenplum resource-groups update](resource-groups/update.md) — Update resource group for specified Greenplum cluster
- [yc managed-greenplum resource-preset](resource-preset/index.md) — Manage Greenplum resource presets
- [yc managed-greenplum users](users/index.md) — Manage Greenplum users
	- [yc managed-greenplum users create](users/create.md) — Create user for specified Greenplum cluster
	- [yc managed-greenplum users delete](users/delete.md) — Delete user for specified Greenplum cluster
	- [yc managed-greenplum users get](users/get.md) — Get user for specified Greenplum cluster
	- [yc managed-greenplum users list](users/list.md) — List user for specified Greenplum cluster
	- [yc managed-greenplum users update](users/update.md) — Update user for specified Greenplum cluster

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
