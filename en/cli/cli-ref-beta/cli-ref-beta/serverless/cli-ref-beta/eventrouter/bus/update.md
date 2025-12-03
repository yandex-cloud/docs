---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/bus/update.md
---

# yc beta serverless eventrouter bus update

Updates the specified bus.

#### Command Usage

Syntax: 

`yc beta serverless eventrouter bus update <BUS-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--bus-id`|<b>`string`</b><br/>ID of the bus to update.|
|`--deletion-protection`|New flag that disallow deletion of the bus.|
|`--description`|<b>`string`</b><br/>New description of the bus.|
|`--labels`|<b>`stringToString`</b><br/>New labels of the bus.|
|`--log-options`|<b>`shorthand/json`</b><br/>New options for logging from the bus.<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum log entry level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — Entry will be written to log group resolved by ID.<br/>folder-id     string  — Entry will be written to default log group for specified folder.<br/>|
|`--logging-enabled`|Is logging from the bus enabled.|
|`--name`|<b>`string`</b><br/>New name of the bus.|
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
