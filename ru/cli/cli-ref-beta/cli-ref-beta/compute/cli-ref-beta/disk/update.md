---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/disk/update.md
---

# yc beta compute disk update

Updates the specified disk.

#### Command Usage

Syntax: 

`yc beta compute disk update <DISK-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the disk.|
|`--disk-id`|<b>`string`</b><br/>ID of the Disk resource to update. To get the disk ID use a [DiskService.List] request.|
|`--disk-placement-policy`|<b>`shorthand/json`</b><br/>Placement policy configuration.<br/>Shorthand Syntax:<br/>{<br/>placement-group-id = str,<br/>placement-group-partition = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"placement-group-id": "str",<br/>"placement-group-partition": "int"<br/>}"<br/>Fields:<br/>placement-group-id -> (string)<br/>Placement group ID.<br/>placement-group-partition -> (int)|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set.|
|`--name`|<b>`string`</b><br/>Name of the disk.|
|`--size`|<b>`int`</b><br/>Size of the disk, specified in bytes.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
