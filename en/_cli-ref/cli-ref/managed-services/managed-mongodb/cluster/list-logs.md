# yc managed-mongodb cluster list-logs

Retrieve logs for the specified MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb cluster list-logs <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the MongoDB cluster.|
|`--name`|<b>`string`</b><br/>Name of the MongoDB cluster.|
|`--limit`|<b>`int`</b><br/>The maximum number of items to list.|
|`--service-type`|<b>`string`</b><br/>Type of the service to request logs from. Values: 'mongod', 'mongos', 'mongocfg', 'audit'|
|`--columns`|<b>`value[,value]`</b><br/>Columns from logs table to request.|
|`--filter`|<b>`string`</b><br/>Filter expression that filters resources listed in the response. Entire filter must be surrounded with quotes. Examples: "message.hostname='node1.db.cloud.yandex.net'", "message.severity IN ('E', 'F')"|
|`--since`|<b>`timestamp`</b><br/>Start timestamp for the logs request. Format: RFC-3339, HH:MM:SS, or a moment  of time relative to the current time. Examples: '2006-01-02T15:04:05Z', '15:04:05', '2h' or '3h30m ago'.|
|`--until`|<b>`timestamp`</b><br/>End timestamp for the logs request. Format: RFC-3339, HH:MM:SS, or a moment  of time relative to the current time. Examples: '2006-01-02T15:04:05Z', '15:04:05', '2h' or '3h30m ago'.|
|`--follow`|Enable 'tail -f' semantics - load logs as they appear until interrupted. Exclusive with 'until' flag.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
