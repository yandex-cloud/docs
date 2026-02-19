---
editable: false
noIndex: true
---

# yc beta managed-opensearch

Manage OpenSearch clusters, hosts, indexes and backups

#### Command Usage

Syntax:

`yc beta managed-opensearch <group>`

#### Command Tree

- [yc beta managed-opensearch backup](backup/index.md) — A set of methods for managing backups.

  - [yc beta managed-opensearch backup get](backup/get.md) — Returns the specified backup of an OpenSearch cluster.

  - [yc beta managed-opensearch backup list](backup/list.md) — Returns the list of available backups for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster](cluster/index.md) — A set of methods for managing OpenSearch clusters.

  - [yc beta managed-opensearch cluster add-dashboards-node-group](cluster/add-dashboards-node-group.md) — Creates a Dashboards type host group.

  - [yc beta managed-opensearch cluster add-open-search-node-group](cluster/add-open-search-node-group.md) — Creates an OpenSearch type host group.

  - [yc beta managed-opensearch cluster backup](cluster/backup.md) — Creates a backup for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster create](cluster/create.md) — Creates an OpenSearch cluster in the specified folder.

  - [yc beta managed-opensearch cluster delete](cluster/delete.md) — Deletes the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster delete-backup](cluster/delete-backup.md) — Delete backup for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster delete-dashboards-node-group](cluster/delete-dashboards-node-group.md) — Deletes a Dashboards type host group.

  - [yc beta managed-opensearch cluster delete-open-search-node-group](cluster/delete-open-search-node-group.md) — Deletes an OpenSearch type host group.

  - [yc beta managed-opensearch cluster get](cluster/get.md) — Returns the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster get-auth-settings](cluster/get-auth-settings.md) — Retrieves auth settings for specified cluster.

  - [yc beta managed-opensearch cluster list](cluster/list.md) — Retrieves the list of OpenSearch clusters that belong to the specified folder.

  - [yc beta managed-opensearch cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster list-backups](cluster/list-backups.md) — Returns a list of available backups for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified cluster.

  - [yc beta managed-opensearch cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-opensearch cluster move](cluster/move.md) — Moves the specified OpenSearch cluster to the specified folder.

  - [yc beta managed-opensearch cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedules a planned maintenance operation.

  - [yc beta managed-opensearch cluster restart-open-search](cluster/restart-open-search.md) — Restarts OpenSearch on specified host.

  - [yc beta managed-opensearch cluster restore](cluster/restore.md) — Creates a new OpenSearch cluster using the specified backup.

  - [yc beta managed-opensearch cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster start](cluster/start.md) — Starts the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster stop](cluster/stop.md) — Stops the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster switch-master](cluster/switch-master.md) — Switches current master or ensures that master not on specified hosts.

  - [yc beta managed-opensearch cluster update](cluster/update.md) — Updates the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified OpenSearch cluster.

  - [yc beta managed-opensearch cluster update-auth-settings](cluster/update-auth-settings.md) — Updates auth settings for specified cluster.

  - [yc beta managed-opensearch cluster update-dashboards-node-group](cluster/update-dashboards-node-group.md) — Updates a Dashboards type host group.

  - [yc beta managed-opensearch cluster update-open-search-node-group](cluster/update-open-search-node-group.md) — Updates an OpenSearch type host group.

- [yc beta managed-opensearch extension](extension/index.md) — 

  - [yc beta managed-opensearch extension create](extension/create.md) — Creates new extension version.

  - [yc beta managed-opensearch extension delete](extension/delete.md) — Deletes the specified extension.

  - [yc beta managed-opensearch extension get](extension/get.md) — Returns the specified extension of OpenSearch cluster.

  - [yc beta managed-opensearch extension list](extension/list.md) — Returns the list of available extensions for the specified OpenSearch cluster.

  - [yc beta managed-opensearch extension update](extension/update.md) — Updates the specified extension.

- [yc beta managed-opensearch resource-preset](resource-preset/index.md) — A set of methods for managing resource presets.

  - [yc beta managed-opensearch resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta managed-opensearch resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

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