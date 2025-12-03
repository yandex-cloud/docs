---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/service-control/get.md
---

# yc beta iam service-control get

Returns the Service information in the specified resource container.

#### Command Usage

Syntax: 

`yc beta iam service-control get <SERVICE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--resource`|<b>`shorthand/json`</b><br/>Resource container to get a service information in.<br/><br/>It is supported only resource-manager.cloud resource container now.<br/><br/>Example:|
|`--resource`|<b>`id=value,`</b><br/>type=value<br/><br/>Shorthand Syntax:<br/>{id=str, type=str}<br/>Fields:<br/>id    string  required  — ID of the resource.<br/>type  string  required  — The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.<br/>|
|`--service-id`|<b>`string`</b><br/>ID of the Service.|

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
