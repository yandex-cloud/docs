---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/kms/cli-ref-beta/symmetric-key/update.md
---

# yc beta kms symmetric-key update

Updates the specified symmetric KMS key.

#### Command Usage

Syntax: 

`yc beta kms symmetric-key update <KEY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--default-algorithm`|<b>`enum`</b><br/>Default encryption algorithm to be used with new versions of the symmetric KMS key. Possible Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm', 'gost-r-3412-2015-k'|
|`--deletion-protection`|Flag that inhibits deletion of the symmetric KMS key|
|`--description`|<b>`string`</b><br/>New description for the symmetric KMS key.|
|`--key-id`|<b>`string`</b><br/>ID of the symmetric KMS key to update.<br/>To get the ID of a symmetric KMS key use a [SymmetricKeyService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the symmetric KMS key as 'key:value' pairs. Maximum 64 per key.|
|`--name`|<b>`string`</b><br/>New name for the symmetric KMS key.|
|`--rotation-period`|<b>`duration`</b><br/>Time period between automatic symmetric KMS key rotations. (duration, e.g. 30s, 5m10s)|
|`--status`|<b>`enum`</b><br/>New status for the symmetric KMS key.<br/>Using the [SymmetricKeyService.Update] method you can only set ACTIVE or INACTIVE status. Possible Values: 'creating', 'active', 'inactive'|
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
