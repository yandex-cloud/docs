---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-redis/cli-ref/cluster/list-logs.md
---

# yc managed-redis cluster list-logs

Retrieves logs for the specified Redis cluster

#### Command Usage

Syntax:

`yc managed-redis cluster list-logs <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Redis cluster id. ||
|| `--name` | `string`

Redis cluster name. ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--service-type` | `string`

Type of the service to request logs about. Values: 'redis' ||
|| `--columns` | `value[,value]`

Columns from logs table to request ||
|| `--filter` | `string`

Filter expression that filters resources listed in the response. Entire filter must be surrounded with quotes.
Examples: "message.hostname='node1.db.cloud.yandex.net'" ||
|| `--since` | `timestamp`

Start timestamp for the logs request. Format: timestamp in HH:MM:SS format or RFC-3339, or duration since now.
Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago' ||
|| `--until` | `timestamp`

End timestamp for the logs request. Format: timestamp in HH:MM:SS format or RFC-3339, or duration since now.
Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago' ||
|| `--follow` | Enable 'tail -f' semantics - load logs as they appear until interrupted. Exclusive with 'until' flag. ||
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