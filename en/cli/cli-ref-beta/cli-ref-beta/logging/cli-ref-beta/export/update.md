---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/export/update.md
---

# yc beta logging export update

Updates the specified export.

#### Command Usage

Syntax: 

`yc beta logging export update <EXPORT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New Description of the export.|
|`--export-id`|<b>`string`</b><br/>ID of the export to update. To get a export ID make a [ExportService.List] request.|
|`--group-id`|<b>`string`</b><br/>New logging Group ID logs exported from|
|`--labels`|<b>`stringToString`</b><br/>New export labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>New name of the export. The name must be unique within the folder.|
|`--params`|<b>`shorthand/json`</b><br/>New parameters for logs filtration<br/>Shorthand Syntax:<br/>{<br/>filter = str,<br/>levels = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL,...,<br/>resource-ids = str,...,<br/>resource-types = str,...,<br/>stream-names = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"filter": "str",<br/>"levels": [<br/>"TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL", ...<br/>],<br/>"resource-ids": [<br/>"str", ...<br/>],<br/>"resource-types": [<br/>"str", ...<br/>],<br/>"stream-names": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>filter -> (string)<br/>levels -> ([]int)<br/>resource-ids -> ([]string)<br/>resource-types -> ([]string)<br/>stream-names -> ([]string)|
|`--sink-id`|<b>`string`</b><br/>New logging Sink ID logs exported to|
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
