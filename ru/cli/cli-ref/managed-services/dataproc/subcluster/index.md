---
sourcePath: ru/_cli-ref/cli-ref/managed-services/dataproc/subcluster/index.md
---
# yc dataproc subcluster

Manage Dataproc subclusters.

#### Command Usage

Syntax: 

`yc dataproc subcluster <command>`

Aliases: 

- `subclusters`

#### Command Tree

- [yc dataproc subcluster get](get.md) — Get information about a subcluster.
- [yc dataproc subcluster list](list.md) — List subclusters in a cluster.
- [yc dataproc subcluster create](create.md) — Create a subcluster.
- [yc dataproc subcluster update](update.md) — Modify configuration or attributes of a subcluster.
- [yc dataproc subcluster delete](delete.md) — Delete a subcluster.

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
