---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/group/list-effective.md
---

# yc beta organization-manager group list-effective

Returns groups that the subject belongs to within a specific organization.

#### Command Usage

Syntax: 

`yc beta organization-manager group list-effective <ORGANIZATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression supports the following operations: - '=' for exact match: 'name = 'example-name'' - 'IN' for multiple values: 'id IN ('id1', 'id2')' - 'contains' for domain substring search: 'name contains 'example'' - 'AND' for combining conditions: 'name contains 'my-group' AND name contains 'name'' Available fields for filtering: - 'id' - group ID - 'name' - group name Must be 1-1000 characters long.|
|`--organization-id`|<b>`string`</b><br/>The ID of the organization to scope the group search to. If omitted and the subject belongs to a single organization, that organization's ID will be used automatically.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListEffectiveResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. Set [page_token] to the [ListEffectiveResponse.next_page_token] returned by a previous list request to get the next page of results.|
|`--subject-id`|<b>`string`</b><br/>ID of the subject to list groups for.|

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
