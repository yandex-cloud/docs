---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-elasticsearch/extension/index.md
---
# yc managed-elasticsearch extension

Manage Elasticsearch extensions.

#### Command Usage

Syntax: 

`yc managed-elasticsearch extension <command>`

Aliases: 

- `extensions`

#### Command Tree

- [yc managed-elasticsearch extension get](get.md) — Get information about a Elasticsearch extension.
- [yc managed-elasticsearch extension list](list.md) — List Elasticsearch extension created for the cluster.
- [yc managed-elasticsearch extension create](create.md) — Create new extension to the cluster.
- [yc managed-elasticsearch extension delete](delete.md) — Remove specified extension from the cluster.
- [yc managed-elasticsearch extension update](update.md) — Update specified extension from the cluster.

#### Global Flags

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
