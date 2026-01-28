---
editable: false
sourcePath: en/_cli-ref/cli-ref/iot/cli-ref/registry/logs.md
---

# yc iot registry logs

Show logs for the specified registry

#### Command Usage

Syntax:

`yc iot registry logs <REGISTRY-NAME>|<REGISTRY-ID>  [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Registry id. ||
|| `--name` | `string`

Registry name. ||
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

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#