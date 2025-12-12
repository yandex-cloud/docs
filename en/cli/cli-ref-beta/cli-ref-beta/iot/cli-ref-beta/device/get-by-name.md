---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/device/get-by-name.md
---

# yc beta iot device get-by-name



#### Command Usage

Syntax: 

`yc beta iot device get-by-name <REGISTRY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--device-name`|<b>`string`</b><br/>Name of the device to return. To get a device name make a [DeviceService.List] request.|
|`--device-view`|<b>`enum`</b><br/>Specifies which parts of the device resource should be returned in the response. Possible Values: 'basic', 'full'|
|`--registry-id`|<b>`string`</b><br/>ID of the registry to get device. To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List] request.|

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
