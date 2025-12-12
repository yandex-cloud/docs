---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/log-reading/read.md
---

# yc beta logging log-reading read

Read log entries from the specified log group.

#### Command Usage

Syntax: 

`yc beta logging log-reading read`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the [ReadResponse.next_page_token] or [ReadResponse.previous_page_token] returned by a previous read request.|
|`--criteria`|<b>`shorthand/json`</b><br/>Read criteria. See [Criteria] for details.<br/>Shorthand Syntax:<br/>{<br/>filter = str,<br/>levels = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL,...,<br/>log-group-id = str,<br/>max-response-size = int,<br/>page-size = int,<br/>resource-ids = str,...,<br/>resource-types = str,...,<br/>since = timestamp,<br/>stream-names = str,...,<br/>until = timestamp<br/>}<br/>JSON Syntax:<br/>"{<br/>"filter": "str",<br/>"levels": [<br/>"TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL", ...<br/>],<br/>"log-group-id": "str",<br/>"max-response-size": "int",<br/>"page-size": "int",<br/>"resource-ids": [<br/>"str", ...<br/>],<br/>"resource-types": [<br/>"str", ...<br/>],<br/>"since": "timestamp",<br/>"stream-names": [<br/>"str", ...<br/>],<br/>"until": "timestamp"<br/>}"<br/>Fields:<br/>filter -> (string)<br/>Filter expression. For details about filtering, see documentation.<br/>levels -> ([]int)<br/>List of log levels to limit log entries to. Empty list disables filter.<br/>log-group-id -> (string)<br/>ID of the log group to return. To get a log group ID make a [LogGroupService.List] request.<br/>max-response-size -> (int)<br/>Limits response to maximum size in bytes. Prevents gRPC resource exhaustion. Default value for max response size is 3.5 MiB<br/>page-size -> (int)<br/>The maximum number of results per page to return.<br/>resource-ids -> ([]string)<br/>List of resource IDs to limit log entries to. Empty list disables filter.<br/>resource-types -> ([]string)<br/>List of resource types to limit log entries to. Empty list disables filter.<br/>since -> (timestamp)<br/>Lower bound of log entries timestamps.<br/>stream-names -> ([]string)<br/>List of stream names to limit log entries to. Empty list disables filter.<br/>until -> (timestamp)<br/>Upper bound of log entries timestamps.|

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
