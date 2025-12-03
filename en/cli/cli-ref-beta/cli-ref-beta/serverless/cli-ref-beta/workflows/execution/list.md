---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/workflows/execution/list.md
---

# yc beta serverless workflows execution list

Retrieves list of Workflow executions.

#### Command Usage

Syntax: 

`yc beta serverless workflows execution list <WORKFLOW-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response.<br/><br/>The expression must specify:<br/>1. The field name. Currently filtering can be applied to the following fields: status, started_at, finished_at.<br/>2. Operator: '=', '<' or '>'.<br/>3. The value. Must be sting and match the regular expression '[+:\.-a-z0-9]'.<br/>Examples of a filter: 'status=ERROR', 'created_by=John.Doe'.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned. If the number of available<br/>results is larger than 'pageSize', the service returns a [ListExecutionsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/><br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'pageToken' to the<br/>[ListExecutionsResponse.next_page_token] returned by a previous list request.|
|`--workflow-id`|<b>`string`</b><br/>ID of the Workflow.|

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
