# yc cloud-registry v1 registry list-artifacts

Retrieves the list of registry artifact resources in the specified registry.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry list-artifacts <REGISTRY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the registry artifact to list repositories in. To get the registry ID use a [RegistryService.List] request. ||
|| `--node-path` | `string`

The path to a specific node where the registry artifact is located. ||
|| `--limit` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListRepositoriesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 10. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListArtifactsResponse.next_page_token] returned by a previous list request. ||
|| `--name` | `string`

Resolve id by resource name within the current scope. ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#