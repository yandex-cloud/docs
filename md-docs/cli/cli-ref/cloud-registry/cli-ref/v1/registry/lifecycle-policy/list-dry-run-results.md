[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [cloud-registry](../../../index.md) > [v1](../../index.md) > [registry](../index.md) > [lifecycle-policy](index.md) > list-dry-run-results

# yc cloud-registry v1 registry lifecycle-policy list-dry-run-results

Returns the list of dry run results of one lifecycle policy.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry lifecycle-policy list-dry-run-results <POLICY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--policy-id` | `string`

ID of the lifecycle policy. ||
|| `--page-size` | `int`

The maximum number of results per page to return. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set page_token to the ListDryRunLifecyclePolicyResultsResponse.next_page_token returned by a previous list request. ||
|| `--run-after` | `time`

Return dry run results run at this time or later. (RFC3339) ||
|| `--run-before` | `time`

Return dry run results run before this time. (RFC3339) ||
|| `--order-by` | `string`

Sort order. Comma-separated "field [asc\|desc]", e.g. "run_at desc". Valid fields: run_at. Defaults to "run_at desc" when empty. ||
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