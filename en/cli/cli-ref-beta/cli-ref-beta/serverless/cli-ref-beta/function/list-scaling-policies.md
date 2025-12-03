---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/function/list-scaling-policies.md
---

# yc beta serverless function list-scaling-policies

Lists existing scaling policies for specified function

#### Command Usage

Syntax: 

`yc beta serverless function list-scaling-policies <FUNCTION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--function-id`|<b>`string`</b><br/>ID of the function to retrieve scaling policies for.<br/><br/>To get a function ID, make a [FunctionService.List] request.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned. If the number of available<br/>results is larger than 'pageSize', the service returns a [ListScalingPoliciesResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/><br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'pageToken' to the<br/>[ListScalingPoliciesResponse.next_page_token] returned by a previous list request.|

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
