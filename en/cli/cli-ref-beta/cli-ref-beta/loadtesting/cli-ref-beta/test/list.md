---
editable: false
noIndex: true
---

# yc beta loadtesting test list

Retrieves the list of test in the specified folder.

#### Command Usage

Syntax:

`yc beta loadtesting test list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters tests listed in the response. The filter expression may contain multiple field expressions joined by 'AND'. The field expression must specify: 1. The field name. 2. An operator: - '=', '!=', '&lt;', '<=', '&gt;', '>=', 'CONTAINS', ':' for single values. - 'IN' or 'NOT IN' for lists of values. 3. The value. String values must be encosed in '"', boolean values are {'true', 'false'}, timestamp values in ISO-8601. Currently supported fields: - 'id' [yandex.cloud.loadtesting.api.v1.test.Test.id] - operators: '=', '!=', 'IN', 'NOT IN' - 'details.name' [yandex.cloud.loadtesting.api.v1.test.Details.name] - operators: '=', '!=', 'IN', 'NOT IN', 'CONTAINS' - 'details.tags.&lt;TAG_NAME&gt;' [yandex.cloud.loadtesting.api.v1.test.Details.tags] - operators: ':' - 'summary.status' [yandex.cloud.loadtesting.api.v1.test.Summary.status] - operators: '=', '!=', 'IN', 'NOT IN' - 'summary.is_finished' [yandex.cloud.loadtesting.api.v1.test.Summary.is_finished] - operators: '=' - 'summary.created_at' [yandex.cloud.loadtesting.api.v1.test.Summary.created_at] - operators: '&lt;', '<=', '&gt;', '>=' - 'summary.created_by' [yandex.cloud.loadtesting.api.v1.test.Summary.created_by] - operators: '=', '!=', 'IN', 'NOT IN' Examples: - 'summary.status IN ("DONE", "ERROR") AND details.tags.author:"yandex"' - 'summary.is_finished = true AND details.name CONTAINS "nightly-test"' ||
|| `--folder-id` | `string`

ID of the folder to list tests in. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than 'page_size', the service returns a [ListTestsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ListTestsResponse.next_page_token] returned by a previous list request. ||
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