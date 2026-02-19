---
editable: false
noIndex: true
---

# yc beta organization-manager federation group-mapping update

Updates an existing group mapping for a federation
Errors:
- if federation is not found
In case of any error, no changes are applied to existing group mapping
This call is idempotent. The following actions do nothing:
- enabling when already enabled
- disabling when disabled
Such parts of request will be ignored. Others will be applied.

#### Command Usage

Syntax:

`yc beta organization-manager federation group-mapping update <FEDERATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--enabled` | A new state of synchronization to update (if mentioned in update_mask). ||
|| `--federation-id` | `string`

Federation the group mapping update is requested ||
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