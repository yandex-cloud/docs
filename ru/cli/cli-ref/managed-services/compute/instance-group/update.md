---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance-group/update.md
---

# yc compute instance-group update

Update the specified instance group

#### Command Usage

Syntax: 

`yc compute instance-group update <INSTANCE-GROUP-NAME>|<INSTANCE-GROUP-ID> [Global Flags...]`

Aliases: 

- `apply`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>instance group id.|
|`--name`|<b>`string`</b><br/>instance group name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--file`|<b>`string`</b><br/>A specification will be loaded from specified file in yaml format|
|`--new-name`|<b>`string`</b><br/>A new name of the instance group.|
|`--description`|<b>`string`</b><br/>A new description of the instance group.|
|`--labels`|<b>`key=value`</b><br/>Resource labels as key=value pairs. The existing set of `labels` is completely replaced by the provided set.|
|`--variables`|<b>`key=value`</b><br/>Variables as key=value pairs. The existing set of `variables` is completely replaced by the provided set.|
|`--scale-policy-fixed-scale-size`|<b>`int`</b><br/>[Fixed scaling policy] The number of instances in the instance group.|
|`--scale-policy-auto-scale-min-zone-size`|<b>`int`</b><br/>[Automatic scaling policy] Lower limit for instance count in each zone.|
|`--scale-policy-auto-scale-max-size`|<b>`int`</b><br/>[Automatic scaling policy] Upper limit for total instance count (across all zones).|
|`--service-account-id`|<b>`string`</b><br/>The service account will be used for all API calls, made by the Instance Groups component on behalf of the user.|
|`--service-account-name`|<b>`string`</b><br/>The service account will be used for all API calls, made by the Instance Groups component on behalf of the user.|
|`--template-name`|<b>`string`</b><br/>A name of the instance.|
|`--template-description`|<b>`string`</b><br/>Description of the instance template.|
|`--template-labels`|<b>`instance_template.labels`</b><br/>A list of label KEY=VALUE pairs to add. The existing set of instance_template.labels is completely replaced by the provided set.|
|`--template-metadata`|<b>`key=value`</b><br/>The metadata key=value pairs assigned to this instance template. This includes custom metadata and predefined keys. The existing set of `instance_template.metadata` is completely replaced by the provided set.|
|`--template-metadata-files`|<b>`instance_template.metadata`</b><br/>Same as --template-metadata except that the value for the entry will be read from a local file. The existing set of instance_template.metadata is completely replaced by the provided set.|
|`--template-memory`|<b>`int`</b><br/>The amount of memory available to the instance, specified in bytes.|
|`--template-cores`|<b>`int`</b><br/>The number of cores available to the instance.|
|`--template-core-fraction`|<b>`int`</b><br/>If provided, specifies baseline performance for a core in percent.|
|`--template-gpus`|<b>`int`</b><br/>The number of GPUs available to the instance.|
|`--template-platform`|<b>`string`</b><br/>ID of the hardware platform configuration for the instance.|
|`--template-placement-group`|<b>`string`</b><br/>Identifier of placement group|
|`--template-service-account-id`|<b>`string`</b><br/>Service account ID for the instance.|
|`--template-service-account-name`|<b>`string`</b><br/>Service account NAME for the instance.|

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
