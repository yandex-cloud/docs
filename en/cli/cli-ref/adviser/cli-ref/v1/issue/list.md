---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/adviser/cli-ref/v1/issue/list/
---

# yc adviser v1 issue list

List issues detected on the resources of the specified cloud, folder or resource.
Without --cloud-id, --folder-id and a resource, issues of the folder from the current profile are listed.

#### Command Usage

Syntax:

`yc adviser v1 issue list <RESOURCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

ID of the cloud to list issues for. Taken from the current profile if not specified. ||
|| `--folder-id` | `string`

ID of the folder to list issues for. Taken from the current profile only if neither the folder, nor the cloud, nor the resource is specified. ||
|| `--resource-id` | `string`

ID of the resource to list issues for, e.g. ID of the Managed Service for PostgreSQL cluster. ||
|| `--state` | `[]string`

States of the issues to return. By default, only active issues are returned. Possible values: active, resolved, staled. ||
|| `--severity` | `[]string`

Severities of the issues to return. By default, issues of all severities are returned. Possible values: info, warning, critical. ||
|| `--category` | `[]string`

Categories of the issues to return. By default, issues of all categories are returned. Possible values: cost, performance, fault-tolerance. ||
|| `--visibility` | `[]string`

Visibilities of the issues to return. By default, only visible issues are returned. Possible values: visible, dismissed. ||
|| `--lang` | `string`

Language of the issue title and descriptions, e.g. 'ru' or 'en'. ||
|| `--limit` | `int`

The maximum number of issues to list. By default, all issues are listed. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set it to the token printed by the previous list request. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
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