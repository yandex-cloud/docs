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

#|
||Flag | Description ||
|| `--organization-id` | `string`

OrganizationId to search access bindings in. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListSubjectAccessBindingsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100 ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListSubjectAccessBindingsResponse.next_page_token] returned by a previous list request. ||
|| `--subject-id` | `string`

SubjectId to list access bindings for. ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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