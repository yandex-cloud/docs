---
editable: false
noIndex: true
---

# yc beta cloud-registry registry list-artifacts

Retrieves the list of registry artifact resources in the specified registry.

#### Command Usage

Syntax:

`yc beta cloud-registry registry list-artifacts <REGISTRY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListRepositoriesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 10. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListArtifactsResponse.next_page_token] returned by a previous list request. ||
|| `--path` | `string`

The path to a specific node where the registry artifact is located. ||
|| `--registry-id` | `string`

ID of the registry artifact to list repositories in. To get the registry ID use a [ArtifactService.List] request. ||
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