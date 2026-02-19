---
editable: false
noIndex: true
---

# yc beta kms symmetric-key update

Updates the specified symmetric KMS key.

#### Command Usage

Syntax:

`yc beta kms symmetric-key update <KEY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--default-algorithm` | `enum`

Default encryption algorithm to be used with new versions of the symmetric KMS key. Possible Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm', 'gost-r-3412-2015-k' ||
|| `--deletion-protection` | Flag that inhibits deletion of the symmetric KMS key ||
|| `--description` | `string`

New description for the symmetric KMS key. ||
|| `--key-id` | `string`

ID of the symmetric KMS key to update. To get the ID of a symmetric KMS key use a [SymmetricKeyService.List] request. ||
|| `--labels` | `map<string><string>`

Custom labels for the symmetric KMS key as 'key:value' pairs. Maximum 64 per key. ||
|| `--name` | `string`

New name for the symmetric KMS key. ||
|| `--rotation-period` | `duration`

Time period between automatic symmetric KMS key rotations. (duration, e.g. 30s, 5m10s) ||
|| `--status` | `enum`

New status for the symmetric KMS key. Using the [SymmetricKeyService.Update] method you can only set ACTIVE or INACTIVE status. Possible Values: 'creating', 'active', 'inactive' ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#