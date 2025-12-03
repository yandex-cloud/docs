---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/sink/update.md
---

# yc beta logging sink update

Updates the specified sink.

#### Command Usage

Syntax: 

`yc beta logging sink update <SINK-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New Description of the sink.|
|`--labels`|<b>`stringToString`</b><br/>New sink labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>New name of the sink.<br/>The name must be unique within the folder.|
|`--service-account-id`|<b>`string`</b><br/>new service account to use for logs writing to the sink.|
|`--sink-id`|<b>`string`</b><br/>ID of the sink to update.<br/><br/>To get a sink ID make a [SinkService.List] request.|
|`--yds`|<b>`shorthand/json`</b><br/>Yandex data stream<br/><br/>Example:<br/>--yds stream-name=value<br/><br/>Shorthand Syntax:<br/>{stream-name=str}<br/>Fields:<br/>stream-name  string  — Fully qualified name of data stream<br/>|
|`--s3`|<b>`shorthand/json`</b><br/>Object storage<br/><br/>Example:|
|`--s3`|<b>`bucket=value,`</b><br/>prefix=value<br/><br/>Shorthand Syntax:<br/>{bucket=str, prefix=str}<br/>Fields:<br/>bucket  string  — Object storage bucket<br/>prefix  string  — Prefix to use for saved log object names<br/>|
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
