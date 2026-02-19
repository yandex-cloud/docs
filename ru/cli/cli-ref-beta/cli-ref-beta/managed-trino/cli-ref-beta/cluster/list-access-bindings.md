---
editable: false
noIndex: true
---

# yc beta managed-trino cluster list-access-bindings

Retrieves a list of access bindings for the specified Trino cluster.

#### Command Usage

Syntax:

`yc beta managed-trino cluster list-access-bindings <RESOURCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--page-size` | `int`

The maximum number of results per page that should be returned. If the number of available results is larger than [page_size], the service returns a [ListAccessBindingsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. Set [page_token] to the [ListAccessBindingsResponse.next_page_token] returned by a previous list request to get the next page of results. ||
|| `--resource-id` | `string`

ID of the resource to list access bindings for. To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List] request to get the Cloud resource ID. ||
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