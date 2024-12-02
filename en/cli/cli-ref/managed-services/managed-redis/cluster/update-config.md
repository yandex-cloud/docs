---
editable: false
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
|`--id`|<b>`string`</b><br/>Redis cluster id.|
|`--name`|<b>`string`</b><br/>Redis cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--set`|<b>`key1=value1[,key2=value2][,"key3=val3a,val3b"]`</b><br/>Set Redis cluster parameters. Can be used multiple times. Acceptable keys:<br/><ul> <li> <p><code>maxmemory_policy</code>:     Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> </li> <li> <p><code>timeout</code>:     Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> </li> <li> <p><code>password</code>:     Authentication password.</p> </li> <li> <p><code>databases</code>:     Number of database buckets on a single redis-server process.</p> </li> <li> <p><code>slowlog_log_slower_than</code>:     Threshold for logging slow requests to server in microseconds (log only slower than it).</p> </li> <li> <p><code>slowlog_max_len</code>:     Max slow requests number to log.</p> </li> <li> <p><code>notify_keyspace_events</code>:     String setting for pub\sub functionality.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.hard_limit</code>:     Total limit in bytes.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.soft_limit</code>:     Limit in bytes during certain time period.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.soft_seconds</code>:     Seconds for soft limit.</p> </li> <li> <p><code>client_output_buffer_limit_normal.hard_limit</code>:     Total limit in bytes.</p> </li> <li> <p><code>client_output_buffer_limit_normal.soft_limit</code>:     Limit in bytes during certain time period.</p> </li> <li> <p><code>client_output_buffer_limit_normal.soft_seconds</code>:     Seconds for soft limit.</p> </li> <li> <p><code>maxmemory_percent</code>:     Redis maxmemory percent</p> </li> <li> <p><code>lua_time_limit</code>:     Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism</p> </li> <li> <p><code>repl_backlog_size_percent</code>:     Replication backlog size as a percentage of flavor maxmemory</p> </li> <li> <p><code>cluster_require_full_coverage</code>:     Controls whether all hash slots must be covered by nodes</p> </li> <li> <p><code>cluster_allow_reads_when_down</code>:     Allows read operations when cluster is down</p> </li> <li> <p><code>cluster_allow_pubsubshard_when_down</code>:     Permits Pub/Sub shard operations when cluster is down</p> </li> <li> <p><code>lfu_decay_time</code>:     The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less &lt;= 10)</p> </li> <li> <p><code>lfu_log_factor</code>:     Determines how the frequency counter represents key hits.</p> </li> <li> <p><code>turn_before_switchover</code>:     Allows to turn before switchover in RDSync</p> </li> <li> <p><code>allow_data_loss</code>:     Allows some data to be lost in favor of faster switchover/restart</p> </li> <li> <p><code>use_luajit</code>:     Use JIT for lua scripts and functions</p> </li> <li> <p><code>io_threads_allowed</code>:     Allow redis to use io-threads</p> </li> </ul>|

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
