---
editable: false
noIndex: true
---

# yc beta logging group update

Updates the specified log group.

#### Command Usage

Syntax:

`yc beta logging group update <LOG-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--data-stream` | `string`

If specified, log records will be written to this data stream ||
|| `--description` | `string`

New Description of the log group. ||
|| `--labels` | `map<string><string>`

New log group labels as 'key:value' pairs. ||
|| `--log-group-id` | `string`

ID of the log group to update. To get a log group ID make a [LogGroupService.List] request. ||
|| `--name` | `string`

New name of the log group. The name must be unique within the folder. ||
|| `--retention-period` | `duration`

New log group entry retention period. Entries will be present in group during this period. If specified, must be non-negative. Empty or zero value is treated as no limit. (duration, e.g. 30s, 5m10s) ||
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