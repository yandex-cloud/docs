---
editable: false
---

# yc managed-opensearch

Managed OpenSearch clusters, hosts, indexes and backups.

#### Command Usage

Syntax: 

`yc managed-opensearch <group>`

Aliases: 

- `opensearch`

#### Command Tree

- [yc managed-opensearch cluster](cluster/index.md) — Managed OpenSearch clusters.
	- [yc managed-opensearch cluster create](cluster/create.md) — Create an OpenSearch cluster
	- [yc managed-opensearch cluster list](cluster/list.md) — List OpenSearch clusters in a folder
	- [yc managed-opensearch cluster get](cluster/get.md) — Get information about an OpenSearch cluster.
	- [yc managed-opensearch cluster delete](cluster/delete.md) — Delete Opensearch clusters.
	- [yc managed-opensearch cluster list-backups](cluster/list-backups.md) — List available backups for an OpenSearch cluster.
	- [yc managed-opensearch cluster update](cluster/update.md) — Update a managed OpenSearchCluster.
	- [yc managed-opensearch cluster backup](cluster/backup.md) — Create a backup for a managed OpenSearch cluster.
	- [yc managed-opensearch cluster restore](cluster/restore.md) — Restore a managed OpenSearch cluster from a backup.
- [yc managed-opensearch node-group](node-group/index.md) — Node groups of a managed OpenSearch cluster.
	- [yc managed-opensearch node-group add](node-group/add.md) — Add new node groups to a managed OpenSearch cluster.
	- [yc managed-opensearch node-group delete](node-group/delete.md) — Delete a node group in a managed OpenSearch cluster.
	- [yc managed-opensearch node-group update](node-group/update.md) — Update a node group configuration in a managed OpenSearch cluster.
- [yc managed-opensearch backup](backup/index.md) — Backups of a managed OpenSearch cluster.
	- [yc managed-opensearch backup list](backup/list.md) — List available OpenSearch backups in a folder.
	- [yc managed-opensearch backup get](backup/get.md) — Get information about an OpenSearch cluster backup.
- [yc managed-opensearch auth-settings](auth-settings/index.md) — Authorization settings for a managed OpenSearch cluster.
	- [yc managed-opensearch auth-settings get](auth-settings/get.md) — Get authorization settings for a managed OpenSearch cluster.
	- [yc managed-opensearch auth-settings update](auth-settings/update.md) — Update authorization settings for a managed OpenSearch cluster.

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
