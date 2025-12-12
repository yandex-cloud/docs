---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/filesystem/update.md
---

# yc beta compute filesystem update

Updates the specified filesystem.

#### Command Usage

Syntax: 

`yc beta compute filesystem update <FILESYSTEM-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description of the filesystem.|
|`--filesystem-id`|<b>`string`</b><br/>ID of the filesystem to update. To get the filesystem ID, make a [FilesystemService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>New filesystem labels as 'key:value' pairs. For details about the concept, see documentation. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [FilesystemService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name of the filesystem. The name must be unique within the folder.|
|`--size`|<b>`int`</b><br/>Size of the filesystem, specified in bytes.|
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
