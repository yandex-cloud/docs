---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-greenplum/cli-ref/v0/
editable: false
---

# yc managed-greenplum v0

Manage Greenplum clusters and hosts.

#### Command Usage

Syntax:

`yc managed-greenplum v0 <group|command>`

#### Command Tree

- [yc managed-greenplum v0 connect](connect.md) — Connect to Greenplum cluster with iam-auth

- [yc managed-greenplum v0 backup](backup/index.md) — Manage Greenplum cluster backups

  - [yc managed-greenplum v0 backup delete](backup/delete.md) — Delete the specified Greenplum backup

  - [yc managed-greenplum v0 backup get](backup/get.md) — Show information about the specified Greenplum backup

  - [yc managed-greenplum v0 backup list](backup/list.md) — List available backups

- [yc managed-greenplum v0 cluster](cluster/index.md) — Manage Greenplum clusters

  - [yc managed-greenplum v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster add-labels](cluster/add-labels.md) — Add labels to Greenplum cluster

  - [yc managed-greenplum v0 cluster backup](cluster/backup.md) — Create a backup for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster create](cluster/create.md) — Create Greenplum cluster

  - [yc managed-greenplum v0 cluster delete](cluster/delete.md) — Delete the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster expand](cluster/expand.md) — Expands the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster get](cluster/get.md) — Show information about the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster list](cluster/list.md) — List Greenplum clusters

  - [yc managed-greenplum v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster list-backups](cluster/list-backups.md) — List available backups for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster move](cluster/move.md) — Move the specified Greenplum cluster into the folder

  - [yc managed-greenplum v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from Greenplum cluster

  - [yc managed-greenplum v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule maintenance for the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster restore](cluster/restore.md) — Restore Greenplum cluster

  - [yc managed-greenplum v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Greenplum cluster and delete all existing access bindings if there were any

  - [yc managed-greenplum v0 cluster start](cluster/start.md) — Start the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster stop](cluster/stop.md) — Stop the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster update](cluster/update.md) — Update the specified Greenplum cluster

  - [yc managed-greenplum v0 cluster update-config](cluster/update-config.md) — Update the specified Greenplum cluster config

- [yc managed-greenplum v0 hba-rules](hba-rules/index.md) — Manage Greenplum hba rules

  - [yc managed-greenplum v0 hba-rules create](hba-rules/create.md) — Create hba-rule for specified Greenplum cluster

  - [yc managed-greenplum v0 hba-rules delete](hba-rules/delete.md) — Delete hba-rule for specified Greenplum cluster

  - [yc managed-greenplum v0 hba-rules get](hba-rules/get.md) — Get hba-rule for specified Greenplum cluster

  - [yc managed-greenplum v0 hba-rules list](hba-rules/list.md) — List hba-rules for specified Greenplum cluster

  - [yc managed-greenplum v0 hba-rules update](hba-rules/update.md) — Update hba-rule for specified Greenplum cluster

- [yc managed-greenplum v0 hosts](hosts/index.md) — Manage Greenplum cluster hosts.



- [yc managed-greenplum v0 pxf-datasource](pxf-datasource/index.md) — Manage Greenplum pxf datasources

  - [yc managed-greenplum v0 pxf-datasource delete](pxf-datasource/delete.md) — Delete pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource get](pxf-datasource/get.md) — Get pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource list](pxf-datasource/list.md) — List pxf-datasources for specified Greenplum cluster

- [yc managed-greenplum v0 resource-groups](resource-groups/index.md) — Manage Greenplum resource groups

  - [yc managed-greenplum v0 resource-groups create](resource-groups/create.md) — Create resource group for specified Greenplum cluster

  - [yc managed-greenplum v0 resource-groups delete](resource-groups/delete.md) — Delete resource group for specified Greenplum cluster

  - [yc managed-greenplum v0 resource-groups get](resource-groups/get.md) — Get resource group for specified Greenplum cluster

  - [yc managed-greenplum v0 resource-groups list](resource-groups/list.md) — List resource group for specified Greenplum cluster

  - [yc managed-greenplum v0 resource-groups update](resource-groups/update.md) — Update resource group for specified Greenplum cluster

- [yc managed-greenplum v0 resource-preset](resource-preset/index.md) — Manage Greenplum resource presets



- [yc managed-greenplum v0 users](users/index.md) — Manage Greenplum users

  - [yc managed-greenplum v0 users create](users/create.md) — Create user for specified Greenplum cluster

  - [yc managed-greenplum v0 users delete](users/delete.md) — Delete user for specified Greenplum cluster

  - [yc managed-greenplum v0 users get](users/get.md) — Get user for specified Greenplum cluster

  - [yc managed-greenplum v0 users list](users/list.md) — List user for specified Greenplum cluster

  - [yc managed-greenplum v0 users update](users/update.md) — Update user for specified Greenplum cluster

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#
