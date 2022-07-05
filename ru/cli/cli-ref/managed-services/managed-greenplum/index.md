---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-greenplum/index.md
---
# yc managed-greenplum

Manage Greenplum clusters and hosts.

#### Command Usage

Syntax: 

`yc managed-greenplum <group>`

Aliases: 

- `greenplum`
- `gp`

#### Command Tree

- [yc managed-greenplum cluster](cluster/index.md) — Manage Greenplum clusters
	- [yc managed-greenplum cluster get](cluster/get.md) — Show information about the specified Greenplum cluster
	- [yc managed-greenplum cluster list](cluster/list.md) — List Greenplum clusters
	- [yc managed-greenplum cluster add-labels](cluster/add-labels.md) — Add labels to Greenplum cluster
	- [yc managed-greenplum cluster remove-labels](cluster/remove-labels.md) — Remove labels from Greenplum cluster
	- [yc managed-greenplum cluster create](cluster/create.md) — Create Greenplum cluster
	- [yc managed-greenplum cluster delete](cluster/delete.md) — Delete the specified Greenplum cluster
	- [yc managed-greenplum cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Greenplum cluster
	- [yc managed-greenplum cluster list-operations](cluster/list-operations.md) — List operations for the specified Greenplum cluster
	- [yc managed-greenplum cluster start](cluster/start.md) — Start the specified Greenplum cluster
	- [yc managed-greenplum cluster stop](cluster/stop.md) — Stop the specified Greenplum cluster
- [yc managed-greenplum hosts](hosts/index.md) — Manage Greenplum cluster hosts.
- [yc managed-greenplum resource-preset](resource-preset/index.md) — Manage Greenplum resource presets

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
