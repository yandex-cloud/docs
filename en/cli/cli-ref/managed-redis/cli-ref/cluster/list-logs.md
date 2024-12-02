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

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Redis cluster id.|
|`--name`|<b>`string`</b><br/>Redis cluster name.|
|`--limit`|<b>`int`</b><br/>The maximum number of items to list.|
|`--service-type`|<b>`string`</b><br/>Type of the service to request logs about. Values: 'redis'|
|`--columns`|<b>`value[,value]`</b><br/>Columns from logs table to request|
|`--filter`|<b>`string`</b><br/>Filter expression that filters resources listed in the response. Entire filter must be surrounded with quotes.<br/>Examples: "message.hostname='node1.db.cloud.yandex.net'"|
|`--since`|<b>`timestamp`</b><br/>Start timestamp for the logs request. Format: timestamp in HH:MM:SS format or RFC-3339, or duration since now.<br/>Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago'|
|`--until`|<b>`timestamp`</b><br/>End timestamp for the logs request. Format: timestamp in HH:MM:SS format or RFC-3339, or duration since now.<br/>Examples: '15:04:05', '2006-01-02T15:04:05Z', '2h', '3h30m ago'|
|`--follow`|Enable 'tail -f' semantics - load logs as they appear until interrupted. Exclusive with 'until' flag.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
