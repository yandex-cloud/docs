---
editable: false
noIndex: true
---

# yc beta compute maintenance list

Lists maintenances by conditions, specified in request.

#### Command Usage

Syntax:

`yc beta compute maintenance list`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

Filter list by various fields. Supported fields: ["status", "resource_type", "resource_id"] ||
|| `--order-by` | `string`

By which field the listing should be ordered and in which direction, format is "created_at desc". The default sorting order is ascending. Supported fields: ["created_at", "start_scheduled_at", "started_at"]. ||
|| `--page-size` | `int`

The maximum number of maintenances to return per response. ||
|| `--page-token` | `string`

Token to retrieve the next page of results. Omitted on the first request. ||
|| `--cloud-id` | `string`

Cloud ID for the resources. ||
|| `--folder-id` | `string`

Folder ID for the resources. ||
|| `--resource-id` | `string`

Resource ID of the target resource. ||
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