---
editable: false
noIndex: true
---

# yc beta organization-manager group list-effective

Returns groups that the subject belongs to within a specific organization.

#### Command Usage

Syntax:

`yc beta organization-manager group list-effective <ORGANIZATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression supports the following operations: - '=' for exact match: 'name = 'example-name'' - 'IN' for multiple values: 'id IN ('id1', 'id2')' - 'contains' for domain substring search: 'name contains 'example'' - 'AND' for combining conditions: 'name contains 'my-group' AND name contains 'name'' Available fields for filtering: - 'id' - group ID - 'name' - group name Must be 1-1000 characters long. ||
|| `--organization-id` | `string`

The ID of the organization to scope the group search to. If omitted and the subject belongs to a single organization, that organization's ID will be used automatically. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListEffectiveResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| `--page-token` | `string`

Page token. Set [page_token] to the [ListEffectiveResponse.next_page_token] returned by a previous list request to get the next page of results. ||
|| `--subject-id` | `string`

ID of the subject to list groups for. ||
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