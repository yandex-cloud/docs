---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/cluster/list.md
---

# yc beta managed-mysql cluster list

Retrieves the list of clusters in a folder.

#### Command Usage

Syntax: 

`yc beta managed-mysql cluster list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that selects clusters listed in the response.<br/><br/>The expression must specify:<br/>1. The field name. Currently you can only use filtering with the [Cluster.name] field.<br/>2. An '=' operator.<br/>3. The value in double quotes ('"'). Must be 1-63 characters long and match the regular expression '[a-zA-Z0-9_-]+'.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list clusters in.<br/><br/>To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return.<br/><br/>If the number of available results is larger than [page_size], the API returns a [ListClustersResponse.next_page_token] that can be used to get the next page of results in the subsequent [ClusterService.List] requests.|
|`--page-token`|<b>`string`</b><br/>Page token that can be used to iterate through multiple pages of results.<br/><br/>To get the next page of results, set [page_token] to the [ListClustersResponse.next_page_token] returned by the previous [ClusterService.List] request.|

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
