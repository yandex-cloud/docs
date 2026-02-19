---
editable: false
noIndex: true
---

# yc beta serverless eventrouter connector list-operations

Lists operations for the specified connector.

#### Command Usage

Syntax:

`yc beta serverless eventrouter connector list-operations <CONNECTOR-ID>`

#### Flags

#|
||Flag | Description ||
|| `--connector-id` | `string`

ID of the connector to list operations for. ||
|| `--filter` | `string`

Supported attributes for filter: description created_at modified_at created_by done ||
|| `--page-size` | `int`

The maximum number of results per response. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the 'next_page_token' returned by a previous list request. ||
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