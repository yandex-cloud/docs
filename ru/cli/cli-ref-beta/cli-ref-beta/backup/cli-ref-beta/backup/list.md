---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/backup/cli-ref-beta/backup/list.md
---

# yc beta backup backup list

List backups using filters.

#### Command Usage

Syntax: 

`yc beta backup backup list`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>Filter list by various parameters. Supported parameters are: * created_at Supported logic operators: * AND|
|`--order-by`|<b>`string`</b><br/>By which column the listing should be ordered and in which direction, format is "createdAt desc". "createdAt desc" if omitted.|
|`--page-size`|<b>`int`</b><br/>Number of results per page.|
|`--page-token`|<b>`string`</b><br/>Token for the results page. Not allowed to use if listing is performed by specific policy ID.|
|`--type`|<b>`enum`</b><br/>Type of resource. Could be compute VM or baremetal server. Possible Values: 'compute', 'bms', 'external-vm', 'external-server'|
|`--compute-instance-id`|<b>`string`</b><br/>List backups that belongs to specific Compute Cloud instance.|
|`--archive`|<b>`shorthand/json`</b><br/>List backups that belongs to specific archive of specific folder.<br/>Shorthand Syntax:<br/>{<br/>archive-id = str,<br/>folder-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-id": "str",<br/>"folder-id": "str"<br/>}"<br/>Fields:<br/>archive-id -> (string)<br/>Archive ID.<br/>folder-id -> (string)<br/>Folder ID.|
|`--folder-id`|<b>`string`</b><br/>List backups that belongs to specific folder.|
|`--instance-policy`|<b>`shorthand/json`</b><br/>List backups that belongs to specific instance and policy at the same time.<br/>Shorthand Syntax:<br/>{<br/>compute-instance-id = str,<br/>policy-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"compute-instance-id": "str",<br/>"policy-id": "str"<br/>}"<br/>Fields:<br/>compute-instance-id -> (string)<br/>Compute Cloud instance ID.<br/>policy-id -> (string)<br/>Policy ID.|
|`--resource-id`|<b>`string`</b><br/>List backups by specific resource ID.|
|`--policy-id`|<b>`string`</b><br/>List backups by specific policy ID.|
|`--backup`|<b>`shorthand/json`</b><br/>List backups by specific backup ID.<br/>Shorthand Syntax:<br/>{<br/>backup-id = str,<br/>folder-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"backup-id": "str",<br/>"folder-id": "str"<br/>}"<br/>Fields:<br/>backup-id -> (string)<br/>folder-id -> (string)|

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
