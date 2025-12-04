---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/datatransfer/cli-ref-beta/endpoint/list.md
---

# yc beta datatransfer endpoint list

Lists endpoints in the specified folder.

#### Command Usage

Syntax: 

`yc beta datatransfer endpoint list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--folder-id`|<b>`string`</b><br/>Identifier of the folder containing the endpoints to be listed.|
|`--page-size`|<b>`int`</b><br/>The maximum number of endpoints to be sent in the response message. If the<br/>folder contains more endpoints than 'page_size', 'next_page_token' will be<br/>included<br/>in the response message. Include it into the subsequent 'ListEndpointRequest' to<br/>fetch the next page. Defaults to '100' if not specified. The maximum allowed<br/>value<br/>for this field is '1000'.|
|`--page-token`|<b>`string`</b><br/>Opaque value identifying the endpoints page to be fetched. Should be empty in<br/>the first 'ListEndpointsRequest'. Subsequent requests should have this field<br/>filled<br/>with the 'next_page_token' from the previous 'ListEndpointsResponse'.|

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
