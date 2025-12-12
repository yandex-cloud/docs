---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/quota-manager/cli-ref-beta/quota-request/list.md
---

# yc beta quota-manager quota-request list

Retrieves the list of quota requests in the specified resource.

#### Command Usage

Syntax: 

`yc beta quota-manager quota-request list`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [quotaRequest.status] field. 2. An '=' operator. 3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListQuotaRequestsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListQuotaRequestsResponse.next_page_token] returned by a previous list request.|
|`--resource`|<b>`shorthand/json`</b><br/>Resource to list quota requests in.<br/>Shorthand Syntax:<br/>{<br/>id = str,<br/>type = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"id": "str",<br/>"type": "str"<br/>}"<br/>Fields:<br/>id -> (string)<br/>The id if the resource.<br/>type -> (string)<br/>The type of the resource, e.g. resource-manager.cloud, billing.account.|

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
