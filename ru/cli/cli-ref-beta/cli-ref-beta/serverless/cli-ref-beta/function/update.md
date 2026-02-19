---
editable: false
noIndex: true
---

# yc beta serverless function update

Updates the specified function.

#### Command Usage

Syntax:

`yc beta serverless function update <FUNCTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description for the function. ||
|| `--function-id` | `string`

ID of the function to update. To get a function ID make a [FunctionService.List] request. ||
|| `--labels` | `map<string><string>`

Function labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [FunctionService.Get] request. ||
|| `--name` | `string`

New name for the function. The name must be unique within the folder. ||
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