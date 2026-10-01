---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/v0/function/version/logs/
---

# yc serverless v0 function version logs

Read function version logs

#### Command Usage

Syntax:

`yc serverless v0 function version logs <VERSION-ID> [SINCE] [FILTER] [--until <UNTIL>] [--follow|-f] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Function version id. ||
|| `--limit` | `int`

The maximum number of items to list. ||
|| `--since` | `timestamp`

Show logs since this time in HH:MM:SS format or RFC-3339, or duration since now. Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago' ||
|| `--until` | `timestamp`

Show logs until this time in HH:MM:SS format or RFC-3339, or duration since now. Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago' ||
|| `-f`, `--follow` | Output logs as they arrive ||
|| `--levels` | `value[,value]`

Show logs with these levels (comma-separated) ||
|| `--filter` | `string`

Use this filter ||
|| `--max-response-size` | `byteSize`

Specifies the maximum response size in bytes. You can also use M and T suffixes to specify MiB or TiB respectively. Default is 3.5 MiB. ||
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