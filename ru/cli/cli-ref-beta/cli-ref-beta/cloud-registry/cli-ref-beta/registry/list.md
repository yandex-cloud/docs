---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloud-registry/cli-ref-beta/registry/list.md
---

# yc beta cloud-registry registry list

Retrieves the list of Registry resources in the specified folder.

#### Command Usage

Syntax: 

`yc beta cloud-registry registry list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list registries in.<br/><br/>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than [page_size],<br/>the service returns a [ListRegistriesResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 10.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the<br/>[ListRegistriesResponse.next_page_token] returned by a previous list request.|

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
