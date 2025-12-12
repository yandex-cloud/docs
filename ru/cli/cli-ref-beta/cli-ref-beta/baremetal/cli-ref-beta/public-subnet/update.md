---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/public-subnet/update.md
---

# yc beta baremetal public-subnet update

Updates the specified public subnet.

#### Command Usage

Syntax: 

`yc beta baremetal public-subnet update <PUBLIC-SUBNET-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the public subnet.|
|`--hardware-pool-ids`|<b>`strings`</b><br/>IDs of the hardware pool that the public subnet belongs to. To get a list of available hardware pools, use the [HardwarePoolService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set.|
|`--name`|<b>`string`</b><br/>Name of the public subnet. The name must be unique within the folder.|
|`--public-subnet-id`|<b>`string`</b><br/>ID of the PublicSubnet resource to update. To get the public subnet ID, use a [PublicSubnetService.List] request.|
|`--type`|<b>`enum`</b><br/>Possible Values: 'dedicated', 'ephemeral'|
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
