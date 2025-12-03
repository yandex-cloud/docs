---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/private-endpoint/list.md
---

# yc beta vpc private-endpoint list

Retrieves the list of PrivateEndpoint resources in the specified folder.

#### Command Usage

Syntax: 

`yc beta vpc private-endpoint list`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters PrivateEndpoint listed in the response.<br/><br/>The expression must specify:<br/>1. The field name. Currently you can use filtering only on<br/>[PrivateEndpoint.name] field.<br/>2. An '=' operator.<br/>3. The value in double quotes ('"'). Must be 3-63 characters long and match<br/>the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'. Example of a filter:<br/>'name=my-private-endpoint'.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of<br/>available results is larger than 'page_size', the service returns a<br/>[ListPrivateEndpointsResponse.next_page_token] that can be used to get the<br/>next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the<br/>[ListPrivateEndpointsResponse.next_page_token] returned by a previous list<br/>request.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list private endpoints in.<br/><br/>To get the folder ID use a<br/>[yandex.cloud.resourcemanager.v1.FolderService.List] request.|

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
