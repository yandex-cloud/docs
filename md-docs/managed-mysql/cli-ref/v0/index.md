# yc managed-mysql v0

Manage MySQL clusters, hosts, databases, backups and users.

#### Command Usage

Syntax:

`yc managed-mysql v0 <group|command>`

#### Command Tree

- [yc managed-mysql v0 connect](connect.md) — Connect to MySQL cluster with iam-auth

- [yc managed-mysql v0 backup](backup/index.md) — Manage MySQL backups

  - [yc managed-mysql v0 backup get](backup/get.md) — Show information about the specified MySQL backup

  - [yc managed-mysql v0 backup list](backup/list.md) — List available backups

- [yc managed-mysql v0 backup-retention-policy](backup-retention-policy/index.md) — Manage MySQL backup retention policies

  - [yc managed-mysql v0 backup-retention-policy create](backup-retention-policy/create.md) — Create backup retention policy for the specified MySQL cluster

  - [yc managed-mysql v0 backup-retention-policy delete](backup-retention-policy/delete.md) — Delete the specified backup retention policies

  - [yc managed-mysql v0 backup-retention-policy list](backup-retention-policy/list.md) — List backup retention policies for the specified MySQL cluster

  - [yc managed-mysql v0 backup-retention-policy list-by-folder](backup-retention-policy/list-by-folder.md) — List backup retention policies for all clusters in the specified folder

- [yc managed-mysql v0 cluster](cluster/index.md) — Manage MySQL clusters

  - [yc managed-mysql v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified MySQL cluster

  - [yc managed-mysql v0 cluster add-labels](cluster/add-labels.md) — Add labels to MySQL cluster

  - [yc managed-mysql v0 cluster backup](cluster/backup.md) — Create a backup for the specified MySQL cluster

  - [yc managed-mysql v0 cluster create](cluster/create.md) — Create MySQL cluster

  - [yc managed-mysql v0 cluster delete](cluster/delete.md) — Delete the specified MySQL cluster

  - [yc managed-mysql v0 cluster get](cluster/get.md) — Show information about the specified MySQL cluster

  - [yc managed-mysql v0 cluster list](cluster/list.md) — List MySQL clusters

  - [yc managed-mysql v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified MySQL cluster

  - [yc managed-mysql v0 cluster list-backups](cluster/list-backups.md) — List available backups for the specified MySQL cluster

  - [yc managed-mysql v0 cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified MySQL cluster

  - [yc managed-mysql v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified MySQL cluster

  - [yc managed-mysql v0 cluster move](cluster/move.md) — Move the specified MySQL cluster into the folder

  - [yc managed-mysql v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified MySQL cluster

  - [yc managed-mysql v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from MySQL cluster

  - [yc managed-mysql v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-mysql v0 cluster restore](cluster/restore.md) — Restore MySQL cluster

  - [yc managed-mysql v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified MySQL cluster and delete all existing access bindings if there were any

  - [yc managed-mysql v0 cluster start](cluster/start.md) — Start the specified MySQL cluster

  - [yc managed-mysql v0 cluster start-failover](cluster/start-failover.md) — Start manual failover for the specified MySQL cluster

  - [yc managed-mysql v0 cluster stop](cluster/stop.md) — Stop the specified MySQL cluster

  - [yc managed-mysql v0 cluster update](cluster/update.md) — Update the specified MySQL cluster

  - [yc managed-mysql v0 cluster update-config](cluster/update-config.md) — Update the specified MySQL cluster config

- [yc managed-mysql v0 database](database/index.md) — Manage MySQL databases

  - [yc managed-mysql v0 database create](database/create.md) — Create MySQL database

  - [yc managed-mysql v0 database delete](database/delete.md) — Delete the specified MySQL database

  - [yc managed-mysql v0 database get](database/get.md) — Show information about the specified MySQL database

  - [yc managed-mysql v0 database list](database/list.md) — List MySQL databases

  - [yc managed-mysql v0 database update](database/update.md) — Update the specified MySQL database

- [yc managed-mysql v0 hosts](hosts/index.md) — Manage MySQL cluster hosts

  - [yc managed-mysql v0 hosts add](hosts/add.md) — Create new hosts for the cluster in the specified availability zones

  - [yc managed-mysql v0 hosts delete](hosts/delete.md) — Delete the specified hosts

  - [yc managed-mysql v0 hosts list](hosts/list.md) — List hosts for the specified MySQL cluster

  - [yc managed-mysql v0 hosts update](hosts/update.md) — Update the specified hosts

- [yc managed-mysql v0 resource-preset](resource-preset/index.md) — Manage MySQL resource presets

  - [yc managed-mysql v0 resource-preset get](resource-preset/get.md) — Show information about the specified MySQL resource preset

  - [yc managed-mysql v0 resource-preset list](resource-preset/list.md) — List available MySQL resource presets.

- [yc managed-mysql v0 user](user/index.md) — Manage MySQL users

  - [yc managed-mysql v0 user create](user/create.md) — Create a MySQL user

  - [yc managed-mysql v0 user delete](user/delete.md) — Delete the specified MySQL user

  - [yc managed-mysql v0 user get](user/get.md) — Show information about the specified MySQL user

  - [yc managed-mysql v0 user grant-permission](user/grant-permission.md) — Grant permission to the specified MySQL user

  - [yc managed-mysql v0 user list](user/list.md) — List users for the specified MySQL cluster

  - [yc managed-mysql v0 user revoke-permission](user/revoke-permission.md) — Revoke permission from the specified MySQL user

  - [yc managed-mysql v0 user update](user/update.md) — Update the specified MySQL user

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