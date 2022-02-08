# yc managed-clickhouse user update-quota

Update ClickHouse user quota by the interval. Interval is used as key and can not be updated.User quota should be removed and recreated to update interval duration.

#### Command Usage

Syntax: 

`yc managed-clickhouse user update-quota <USER-NAME> --interval <QUOTA-INTERVAL> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--interval`|<b>`duration|int64`</b><br/>Duration of interval for quota in milliseconds. Possible to use time units - "1m30s". Minimal value is 1 second.|
|`--queries`|<b>`int`</b><br/>The total number of queries. 0 - unlimited.|
|`--errors`|<b>`int`</b><br/>The number of queries that threw exception. 0 - unlimited.|
|`--result-rows`|<b>`int`</b><br/>The total number of rows given as the result. 0 - unlimited.|
|`--read-rows`|<b>`int`</b><br/>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.|
|`--execution-time`|<b>`duration|int64`</b><br/>The total query execution time, in milliseconds (wall time). Possible to use time units - "1m30s". 0 - unlimited.|
|`--cluster-id`|<b>`string`</b><br/>ID of the ClickHouse cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the ClickHouse cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
