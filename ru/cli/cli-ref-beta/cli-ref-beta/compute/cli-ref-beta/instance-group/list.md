---
editable: false
noIndex: true
---

# yc beta compute instance-group list

Retrieves the list of InstanceGroup resources in the specified folder.

#### Command Usage

Syntax:

`yc beta compute instance-group list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name] field. ||
|| `--folder-id` | `string`

ID of the folder to list instance groups in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListInstanceGroupsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListInstanceGroupsResponse.next_page_token] returned by a previous list request. ||
|| `--view` | `enum`

Defines which information about the Instance template should be returned in the server response. Possible Values: 'basic', 'full' ||
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