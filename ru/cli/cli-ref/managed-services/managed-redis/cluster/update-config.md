---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-redis/cluster/update-config.md
---
# yc managed-redis cluster update-config

Update the specified Redis cluster config

#### Command Usage

Syntax: 

`yc managed-redis cluster update-config <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Redis cluster id.|
|`--name`|<b>`string`</b><br/> Redis cluster name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--set`|<b>`key1=value1[,key2=value2][,"key3=val3a,val3b"]`</b><br/> Set Redis cluster parameters. Can be used multiple times. Acceptable keys: maxmemory_policy Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis [host class](/docs/managed-redis/concepts/instance-types).  All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).  timeout Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.  password Authentication password.  databases Number of database buckets on a single redis-server process.  slowlog_log_slower_than Threshold for logging slow requests to server in microseconds (log only slower than it).  slowlog_max_len Max slow requests number to log.  notify_keyspace_events String setting for pub\sub functionality; subset of KEg$lshzxeAt.  client_output_buffer_limit_pubsub.hard_limit Total limit in bytes.  client_output_buffer_limit_pubsub.soft_limit Limit in bytes during certain time period.  client_output_buffer_limit_pubsub.soft_seconds Seconds for soft limit.  client_output_buffer_limit_normal.hard_limit Total limit in bytes.  client_output_buffer_limit_normal.soft_limit Limit in bytes during certain time period.  client_output_buffer_limit_normal.soft_seconds Seconds for soft limit.|

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
