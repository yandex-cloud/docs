---
editable: false
---

# yc managed-redis cluster create

Create Redis cluster

#### Command Usage

Syntax:

`yc managed-redis cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Cluster name. ||
|| `--description` | `string`

Cluster description. ||
|| `--environment` | `string`

Cluster environment. Values: production, prestable. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created for the Redis cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `assign-public-ip`: Whether the host should get a public IP address.

- `replica-priority`: Replica priority (100 by default)

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `shard-name`: Shard name host belong to. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--user` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of database users to be created in the Redis cluster.

Possible property names:

- `name`: Name of the Redis user.

- `password`: Password of Redis user

- `disabled`: Disabled flag of Redis user. False by default.

- `raw`: Raw ACL permissions string format

- `categories`: Set of categories permissions grant access to

- `commands`: Set of commands permissions grant access to

- `sanitize-payload`: Sanitize payload setting. Possible values: sanitize-payload, skip-sanitize-payload

- `patterns`: Set of patterns permissions grant access to

- `pub-sub-channels`: Set of pub/sub channels permissions grant access to ||
|| `--sharded` | Enables sharding for Redis cluster. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Redis cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--enable-tls` | Enables tls for Redis cluster. ||
|| `--persistence-mode` | `string`

Persistence mode for Redis cluster (ON, OFF or ON_REPLICAS). ||
|| `--announce-hostnames` | Enable announce hostnames for Redis cluster. ||
|| `--auth-sentinel` | Allows to use ACL users to auth in sentinel ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `disk-size-limit`: Set disk size limit in GB

- `planned-usage-threshold`: Planned usage threshold

- `emergency-usage-threshold`: Emergency usage threshold ||
|| `--valkey-modules` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Valkey modules settings

Possible property names:

- `enable-valkey-search`: Enable valkey-search module

- `valkey-search-reader-threads`: Controls the amount of threads executing valkey-search queries

- `valkey-search-writer-threads`: Controls the amount of threads processing valkey-search index mutations

- `enable-valkey-json`: Enable valkey-json module

- `enable-valkey-bloom`: Enable valkey-bloom module ||
|| `--redis-version` | `string`

Version of Redis used in the cluster. Values: 7.2 ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--disk-type-id` | `string`

Disk type id (e.g., network-ssd). ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retain period of automatically created backup in days. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--password` | `string`

Authentication password. ||
|| `--max-memory-policy` | `string`

Redis maxmemory setting. Values: 'volatile-lru', 'allkeys-lru', 'volatile-lfu', 'allkeys-lfu', 'volatile-random', 'allkeys-random', 'volatile-ttl', 'noeviction' ||
|| `--timeout` | `int`

Time seconds that Redis keeps the connection open while the client is idle. ||
|| `--notify-keyspace-events` | `string`

Redis events to notify about. ||
|| `--slowlog-max-len` | `int`

Maximum length of slow operations log. ||
|| `--slowlog-log-slower-than` | `int`

Threshold in milliseconds to log slow operations. ||
|| `--databases` | `int`

Number of Redis databases. ||
|| `--maxmemory-percent` | `int`

Redis maxmemory usage in percent. Values: 1-75 ||
|| `--client-output-buffer-limit-normal` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Redis client output buffer limit normal limits.

Possible property names:

- `hard`: Redis client output buffer limit normal hard limit.

- `soft`: Redis client output buffer limit normal soft limit.

- `secs`: Redis client output buffer limit normal soft seconds. ||
|| `--client-output-buffer-limit-pubsub` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Redis client output buffer limit pubsub limits.

Possible property names:

- `hard`: Redis client output buffer limit pubsub hard limit.

- `soft`: Redis client output buffer limit pubsub soft limit.

- `secs`: Redis client output buffer limit pubsub soft seconds. ||
|| `--lua-time-limit` | `int`

Maximum time in milliseconds for Lua scripts. Values: 0-5000, 0 - disabled mechanism ||
|| `--repl-backlog-size-percent` | `int`

Replication backlog size as a percentage of flavor maxmemory. Values: 1-75 ||
|| `--cluster-require-full-coverage` | Controls whether all hash slots must be covered by nodes ||
|| `--cluster-allow-reads-when-down` | Allows read operations when cluster is down ||
|| `--cluster-allow-pubsubshard-when-down` | Allows Pub/Sub shard operations when cluster is down ||
|| `--lfu-decay-time` | `int`

The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10). ||
|| `--lfu-log-factor` | `int`

Determines how the frequency counter represents key hits. ||
|| `--turn-before-switchover` | Allows to turn before switchover in RDSync. ||
|| `--allow-data-loss` | Allows some data to be lost in favor of faster switchover/restart. ||
|| `--use-luajit` | Use JIT for lua scripts and functions. ||
|| `--io-threads-allowed` | Allow redis to use io-threads. ||
|| `--zset-max-listpack-entries` | `int`

Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist. ||
|| `--aof-max-size-percent` | `int`

AOF maximum size as a percentage of disk available. Values: 1-99 ||
|| `--activedefrag` | Enable active (online) memory defragmentation. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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