---
editable: false
noIndex: true
---

# yc beta managed-greenplum

Manage Greenplum clusters and hosts

#### Command Usage

Syntax:

`yc beta managed-greenplum <group>`

#### Command Tree

- [yc beta managed-greenplum backup](backup/index.md) — A set of methods for managing backups.

  - [yc beta managed-greenplum backup delete](backup/delete.md) — 

  - [yc beta managed-greenplum backup get](backup/get.md) — Returns the specified backup of Greenplum® cluster.

  - [yc beta managed-greenplum backup list](backup/list.md) — Returns the list of available backups for the specified Greenplum® cluster.

- [yc beta managed-greenplum cluster](cluster/index.md) — A set of methods for managing Greenplum® clusters.

  - [yc beta managed-greenplum cluster backup](cluster/backup.md) — Creates a backup for the specified Greenplum cluster.

  - [yc beta managed-greenplum cluster create](cluster/create.md) — Creates a Greenplum® cluster in the specified folder.

  - [yc beta managed-greenplum cluster delete](cluster/delete.md) — Deletes the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster expand](cluster/expand.md) — Expands the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster get](cluster/get.md) — Returns the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster list](cluster/list.md) — Retrieves a list of Greenplum® clusters that belong to the specified folder.

  - [yc beta managed-greenplum cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster list-backups](cluster/list-backups.md) — Retrieves a list of available backups for the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster list-master-hosts](cluster/list-master-hosts.md) — Retrieves a list of master hosts for the specified cluster.

  - [yc beta managed-greenplum cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-greenplum cluster list-segment-hosts](cluster/list-segment-hosts.md) — Retrieves a list of segment hosts for the specified cluster.

  - [yc beta managed-greenplum cluster move](cluster/move.md) — Moves the specified Greenplum® cluster to the specified folder.

  - [yc beta managed-greenplum cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule planned maintenance operation.

  - [yc beta managed-greenplum cluster restore](cluster/restore.md) — Creates a new Greenplum® cluster using the specified backup.

  - [yc beta managed-greenplum cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster start](cluster/start.md) — Starts the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster stop](cluster/stop.md) — Stops the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster update](cluster/update.md) — Updates the specified Greenplum® cluster.

  - [yc beta managed-greenplum cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Greenplum® cluster.

- [yc beta managed-greenplum hba-rule](hba-rule/index.md) — A set of methods for managing Greenplum clusters.

  - [yc beta managed-greenplum hba-rule batch-update](hba-rule/batch-update.md) — Modifies all HBA rules for the specified Greenplum cluster.

  - [yc beta managed-greenplum hba-rule create](hba-rule/create.md) — Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list.

  - [yc beta managed-greenplum hba-rule delete](hba-rule/delete.md) — Delete specified HBA rule for the specified Greenplum cluster.

  - [yc beta managed-greenplum hba-rule list](hba-rule/list.md) — Retrieves a list of HBA rules for Greenplum clusters.

  - [yc beta managed-greenplum hba-rule list-at-revision](hba-rule/list-at-revision.md) — Retrieves a list of HBA rules for Greenplum clusters for particular revision.

  - [yc beta managed-greenplum hba-rule update](hba-rule/update.md) — Update specified HBA rule for the specified Greenplum cluster without changind it order.

- [yc beta managed-greenplum pxf-datasource](pxf-datasource/index.md) — 

  - [yc beta managed-greenplum pxf-datasource create](pxf-datasource/create.md) — Creates PXF datasource

  - [yc beta managed-greenplum pxf-datasource delete](pxf-datasource/delete.md) — Delete PXF datasource

  - [yc beta managed-greenplum pxf-datasource list](pxf-datasource/list.md) — List all PXF datasources

  - [yc beta managed-greenplum pxf-datasource update](pxf-datasource/update.md) — Update PXF datasource

- [yc beta managed-greenplum resource-group](resource-group/index.md) — 

  - [yc beta managed-greenplum resource-group create](resource-group/create.md) — Creates resource group

  - [yc beta managed-greenplum resource-group delete](resource-group/delete.md) — Delete resource group

  - [yc beta managed-greenplum resource-group get-at-revision](resource-group/get-at-revision.md) — Returns the specified resource group at revision.

  - [yc beta managed-greenplum resource-group list](resource-group/list.md) — List all resource group

  - [yc beta managed-greenplum resource-group update](resource-group/update.md) — Update resource group

- [yc beta managed-greenplum resource-preset](resource-preset/index.md) — A set of methods for managing resource presets.

  - [yc beta managed-greenplum resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta managed-greenplum resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

- [yc beta managed-greenplum user](user/index.md) — 

  - [yc beta managed-greenplum user create](user/create.md) — Creates user

  - [yc beta managed-greenplum user delete](user/delete.md) — Delete user

  - [yc beta managed-greenplum user list](user/list.md) — List all users

  - [yc beta managed-greenplum user update](user/update.md) — Update user

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