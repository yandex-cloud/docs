---
editable: false
---

# yc managed-elasticsearch cluster

Manage ElasticSearch clusters.

#### Command Usage

Syntax: 

`yc managed-elasticsearch cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-elasticsearch cluster get](get.md) — Get information about an ElasticSearch cluster.
- [yc managed-elasticsearch cluster list](list.md) — List ElasticSearch clusters in a folder.
- [yc managed-elasticsearch cluster create](create.md) — Create a ElasticSearch cluster.
- [yc managed-elasticsearch cluster restore](restore.md) — Restore a Elasticsearch cluster from a backup.
- [yc managed-elasticsearch cluster delete](delete.md) — Delete a ElasticSearch cluster.
- [yc managed-elasticsearch cluster backup](backup.md) — Create a backup for a Elasticsearch cluster.
- [yc managed-elasticsearch cluster list-backups](list-backups.md) — List available backups for a Elasticsearch cluster.
- [yc managed-elasticsearch cluster list-logs](list-logs.md) — Retrieve logs for a ElasticSearch cluster.
- [yc managed-elasticsearch cluster list-operations](list-operations.md) — List operations for a ElasticSearch cluster.
- [yc managed-elasticsearch cluster start](start.md) — Start the specified ElasticSearch cluster.
- [yc managed-elasticsearch cluster stop](stop.md) — Stop the specified ElasticSearch cluster.
- [yc managed-elasticsearch cluster update](update.md) — Modify configuration or attributes of a ElasticSearch cluster.
- [yc managed-elasticsearch cluster update-config](update-config.md) — Update the configuration of a ElasticSearch cluster.
- [yc managed-elasticsearch cluster add-labels](add-labels.md) — Assign labels to a ElasticSearch cluster.
- [yc managed-elasticsearch cluster remove-labels](remove-labels.md) — Remove labels from specified ElasticSearch cluster
- [yc managed-elasticsearch cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
