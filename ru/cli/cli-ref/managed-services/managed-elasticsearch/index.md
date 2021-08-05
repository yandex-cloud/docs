---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# yc managed-elasticsearch

Manage ElasticSearch clusters, hosts, indexes and backups.

#### Command Usage

Syntax: 

`yc managed-elasticsearch <group>`

Aliases: 

- `elasticsearch`

#### Command Tree

- [yc managed-elasticsearch cluster](cluster/index.md) — Manage ElasticSearch clusters.
	- [yc managed-elasticsearch cluster get](cluster/get.md) — Get information about an ElasticSearch cluster.
	- [yc managed-elasticsearch cluster list](cluster/list.md) — List ElasticSearch clusters in a folder.
	- [yc managed-elasticsearch cluster create](cluster/create.md) — Create a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster delete](cluster/delete.md) — Delete a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster list-logs](cluster/list-logs.md) — Retrieve logs for a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster list-operations](cluster/list-operations.md) — List operations for a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster start](cluster/start.md) — Start the specified ElasticSearch cluster.
	- [yc managed-elasticsearch cluster stop](cluster/stop.md) — Stop the specified ElasticSearch cluster.
	- [yc managed-elasticsearch cluster update](cluster/update.md) — Modify configuration or attributes of a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster update-config](cluster/update-config.md) — Update the configuration of a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster add-labels](cluster/add-labels.md) — Assign labels to a ElasticSearch cluster.
	- [yc managed-elasticsearch cluster remove-labels](cluster/remove-labels.md) — Remove labels from specified ElasticSearch cluster
- [yc managed-elasticsearch hosts](hosts/index.md) — Manage hosts of a ElasticSearch cluster.
	- [yc managed-elasticsearch hosts list](hosts/list.md) — List hosts for a ElasticSearch cluster.
	- [yc managed-elasticsearch hosts add](hosts/add.md) — Add new hosts to the cluster in specified availability zones.
	- [yc managed-elasticsearch hosts delete](hosts/delete.md) — Remove specified hosts from the cluster.
- [yc managed-elasticsearch resource-preset](resource-preset/index.md) — Learn about ElasticSearch resource presets.
	- [yc managed-elasticsearch resource-preset get](resource-preset/get.md) — Get information about a ElasticSearch resource preset.
	- [yc managed-elasticsearch resource-preset list](resource-preset/list.md) — List available resource presets for Managed Service for ElasticSearch.

#### Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
