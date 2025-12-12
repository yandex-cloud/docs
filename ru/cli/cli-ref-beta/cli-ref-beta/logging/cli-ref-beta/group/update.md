---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/group/update.md
---

# yc beta logging group update

Updates the specified log group.

#### Command Usage

Syntax: 

`yc beta logging group update <LOG-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--data-stream`|<b>`string`</b><br/>If specified, log records will be written to this data stream|
|`--description`|<b>`string`</b><br/>New Description of the log group.|
|`--labels`|<b>`stringToString`</b><br/>New log group labels as 'key:value' pairs.|
|`--log-group-id`|<b>`string`</b><br/>ID of the log group to update. To get a log group ID make a [LogGroupService.List] request.|
|`--name`|<b>`string`</b><br/>New name of the log group. The name must be unique within the folder.|
|`--retention-period`|<b>`duration`</b><br/>New log group entry retention period. Entries will be present in group during this period. If specified, must be non-negative. Empty or zero value is treated as no limit. (duration, e.g. 30s, 5m10s)|
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
