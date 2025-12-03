---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/attach-filesystem.md
---

# yc beta compute instance attach-filesystem

Attaches the filesystem to the instance.

#### Command Usage

Syntax: 

`yc beta compute instance attach-filesystem <INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--attached-filesystem-spec`|<b>`shorthand/json`</b><br/>Filesystem to attach to the instance.<br/><br/>Example:|
|`--attached-filesystem-spec`|<b>`device-name=value,`</b><br/>filesystem-id=value, mode=READ_ONLY<br/><br/>Shorthand Syntax:<br/>{device-name=str, filesystem-id=str, mode=READ_ONLY\|READ_WRITE}<br/>Fields:<br/>device-name    string                      — Name of the device representing the filesystem on the instance.<br/><br/>The name should be used for referencing the filesystem from within the instance<br/>when it's being mounted, resized etc.<br/><br/>If not specified, a random value will be generated.<br/>filesystem-id  string                      — ID of the filesystem that should be attached.<br/>mode           enum<READ_ONLY\|READ_WRITE>  — Mode of access to the filesystem that should be attached.<br/>|
|`--instance-id`|<b>`string`</b><br/>ID of the instance to attach the filesystem to.<br/><br/>To get the instance ID, make a [InstanceService.List] request.|
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
