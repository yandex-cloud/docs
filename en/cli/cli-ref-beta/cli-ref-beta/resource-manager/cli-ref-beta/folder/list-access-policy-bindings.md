---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/resource-manager/cli-ref-beta/folder/list-access-policy-bindings.md
---

# yc beta resource-manager folder list-access-policy-bindings

Returns list of access policy bindings for the folder.

#### Command Usage

Syntax: 

`yc beta resource-manager folder list-access-policy-bindings <RESOURCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned.<br/>If the number of available results is larger than [page_size], the service returns a<br/>[ListAccessPolicyBindingsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. Set [page_token] to the<br/>[ListAccessPolicyBindingsResponse.next_page_token]<br/>returned by a previous list request to get the next page of results.|
|`--resource-id`|<b>`string`</b><br/>ID of the resource to list access policy bindings for.<br/><br/>To get the resource ID, use a corresponding List request.<br/>For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List] request to get the Cloud resource ID.|

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
