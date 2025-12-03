---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/loadtesting/cli-ref-beta/test/list.md
---

# yc beta loadtesting test list

Retrieves the list of test in the specified folder.

#### Command Usage

Syntax: 

`yc beta loadtesting test list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters tests listed in the response.<br/><br/>The filter expression may contain multiple field expressions joined by 'AND'.<br/>The field expression must specify:<br/>1. The field name.<br/>2. An operator:<br/>- '=', '!=', '<', '<=', '>', '>=', 'CONTAINS', ':' for single values.<br/>- 'IN' or 'NOT IN' for lists of values.<br/>3. The value. String values must be encosed in '"', boolean values are {'true', 'false'}, timestamp values in ISO-8601.<br/><br/>Currently supported fields:<br/>- 'id' [yandex.cloud.loadtesting.api.v1.test.Test.id]<br/>- operators: '=', '!=', 'IN', 'NOT IN'<br/>- 'details.name' [yandex.cloud.loadtesting.api.v1.test.Details.name]<br/>- operators: '=', '!=', 'IN', 'NOT IN', 'CONTAINS'<br/>- 'details.tags.<TAG_NAME>' [yandex.cloud.loadtesting.api.v1.test.Details.tags]<br/>- operators: ':'<br/>- 'summary.status' [yandex.cloud.loadtesting.api.v1.test.Summary.status]<br/>- operators: '=', '!=', 'IN', 'NOT IN'<br/>- 'summary.is_finished' [yandex.cloud.loadtesting.api.v1.test.Summary.is_finished]<br/>- operators: '='<br/>- 'summary.created_at' [yandex.cloud.loadtesting.api.v1.test.Summary.created_at]<br/>- operators: '<', '<=', '>', '>='<br/>- 'summary.created_by' [yandex.cloud.loadtesting.api.v1.test.Summary.created_by]<br/>- operators: '=', '!=', 'IN', 'NOT IN'<br/><br/>Examples:<br/>- 'summary.status IN ("DONE", "ERROR") AND details.tags.author:"yandex"'<br/>- 'summary.is_finished = true AND details.name CONTAINS "nightly-test"'|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list tests in.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than 'page_size', the service returns a [ListTestsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the<br/>[ListTestsResponse.next_page_token] returned by a previous list request.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
