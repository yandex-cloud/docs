---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/function/list-versions.md
---

# yc beta serverless function list-versions

Retrieves the list of versions for the specified function, or of all function versions  in the specified folder.

#### Command Usage

Syntax: 

`yc beta serverless function list-versions`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently filtering can only be applied to the [Version.status] and [Version.runtime] fields. 2. An '=' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'. Example of a filter: 'status="ACTIVE"'.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than 'pageSize', the service returns a [ListFunctionsVersionsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'pageToken' to the [ListFunctionsVersionsResponse.next_page_token] returned by a previous list request.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list function versions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--function-id`|<b>`string`</b><br/>ID of the function to list versions for. To get a function ID use a [FunctionService.List] request.|

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
