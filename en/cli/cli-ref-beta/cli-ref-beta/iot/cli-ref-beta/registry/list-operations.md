---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/registry/list-operations.md
---

# yc beta iot registry list-operations

Lists operations for the specified registry.

#### Command Usage

Syntax: 

`yc beta iot registry list-operations <REGISTRY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Registry.name] field.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned. If the number of available results is larger than 'page_size', the service returns a [ListRegistryOperationsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the [ListRegistryOperationsResponse.next_page_token] returned by a previous list request.|
|`--registry-id`|<b>`string`</b><br/>ID of the registry to list operations for.|

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
