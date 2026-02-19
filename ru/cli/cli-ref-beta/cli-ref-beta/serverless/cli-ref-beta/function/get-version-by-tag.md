---
editable: false
noIndex: true
---

# yc beta serverless function get-version-by-tag

Returns all versions with the specified tag.
To get the list of all available versions, make a [ListVersions] request.

#### Command Usage

Syntax:

`yc beta serverless function get-version-by-tag <FUNCTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--function-id` | `string`

ID of the function whose versions should be listed. To get a function ID use a [FunctionService.List] request. ||
|| `--tag` | `string`

Version tag. To get the history of version tags make a [FunctionService.ListTagHistory] request. ||
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