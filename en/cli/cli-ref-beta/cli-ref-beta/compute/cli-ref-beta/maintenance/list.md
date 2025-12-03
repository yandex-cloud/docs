---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/maintenance/list.md
---

# yc beta compute maintenance list

Lists maintenances by conditions, specified in request.

#### Command Usage

Syntax: 

`yc beta compute maintenance list`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>Filter list by various fields.<br/>Supported fields: ["status", "resource_type", "resource_id"]|
|`--order-by`|<b>`string`</b><br/>By which field the listing should be ordered and in which direction,<br/>format is "created_at desc". The default sorting order is ascending.<br/>Supported fields: ["created_at", "start_scheduled_at", "started_at"].|
|`--page-size`|<b>`int`</b><br/>The maximum number of maintenances to return per response.|
|`--page-token`|<b>`string`</b><br/>Token to retrieve the next page of results. Omitted on the first request.|
|`--cloud-id`|<b>`string`</b><br/>Cloud ID for the resources.|
|`--folder-id`|<b>`string`</b><br/>Folder ID for the resources.|
|`--resource-id`|<b>`string`</b><br/>Resource ID of the target resource.|

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
