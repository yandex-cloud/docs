---
editable: false
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
|`--set`|<b>`key1=value1[,key2=value2][,"key3=val3a,val3b"]`</b><br/>Set Redis cluster parameters. Can be used multiple times. Acceptable keys:<br/><ul> <li> <p><code>maxmemory_policy</code>:     Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> </li> <li> <p><code>timeout</code>:     Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> </li> <li> <p><code>password</code>:     Authentication password.</p> </li> <li> <p><code>databases</code>:     Number of database buckets on a single redis-server process.</p> </li> <li> <p><code>slowlog_log_slower_than</code>:     Threshold for logging slow requests to server in microseconds (log only slower than it).</p> </li> <li> <p><code>slowlog_max_len</code>:     Max slow requests number to log.</p> </li> <li> <p><code>notify_keyspace_events</code>:     String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.hard_limit</code>:     Total limit in bytes.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.soft_limit</code>:     Limit in bytes during certain time period.</p> </li> <li> <p><code>client_output_buffer_limit_pubsub.soft_seconds</code>:     Seconds for soft limit.</p> </li> <li> <p><code>client_output_buffer_limit_normal.hard_limit</code>:     Total limit in bytes.</p> </li> <li> <p><code>client_output_buffer_limit_normal.soft_limit</code>:     Limit in bytes during certain time period.</p> </li> <li> <p><code>client_output_buffer_limit_normal.soft_seconds</code>:     Seconds for soft limit.</p> </li> <li> <p><code>maxmemory_percent</code>:     Redis maxmemory percent</p> </li> </ul>|

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
|`-h`,`--help`|Display help for the command.|
