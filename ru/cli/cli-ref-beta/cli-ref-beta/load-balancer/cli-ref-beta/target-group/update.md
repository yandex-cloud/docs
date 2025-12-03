---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/load-balancer/cli-ref-beta/target-group/update.md
---

# yc beta load-balancer target-group update

Updates the specified target group.

#### Command Usage

Syntax: 

`yc beta load-balancer target-group update <TARGET-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the target group.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.<br/><br/>The existing set of '' labels '' is completely replaced with the provided set.|
|`--name`|<b>`string`</b><br/>Name of the target group.<br/>The name must be unique within the folder.|
|`--target-group-id`|<b>`string`</b><br/>ID of the TargetGroup resource to update.<br/>To get the target group ID, use a [TargetGroupService.List] request.|
|`--targets`|<b>`shorthand/json`</b><br/>A new list of targets for this target group.<br/><br/>Example:|
|`--targets`|<b>`[{address=value,`</b><br/>subnet-id=value}]<br/><br/>Shorthand Syntax:<br/>[{address=str, subnet-id=str},...]<br/>Fields:<br/>address    string  — IP address of the target.<br/>subnet-id  string  — ID of the subnet that targets are connected to.<br/>All targets in the target group must be connected to the same subnet within a single availability zone.<br/>|
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
