---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/key/list.md
---

# yc beta iam key list

Retrieves the list of Key resources for the specified service account.

#### Command Usage

Syntax: 

`yc beta iam key list <SERVICE-ACCOUNT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--format`|<b>`enum`</b><br/>Output format of the key. Possible Values: 'pem-file'|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListKeysResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListKeysResponse.next_page_token] returned by a previous list request.|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to list key pairs for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request. If not specified, it defaults to the subject that made the request.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
