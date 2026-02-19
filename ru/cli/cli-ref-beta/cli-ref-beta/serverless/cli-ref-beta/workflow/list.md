---
editable: false
noIndex: true
---

# yc beta serverless workflow list

Retrieves list of Workflows in specified folder.

#### Command Usage

Syntax:

`yc beta serverless workflow list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters functions listed in the response. The expression must specify: 1. The field name. Currently filtering can only be applied to following fields: name, created_at. 2. An '=' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression 'a-z?'. Example of a filter: 'name=my-workflow'. ||
|| `--folder-id` | `string`

ID of the folder to list Workflows in. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than 'pageSize', the service returns a [ListWorkflowsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'pageToken' to the [ListWorkflowsResponse.next_page_token] returned by a previous list request. ||
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