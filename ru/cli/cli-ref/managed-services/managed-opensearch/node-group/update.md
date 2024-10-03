---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-opensearch/node-group/update.md
---

# yc managed-opensearch node-group update

Update a node group configuration in a managed OpenSearch cluster.

#### Command Usage

Syntax: 

`yc managed-opensearch node-group update [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the OpenSearch cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--node-group-name`|<b>`string`</b><br/>Name of the node group to be updated.|
|`--resource-preset-id`|<b>`string`</b><br/>ID of the resource preset to use for the hosts in the node group.|
|`--disk-size`|<b>`int`</b><br/>Disk size to attach to the selected resource preset.|
|`--hosts-count`|<b>`int`</b><br/>Number of hosts to be present within the node group.|
|`--roles`|<b>`string`</b><br/>Roles to be given to the hosts in a OpenSearch node group. Supported values: 'manager', 'data', 'data+manager' (or 'manager+data')|

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
