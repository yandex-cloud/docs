---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster

A set of methods for managing OpenSearch clusters.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster <command>`

#### Command Tree

- [yc beta managed-opensearch cluster add-dashboards-node-group](add-dashboards-node-group.md) — Creates a Dashboards type host group.

- [yc beta managed-opensearch cluster add-open-search-node-group](add-open-search-node-group.md) — Creates an OpenSearch type host group.

- [yc beta managed-opensearch cluster backup](backup.md) — Creates a backup for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster create](create.md) — Creates an OpenSearch cluster in the specified folder.

- [yc beta managed-opensearch cluster delete](delete.md) — Deletes the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster delete-backup](delete-backup.md) — Delete backup for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster delete-dashboards-node-group](delete-dashboards-node-group.md) — Deletes a Dashboards type host group.

- [yc beta managed-opensearch cluster delete-open-search-node-group](delete-open-search-node-group.md) — Deletes an OpenSearch type host group.

- [yc beta managed-opensearch cluster get](get.md) — Returns the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster get-auth-settings](get-auth-settings.md) — Retrieves auth settings for specified cluster.

- [yc beta managed-opensearch cluster list](list.md) — Retrieves the list of OpenSearch clusters that belong to the specified folder.

- [yc beta managed-opensearch cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster list-backups](list-backups.md) — Returns a list of available backups for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified cluster.

- [yc beta managed-opensearch cluster list-logs](list-logs.md) — Retrieves logs for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

- [yc beta managed-opensearch cluster move](move.md) — Moves the specified OpenSearch cluster to the specified folder.

- [yc beta managed-opensearch cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedules a planned maintenance operation.

- [yc beta managed-opensearch cluster restart-open-search](restart-open-search.md) — Restarts OpenSearch on specified host.

- [yc beta managed-opensearch cluster restore](restore.md) — Creates a new OpenSearch cluster using the specified backup.

- [yc beta managed-opensearch cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster start](start.md) — Starts the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster stop](stop.md) — Stops the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster switch-master](switch-master.md) — Switches current master or ensures that master not on specified hosts.

- [yc beta managed-opensearch cluster update](update.md) — Updates the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified OpenSearch cluster.

- [yc beta managed-opensearch cluster update-auth-settings](update-auth-settings.md) — Updates auth settings for specified cluster.

- [yc beta managed-opensearch cluster update-dashboards-node-group](update-dashboards-node-group.md) — Updates a Dashboards type host group.

- [yc beta managed-opensearch cluster update-open-search-node-group](update-open-search-node-group.md) — Updates an OpenSearch type host group.

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