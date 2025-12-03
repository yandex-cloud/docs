---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/mcp-gateway/list-operations.md
---

# yc beta serverless mcp-gateway list-operations

Lists operations for the specified MCP Gateway.

#### Command Usage

Syntax: 

`yc beta serverless mcp-gateway list-operations <MCP-GATEWAY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response.<br/><br/>The expression must specify:<br/>1. The field name. Currently filtering can be applied to the [operation.Operation.done], [operation.Operation.created_by] field.<br/>2. An '=' operator.<br/>3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'.<br/>Examples of a filter: 'done=false', 'created_by='John.Doe''.|
|`--mcp-gateway-id`|<b>`string`</b><br/>ID of the MCP Gateway to list operations for.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned. If the number of available<br/>results is larger than 'pageSize', the service returns a [ListOperationsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/><br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'pageToken' to the<br/>[ListOperationsResponse.next_page_token] returned by a previous list request.|

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
