---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-opensearch/cli-ref/v0/
---

# yc managed-opensearch v0

Managed OpenSearch clusters, hosts, indexes and backups.

#### Command Usage

Syntax:

`yc managed-opensearch v0 <group>`

#### Command Tree

- [yc managed-opensearch v0 auth-settings](auth-settings/index.md) — Authorization settings for a managed OpenSearch cluster.

  - [yc managed-opensearch v0 auth-settings get](auth-settings/get.md) — Get authorization settings for a managed OpenSearch cluster.

  - [yc managed-opensearch v0 auth-settings update](auth-settings/update.md) — Update authorization settings for a managed OpenSearch cluster.

- [yc managed-opensearch v0 backup](backup/index.md) — Backups of a managed OpenSearch cluster.

  - [yc managed-opensearch v0 backup get](backup/get.md) — Get information about an OpenSearch cluster backup.

  - [yc managed-opensearch v0 backup list](backup/list.md) — List available OpenSearch backups in a folder.

- [yc managed-opensearch v0 cluster](cluster/index.md) — Managed OpenSearch clusters.

  - [yc managed-opensearch v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified OpenSearch cluster

  - [yc managed-opensearch v0 cluster backup](cluster/backup.md) — Create a backup for a managed OpenSearch cluster.

  - [yc managed-opensearch v0 cluster create](cluster/create.md) — Create an OpenSearch cluster

  - [yc managed-opensearch v0 cluster delete](cluster/delete.md) — Delete Opensearch clusters.

  - [yc managed-opensearch v0 cluster get](cluster/get.md) — Get information about an OpenSearch cluster.

  - [yc managed-opensearch v0 cluster list](cluster/list.md) — List OpenSearch clusters in a folder

  - [yc managed-opensearch v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified OpenSearch cluster

  - [yc managed-opensearch v0 cluster list-backups](cluster/list-backups.md) — List available backups for an OpenSearch cluster.

  - [yc managed-opensearch v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified OpenSearch cluster

  - [yc managed-opensearch v0 cluster restart-opensearch](cluster/restart-opensearch.md) — Restart OpenSearch on host.

  - [yc managed-opensearch v0 cluster restore](cluster/restore.md) — Restore a managed OpenSearch cluster from a backup.

  - [yc managed-opensearch v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified OpenSearch cluster and delete all existing access bindings if there were any

  - [yc managed-opensearch v0 cluster start](cluster/start.md) — Start a managed OpenSearch cluster.

  - [yc managed-opensearch v0 cluster stop](cluster/stop.md) — Stop a managed OpenSearch cluster.

  - [yc managed-opensearch v0 cluster switch-master](cluster/switch-master.md) — Switch current master or ensure that it is not on specified hosts.

  - [yc managed-opensearch v0 cluster update](cluster/update.md) — Update a managed OpenSearchCluster.

- [yc managed-opensearch v0 extension](extension/index.md) — Extensions of a managed OpenSearch cluster.

  - [yc managed-opensearch v0 extension create](extension/create.md) — Create a new extension for a managed OpenSearch cluster.

  - [yc managed-opensearch v0 extension delete](extension/delete.md) — Delete an extension from a managed OpenSearch cluster.

  - [yc managed-opensearch v0 extension get](extension/get.md) — Get information about an extension in a managed OpenSearch cluster.

  - [yc managed-opensearch v0 extension list](extension/list.md) — List extensions for a managed OpenSearch cluster.

  - [yc managed-opensearch v0 extension update](extension/update.md) — Update an extension in a managed OpenSearch cluster.

- [yc managed-opensearch v0 node-group](node-group/index.md) — Node groups of a managed OpenSearch cluster.

  - [yc managed-opensearch v0 node-group add](node-group/add.md) — Add new node groups to a managed OpenSearch cluster.

  - [yc managed-opensearch v0 node-group delete](node-group/delete.md) — Delete a node group in a managed OpenSearch cluster.

  - [yc managed-opensearch v0 node-group update](node-group/update.md) — Update a node group configuration in a managed OpenSearch cluster.

- [yc managed-opensearch v0 plugin](plugin/index.md) — Plugins of a managed OpenSearch cluster.

  - [yc managed-opensearch v0 plugin add](plugin/add.md) — Add plugins to a managed OpenSearch cluster.

  - [yc managed-opensearch v0 plugin delete](plugin/delete.md) — Delete plugins from a managed OpenSearch cluster.

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