---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/network/list-route-tables.md
---

# yc beta vpc network list-route-tables

Lists route tables from the specified network.

#### Command Usage

Syntax: 

`yc beta vpc network list-route-tables <NETWORK-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--network-id`|<b>`string`</b><br/>ID of the Network resource to list route tables for.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page that should be returned. If the number of available<br/>results is larger than [page_size],<br/>the service returns a [ListNetworkRouteTablesResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. Set [page_token]<br/>to the [ListNetworkRouteTablesResponse.next_page_token]<br/>returned by a previous list request to get the next page of results.|

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
