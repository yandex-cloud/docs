---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-redis/cli-ref/cluster/update-config.md
---

# yc managed-redis cluster update-config

Update the specified Redis cluster config

#### Command Usage

Syntax:

`yc managed-redis cluster update-config <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Redis cluster id. ||
|| `--name` | `string`

Redis cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--set` | `key1=value1[,key2=value2][,"key3=val3a,val3b"]`

Set Redis cluster parameters. Can be used multiple times. Acceptable keys:

- `maxmemory_policy`: Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

  All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `timeout`: Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

- `password`: Authentication password.

- `databases`: Number of database buckets on a single redis-server process.

- `slowlog_log_slower_than`: Threshold for logging slow requests to server in microseconds (log only slower than it).

- `slowlog_max_len`: Max slow requests number to log.

- `notify_keyspace_events`: String setting for pub\sub functionality.

- `client_output_buffer_limit_pubsub.hard_limit`: Total limit in bytes.

- `client_output_buffer_limit_pubsub.soft_limit`: Limit in bytes during certain time period.

- `client_output_buffer_limit_pubsub.soft_seconds`: Seconds for soft limit.

- `client_output_buffer_limit_normal.hard_limit`: Total limit in bytes.

- `client_output_buffer_limit_normal.soft_limit`: Limit in bytes during certain time period.

- `client_output_buffer_limit_normal.soft_seconds`: Seconds for soft limit.

- `maxmemory_percent`: Redis maxmemory percent

- `lua_time_limit`: Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism

- `repl_backlog_size_percent`: Replication backlog size as a percentage of flavor maxmemory

- `cluster_require_full_coverage`: Controls whether all hash slots must be covered by nodes

- `cluster_allow_reads_when_down`: Allows read operations when cluster is down

- `cluster_allow_pubsubshard_when_down`: Permits Pub/Sub shard operations when cluster is down

- `lfu_decay_time`: The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10)

- `lfu_log_factor`: Determines how the frequency counter represents key hits.

- `turn_before_switchover`: Allows to turn before switchover in RDSync

- `allow_data_loss`: Allows some data to be lost in favor of faster switchover/restart

- `use_luajit`: Use JIT for lua scripts and functions

- `io_threads_allowed`: Allow redis to use io-threads

- `zset_max_listpack_entries`: Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist

- `aof_max_size_percent`: AOF maximum size as a percentage of disk available

- `activedefrag`: Enable active (online) memory defragmentation ||
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