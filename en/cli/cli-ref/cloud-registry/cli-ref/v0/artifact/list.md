---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloud-registry/cli-ref/v0/artifact/list/
---

# yc cloud-registry v0 artifact list

List artifacts with filtering by kind, registry kind/type, node path

#### Command Usage

Syntax:

`yc cloud-registry v0 artifact list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--registry-id` | `string`

Registry id. ||
|| `--registry-name` | `string`

Registry name. ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--page-token` | `string`

Page token pagination simplifies navigating large datasets by using a token to represent the current page. ||
|| `--node-path` | `string`

Filter by exact artifact node path (e.g. 'pool/main/all'). ||
|| `--kind` | `string`

Filter by artifact kind. Empty means any kind. ||
|| `--registry-kind` | `string`

Filter by registry kind. Empty means any kind. ||
|| `--registry-type` | `string`

Filter by registry type. Empty means any type. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
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