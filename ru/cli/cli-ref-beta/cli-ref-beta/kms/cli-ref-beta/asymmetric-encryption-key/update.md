---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/kms/cli-ref-beta/asymmetric-encryption-key/update.md
---

# yc beta kms asymmetric-encryption-key update

Updates the specified asymmetric KMS key.

#### Command Usage

Syntax: 

`yc beta kms asymmetric-encryption-key update <KEY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--deletion-protection`|Flag that inhibits deletion of the asymmetric KMS key|
|`--description`|<b>`string`</b><br/>New description for the asymmetric KMS key.|
|`--key-id`|<b>`string`</b><br/>ID of the asymmetric KMS key to update.<br/>To get the ID of a asymmetric KMS key use a [AsymmetricEncryptionKeyService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the asymmetric KMS key as 'key:value' pairs. Maximum 64 per key.|
|`--name`|<b>`string`</b><br/>New name for the asymmetric KMS key.|
|`--status`|<b>`enum`</b><br/>New status for the asymmetric KMS key.<br/>Using the [AsymmetricEncryptionKeyService.Update] method you can only set ACTIVE or INACTIVE status. Possible Values: 'creating', 'active', 'inactive'|
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
