---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/lifecycle-policy/list-dry-run-results.md
---

# yc beta container lifecycle-policy list-dry-run-results

Retrieves the list of the dry run results.

#### Command Usage

Syntax: 

`yc beta container lifecycle-policy list-dry-run-results <LIFECYCLE-POLICY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters dry run results listed in the response.<br/><br/>The expression must specify:<br/>1. The field name. Currently you can use filtering only on [LifecyclePolicy.name] field.<br/>2. An '=' operator.<br/>3. The value in double quotes ('"'). Must be 3-63 characters long and match the regular expression '[a-z][-a-z0-9]{1,61}[a-z0-9]'.|
|`--lifecycle-policy-id`|<b>`string`</b><br/>ID of the lifecycle policy.|
|`--order-by`|<b>`string`</b><br/>Sorting the list by [DryRunLifecyclePolicyResult.run_at] and [DryRunLifecyclePolicyResult.affected_images_count] fields.<br/>The default sorting order is ascending.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than 'page_size', the service returns<br/>a [ListDryRunLifecyclePolicyResultsResponse.next_page_token] that can be used to get<br/>the next page of results in subsequent list requests.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the<br/>[ListDryRunLifecyclePolicyResultsResponse.next_page_token] returned by a previous list request.|

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
