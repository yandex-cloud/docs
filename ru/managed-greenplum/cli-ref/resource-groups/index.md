---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/resource-groups/index.md
---

# yc managed-greenplum resource-groups

Manage Greenplum resource groups

#### Command Usage

Syntax: 

`yc managed-greenplum resource-groups <command>`

Aliases: 

- `resource-group`

#### Command Tree

- [yc managed-greenplum resource-groups create](create.md) — Create resource group for specified Greenplum cluster
- [yc managed-greenplum resource-groups delete](delete.md) — Delete resource group for specified Greenplum cluster
- [yc managed-greenplum resource-groups get](get.md) — Get resource group for specified Greenplum cluster
- [yc managed-greenplum resource-groups list](list.md) — List resource group for specified Greenplum cluster
- [yc managed-greenplum resource-groups update](update.md) — Update resource group for specified Greenplum cluster

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
