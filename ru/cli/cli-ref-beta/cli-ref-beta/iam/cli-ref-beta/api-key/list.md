---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/api-key/list.md
---

# yc beta iam api-key list

Retrieves the list of API keys for the specified service account.

#### Command Usage

Syntax: 

`yc beta iam api-key list <SERVICE-ACCOUNT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than [page_size],<br/>the service returns a [ListApiKeysResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token]<br/>to the [ListApiKeysResponse.next_page_token]<br/>returned by a previous list request.|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to list API keys for.<br/>To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request.<br/>If not specified, it defaults to the subject that made the request.|

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
