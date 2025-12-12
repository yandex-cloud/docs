---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/connector/list-operations.md
---

# yc beta serverless eventrouter connector list-operations

Lists operations for the specified connector.

#### Command Usage

Syntax: 

`yc beta serverless eventrouter connector list-operations <CONNECTOR-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--connector-id`|<b>`string`</b><br/>ID of the connector to list operations for.|
|`--filter`|<b>`string`</b><br/>Supported attributes for filter: description created_at modified_at created_by done|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per response.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the 'next_page_token' returned by a previous list request.|

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
