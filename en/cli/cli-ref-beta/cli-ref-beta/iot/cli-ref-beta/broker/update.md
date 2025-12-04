---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/broker/update.md
---

# yc beta iot broker update

Updates the specified broker.

#### Command Usage

Syntax: 

`yc beta iot broker update <BROKER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--broker-id`|<b>`string`</b><br/>ID of the broker to update.<br/><br/>To get a broker ID make a [BrokerService.List] request.|
|`--description`|<b>`string`</b><br/>Description of the broker.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.<br/><br/>Existing set of 'labels' is completely replaced by the provided set.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging broker events<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>disabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, disabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>disabled     bool                                     — Is logging from broker disabled.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum log entry level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — Entry should be written to log group resolved by ID.<br/>folder-id     string  — Entry should be written to default log group for specified folder.<br/>|
|`--name`|<b>`string`</b><br/>Name of the broker. The name must be unique within the folder.|
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
