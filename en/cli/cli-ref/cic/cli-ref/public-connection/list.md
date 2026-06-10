---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cic/cli-ref/public-connection/list/
---

# yc cic public-connection list

Retrieves the list of PublicConnection resources in the specified folder.

#### Command Usage

Syntax:

`yc cic public-connection list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to list publicConnections in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--limit` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListPublicConnectionsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListPublicConnectionsResponse.next_page_token] returned by a previous list request. ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Subnet.name] field. 2. An '=' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'. ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#