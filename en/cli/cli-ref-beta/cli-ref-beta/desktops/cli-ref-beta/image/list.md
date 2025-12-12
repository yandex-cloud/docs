---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/image/list.md
---

# yc beta desktops image list

Lists desktop images in the specified folder.

#### Command Usage

Syntax: 

`yc beta desktops image list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [DesktopImage.name] field. 2. An operator. Can be either '=' or '!=' for single values, 'IN' or 'NOT IN' for lists of values. 3. Value or a list of values to compare against the values of the field.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list desktop images in.|
|`--order-by`|<b>`string`</b><br/>Sorting the list by [DesktopImage.name], [DesktopImage.created_at] and [DesktopImage.status] fields. The default sorting order is ascending.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListDesktopImagesRequest.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListDesktopImagesRequest.next_page_token] returned by a previous list request.|

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
