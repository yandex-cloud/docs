---
editable: false
noIndex: true
---

# yc beta serverless function list-tag-history

Returns the log of tags assigned to versions of the specified function.

#### Command Usage

Syntax:

`yc beta serverless function list-tag-history <FUNCTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effective_from] and [FunctionTagHistoryRecord.effective_to] fields. 2. An '=' or '>' or '&lt;' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'. For example, 'effective_to&gt;2021-01-01T12:00:00Z'. ||
|| `--function-id` | `string`

ID of the function to retrieve tag history for. To get a function ID, make a [FunctionService.List] request. ||
|| `--page-size` | `int`

The maximum number of results per page that should be returned. If the number of available results is larger than 'pageSize', the service returns a [ListFunctionOperationsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'pageToken' to the [ListFunctionOperationsResponse.next_page_token] returned by a previous list request. ||
|| `--tag` | `string`

Specific tag that history should be limited to. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#