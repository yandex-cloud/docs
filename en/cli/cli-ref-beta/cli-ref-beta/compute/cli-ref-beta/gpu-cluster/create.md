---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/gpu-cluster/create.md
---

# yc beta compute gpu-cluster create

Creates a GPU cluster in the specified folder.

#### Command Usage

Syntax: 

`yc beta compute gpu-cluster create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the GPU cluster.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a GPU cluster in. To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--interconnect-type`|<b>`enum`</b><br/>Type of interconnect to use for this GPU cluster. Possible Values: 'infiniband'|
|`--labels`|<b>`stringToString`</b><br/>GPU cluster labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the GPU cluster. The name must be unique within the folder.|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the GPU cluster resides. To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List] request.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
