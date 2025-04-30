---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/resource-groups/update.md
---

# yc managed-greenplum resource-groups update

Update resource group for specified Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum resource-groups update <RESOURCE-GROUP-NAME> [Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Greenplum cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Greenplum cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--concurrency`|<b>`int`</b><br/>The maximum number of concurrent transactions, including active and idle transactions, that are permitted in the resource group.|
|`--cpu-rate-limit`|<b>`int`</b><br/>The percentage of CPU resources available to this resource group.|
|`--memory-limit`|<b>`int`</b><br/>The percentage of reserved memory resources available to this resource group.|
|`--memory-shared-quota`|<b>`int`</b><br/>The percentage of reserved memory to share across transactions submitted in this resource group.|
|`--memory-spill-ratio`|<b>`int`</b><br/>The memory usage threshold for memory-intensive transactions. When a transaction reaches this threshold, it spills to disk.|

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
