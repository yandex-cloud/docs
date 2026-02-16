---
editable: false
sourcePath: en/_cli-ref/cli-ref/kms/cli-ref/symmetric-key/update.md
---

# yc kms symmetric-key update

Update the specified symmetric key

#### Command Usage

Syntax:

`yc kms symmetric-key update <SYMMETRIC-KEY> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Symmetric key id. ||
|| `--name` | `string`

Symmetric key name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name of a symmetric key. ||
|| `--description` | `string`

New description of a symmetric key. ||
|| `--status` | `string`

New status of a symmetric key. Values: 'creating', 'active', 'inactive' ||
|| `--labels` | `key=value[,key=value...]`

A list of new label KEY=VALUE pairs to update. ||
|| `--default-algorithm` | `string`

New default symmetric key version algorithm. Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm', 'gost-r-3412-2015-k' ||
|| `--rotation-period` | `duration`

New rotation period for symmetric key version. ||
|| `--deletion-protection` | Inhibits deletion of a symmetric key. ||
|| `--no-deletion-protection` | Allows deletion of a symmetric key. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#