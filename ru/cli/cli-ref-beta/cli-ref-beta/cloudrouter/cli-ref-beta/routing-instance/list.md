---
editable: false
noIndex: true
---

# yc beta cloudrouter routing-instance list

Retrieves the list of RoutingInstance resources in the specified folder.

#### Command Usage

Syntax:

`yc beta cloudrouter routing-instance list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [RoutingInstance.name] field. 2. An '=' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'. ||
|| `--folder-id` | `string`

ID of the folder to list RoutingInstance resources. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListRoutingInstancesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListRoutingInstanceResponse.next_page_token] returned by a previous list request. ||
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