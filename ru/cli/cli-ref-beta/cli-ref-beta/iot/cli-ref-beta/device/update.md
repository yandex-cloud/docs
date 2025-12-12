---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/device/update.md
---

# yc beta iot device update

Updates the specified device.

#### Command Usage

Syntax: 

`yc beta iot device update <DEVICE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the device.|
|`--device-id`|<b>`string`</b><br/>ID of the device to update. To get a device ID make a [DeviceService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the device. The name must be unique within the registry.|
|`--topic-aliases`|<b>`stringToString`</b><br/>Alias of a device topic. Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. 'my/custom/alias' match to '\$device/{id}/events'.|
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
