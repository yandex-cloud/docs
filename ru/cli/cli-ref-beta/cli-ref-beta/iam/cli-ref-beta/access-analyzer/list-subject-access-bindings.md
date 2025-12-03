---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iam/cli-ref-beta/access-analyzer/list-subject-access-bindings.md
---

# yc beta iam access-analyzer list-subject-access-bindings

Returns the list of access bindings for the specified subject in chosen organization.

#### Command Usage

Syntax: 

`yc beta iam access-analyzer list-subject-access-bindings <ORGANIZATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--organization-id`|<b>`string`</b><br/>OrganizationId to search access bindings in.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than [page_size],<br/>the service returns a [ListSubjectAccessBindingsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token]<br/>to the [ListSubjectAccessBindingsResponse.next_page_token]<br/>returned by a previous list request.|
|`--subject-id`|<b>`string`</b><br/>SubjectId to list access bindings for.|

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
