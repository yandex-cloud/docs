---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-opensearch/cli-ref/cluster/index.md
---

# yc managed-opensearch cluster

Managed OpenSearch clusters.

#### Command Usage

Syntax: 

`yc managed-opensearch cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-opensearch cluster backup](backup.md) — Create a backup for a managed OpenSearch cluster.
- [yc managed-opensearch cluster create](create.md) — Create an OpenSearch cluster
- [yc managed-opensearch cluster delete](delete.md) — Delete Opensearch clusters.
- [yc managed-opensearch cluster get](get.md) — Get information about an OpenSearch cluster.
- [yc managed-opensearch cluster list](list.md) — List OpenSearch clusters in a folder
- [yc managed-opensearch cluster list-backups](list-backups.md) — List available backups for an OpenSearch cluster.
- [yc managed-opensearch cluster restore](restore.md) — Restore a managed OpenSearch cluster from a backup.
- [yc managed-opensearch cluster update](update.md) — Update a managed OpenSearchCluster.

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
