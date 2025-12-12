---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/quota-manager/cli-ref-beta/quota-limit/list.md
---

# yc beta quota-manager quota-limit list

Retrieves the list of quota limits for a given service.

#### Command Usage

Syntax: 

`yc beta quota-manager quota-limit list`

#### Flags

| Flag | Description |
|----|----|
|`--page-size`|<b>`int`</b><br/>The maximum number of quota limits to return per response.|
|`--page-token`|<b>`string`</b><br/>Token to retrieve the next page of results. Omitted on the first request.|
|`--resource`|<b>`shorthand/json`</b><br/>The resource for which quota limits are being listed.<br/>Shorthand Syntax:<br/>{<br/>id = str,<br/>type = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"id": "str",<br/>"type": "str"<br/>}"<br/>Fields:<br/>id -> (string)<br/>The id if the resource.<br/>type -> (string)<br/>The type of the resource, e.g. resource-manager.cloud, billing.account.|
|`--service`|<b>`string`</b><br/>The service for which quota limits are being requested.|

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
