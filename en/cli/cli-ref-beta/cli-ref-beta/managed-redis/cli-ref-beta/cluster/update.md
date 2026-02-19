---
editable: false
noIndex: true
---

# yc beta managed-redis cluster update

Updates the specified Redis cluster.

#### Command Usage

Syntax:

`yc beta managed-redis cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--announce-hostnames` | Enable FQDN instead of ip ||
|| `--auth-sentinel` | Allows to use ACL users to auth in sentinel ||
|| `--cluster-id` | `string`

ID of the Redis cluster to update. To get the Redis cluster ID, use a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New configuration and resources for hosts in the cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    web-sql = boolean
  },
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  disk-size-autoscaling = {
    disk-size-limit = integer,
    emergency-usage-threshold = integer,
    planned-usage-threshold = integer
  },
  modules = {
    valkey-bloom = {
      enabled = boolean
    },
    valkey-json = {
      enabled = boolean
    },
    valkey-search = {
      enabled = boolean,
      reader-threads = integer,
      writer-threads = integer
    }
  },
  redis = {
    activedefrag = boolean,
    allow-data-loss = boolean,
    aof-max-size-percent = integer,
    client-output-buffer-limit-normal = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    client-output-buffer-limit-pubsub = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    cluster-allow-pubsubshard-when-down = boolean,
    cluster-allow-reads-when-down = boolean,
    cluster-require-full-coverage = boolean,
    databases = integer,
    io-threads-allowed = boolean,
    lfu-decay-time = integer,
    lfu-log-factor = integer,
    lua-time-limit = integer,
    maxmemory-percent = integer,
    maxmemory-policy = VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION,
    notify-keyspace-events = string,
    password = string,
    repl-backlog-size-percent = integer,
    slowlog-log-slower-than = integer,
    slowlog-max-len = integer,
    timeout = integer,
    turn-before-switchover = boolean,
    use-luajit = boolean,
    zset-max-listpack-entries = integer
  },
  redis-spec = redis-config-5-0={
    client-output-buffer-limit-normal = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    client-output-buffer-limit-pubsub = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    databases = integer,
    maxmemory-policy = VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION,
    notify-keyspace-events = string,
    password = string,
    slowlog-log-slower-than = integer,
    slowlog-max-len = integer,
    timeout = integer
  } | redis-config-6-0={
    client-output-buffer-limit-normal = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    client-output-buffer-limit-pubsub = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    databases = integer,
    maxmemory-policy = VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION,
    notify-keyspace-events = string,
    password = string,
    slowlog-log-slower-than = integer,
    slowlog-max-len = integer,
    timeout = integer
  } | redis-config-6-2={
    client-output-buffer-limit-normal = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    client-output-buffer-limit-pubsub = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    databases = integer,
    maxmemory-percent = integer,
    maxmemory-policy = VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION,
    notify-keyspace-events = string,
    password = string,
    slowlog-log-slower-than = integer,
    slowlog-max-len = integer,
    timeout = integer
  } | redis-config-7-0={
    client-output-buffer-limit-normal = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    client-output-buffer-limit-pubsub = {
      hard-limit = integer,
      soft-limit = integer,
      soft-seconds = integer
    },
    databases = integer,
    maxmemory-percent = integer,
    maxmemory-policy = VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION,
    notify-keyspace-events = string,
    password = string,
    slowlog-log-slower-than = integer,
    slowlog-max-len = integer,
    timeout = integer
  },
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  },
  version = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "web-sql": "boolean"
  },
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "disk-size-autoscaling": {
    "disk-size-limit": "integer",
    "emergency-usage-threshold": "integer",
    "planned-usage-threshold": "integer"
  },
  "modules": {
    "valkey-bloom": {
      "enabled": "boolean"
    },
    "valkey-json": {
      "enabled": "boolean"
    },
    "valkey-search": {
      "enabled": "boolean",
      "reader-threads": "integer",
      "writer-threads": "integer"
    }
  },
  "redis": {
    "activedefrag": "boolean",
    "allow-data-loss": "boolean",
    "aof-max-size-percent": "integer",
    "client-output-buffer-limit-normal": {
      "hard-limit": "integer",
      "soft-limit": "integer",
      "soft-seconds": "integer"
    },
    "client-output-buffer-limit-pubsub": {
      "hard-limit": "integer",
      "soft-limit": "integer",
      "soft-seconds": "integer"
    },
    "cluster-allow-pubsubshard-when-down": "boolean",
    "cluster-allow-reads-when-down": "boolean",
    "cluster-require-full-coverage": "boolean",
    "databases": "integer",
    "io-threads-allowed": "boolean",
    "lfu-decay-time": "integer",
    "lfu-log-factor": "integer",
    "lua-time-limit": "integer",
    "maxmemory-percent": "integer",
    "maxmemory-policy": "VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION",
    "notify-keyspace-events": "string",
    "password": "string",
    "repl-backlog-size-percent": "integer",
    "slowlog-log-slower-than": "integer",
    "slowlog-max-len": "integer",
    "timeout": "integer",
    "turn-before-switchover": "boolean",
    "use-luajit": "boolean",
    "zset-max-listpack-entries": "integer"
  },
  "redis-spec": {
    "redis-config-5-0": {
      "client-output-buffer-limit-normal": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "client-output-buffer-limit-pubsub": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "databases": "integer",
      "maxmemory-policy": "VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION",
      "notify-keyspace-events": "string",
      "password": "string",
      "slowlog-log-slower-than": "integer",
      "slowlog-max-len": "integer",
      "timeout": "integer"
    },
    "redis-config-6-0": {
      "client-output-buffer-limit-normal": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "client-output-buffer-limit-pubsub": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "databases": "integer",
      "maxmemory-policy": "VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION",
      "notify-keyspace-events": "string",
      "password": "string",
      "slowlog-log-slower-than": "integer",
      "slowlog-max-len": "integer",
      "timeout": "integer"
    },
    "redis-config-6-2": {
      "client-output-buffer-limit-normal": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "client-output-buffer-limit-pubsub": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "databases": "integer",
      "maxmemory-percent": "integer",
      "maxmemory-policy": "VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION",
      "notify-keyspace-events": "string",
      "password": "string",
      "slowlog-log-slower-than": "integer",
      "slowlog-max-len": "integer",
      "timeout": "integer"
    },
    "redis-config-7-0": {
      "client-output-buffer-limit-normal": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "client-output-buffer-limit-pubsub": {
        "hard-limit": "integer",
        "soft-limit": "integer",
        "soft-seconds": "integer"
      },
      "databases": "integer",
      "maxmemory-percent": "integer",
      "maxmemory-policy": "VOLATILE_LRU|ALLKEYS_LRU|VOLATILE_LFU|ALLKEYS_LFU|VOLATILE_RANDOM|ALLKEYS_RANDOM|VOLATILE_TTL|NOEVICTION",
      "notify-keyspace-events": "string",
      "password": "string",
      "slowlog-log-slower-than": "integer",
      "slowlog-max-len": "integer",
      "timeout": "integer"
    }
  },
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  },
  "version": "string"
}
```

Fields:

```
access -> (struct)
  Access policy to DB
  data-lens -> (boolean)
    Allow access for DataLens
  web-sql -> (boolean)
    Allow access for Web SQL.
backup-retain-period-days -> (integer)
  Retain period of automatically created backup in days
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
disk-size-autoscaling -> (struct)
  Disk size autoscaling settings
  disk-size-limit -> (integer)
    Limit on how large the storage for database instances can automatically grow, in bytes.
  emergency-usage-threshold -> (integer)
    Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
  planned-usage-threshold -> (integer)
    Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
modules -> (struct)
  Valkey modules settings
  valkey-bloom -> (struct)
    valkey-bloom module settings
    enabled -> (boolean)
      Enable valkey-bloom module
  valkey-json -> (struct)
    valkey-json module settings
    enabled -> (boolean)
      Enable valkey-json module
  valkey-search -> (struct)
    valkey-search module settings
    enabled -> (boolean)
      Enable valkey-search module
    reader-threads -> (integer)
      Controls the amount of threads executing queries
    writer-threads -> (integer)
      Controls the amount of threads processing index mutations
redis -> (struct)
  Unified configuration of a Redis cluster
  activedefrag -> (boolean)
    Enable active (online) memory defragmentation
  allow-data-loss -> (boolean)
    Allows some data to be lost in favor of faster switchover/restart
  aof-max-size-percent -> (integer)
    AOF maximum size as a percentage of disk available
  client-output-buffer-limit-normal -> (struct)
    Redis connection output buffers limits for clients.
    hard-limit -> (integer)
      Total limit in bytes.
    soft-limit -> (integer)
      Limit in bytes during certain time period.
    soft-seconds -> (integer)
      Seconds for soft limit.
  client-output-buffer-limit-pubsub -> (struct)
    Redis connection output buffers limits for pubsub operations.
    hard-limit -> (integer)
      Total limit in bytes.
    soft-limit -> (integer)
      Limit in bytes during certain time period.
    soft-seconds -> (integer)
      Seconds for soft limit.
  cluster-allow-pubsubshard-when-down -> (boolean)
    Permits Pub/Sub shard operations when cluster is down
  cluster-allow-reads-when-down -> (boolean)
    Allows read operations when cluster is down
  cluster-require-full-coverage -> (boolean)
    Controls whether all hash slots must be covered by nodes
  databases -> (integer)
    Number of database buckets on a single redis-server process.
  io-threads-allowed -> (boolean)
    Allow redis to use io-threads
  lfu-decay-time -> (integer)
    The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10)
  lfu-log-factor -> (integer)
    Determines how the frequency counter represents key hits.
  lua-time-limit -> (integer)
    Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism
  maxmemory-percent -> (integer)
    Redis maxmemory percent
  maxmemory-policy -> (struct)
    Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis documentation. All policies are described in detail in Redis documentation.
  notify-keyspace-events -> (string)
    String setting for pub\sub functionality.
  password -> (string)
    Authentication password.
  repl-backlog-size-percent -> (integer)
    Replication backlog size as a percentage of flavor maxmemory
  slowlog-log-slower-than -> (integer)
    Threshold for logging slow requests to server in microseconds (log only slower than it).
  slowlog-max-len -> (integer)
    Max slow requests number to log.
  timeout -> (integer)
    Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.
  turn-before-switchover -> (boolean)
    Allows to turn before switchover in RDSync
  use-luajit -> (boolean)
    Use JIT for lua scripts and functions
  zset-max-listpack-entries -> (integer)
    Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist
resources -> (struct)
  Resources allocated to Redis hosts.
  disk-size -> (integer)
    Volume of the storage available to a host, in bytes.
  disk-type-id -> (string)
    Type of the storage environment for the host. Possible values: * network-ssd - network SSD drive, * local-ssd - local SSD storage.
  resource-preset-id -> (string)
    ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
version -> (string)
  Version of Redis used in the cluster.
redis-spec -> (oneof<redis-config-5-0|redis-config-6-0|redis-config-6-2|redis-config-7-0>)
  Oneof redis-spec field
  redis-config-5-0 -> (struct)
    client-output-buffer-limit-normal -> (struct)
      Redis connection output buffers limits for clients.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    client-output-buffer-limit-pubsub -> (struct)
      Redis connection output buffers limits for pubsub operations.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    databases -> (integer)
      Number of database buckets on a single redis-server process.
    maxmemory-policy -> (struct)
      Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis documentation. All policies are described in detail in Redis documentation.
    notify-keyspace-events -> (string)
      String setting for pub\sub functionality.
    password -> (string)
      Authentication password.
    slowlog-log-slower-than -> (integer)
      Threshold for logging slow requests to server in microseconds (log only slower than it).
    slowlog-max-len -> (integer)
      Max slow requests number to log.
    timeout -> (integer)
      Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.
  redis-config-6-0 -> (struct)
    client-output-buffer-limit-normal -> (struct)
      Redis connection output buffers limits for clients.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    client-output-buffer-limit-pubsub -> (struct)
      Redis connection output buffers limits for pubsub operations.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    databases -> (integer)
      Number of database buckets on a single redis-server process.
    maxmemory-policy -> (struct)
      Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis documentation. All policies are described in detail in Redis documentation.
    notify-keyspace-events -> (string)
      String setting for pub\sub functionality.
    password -> (string)
      Authentication password.
    slowlog-log-slower-than -> (integer)
      Threshold for logging slow requests to server in microseconds (log only slower than it).
    slowlog-max-len -> (integer)
      Max slow requests number to log.
    timeout -> (integer)
      Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.
  redis-config-6-2 -> (struct)
    client-output-buffer-limit-normal -> (struct)
      Redis connection output buffers limits for clients.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    client-output-buffer-limit-pubsub -> (struct)
      Redis connection output buffers limits for pubsub operations.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    databases -> (integer)
      Number of database buckets on a single redis-server process.
    maxmemory-percent -> (integer)
      Redis maxmemory percent
    maxmemory-policy -> (struct)
      Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis documentation. All policies are described in detail in Redis documentation.
    notify-keyspace-events -> (string)
      String setting for pub\sub functionality.
    password -> (string)
      Authentication password.
    slowlog-log-slower-than -> (integer)
      Threshold for logging slow requests to server in microseconds (log only slower than it).
    slowlog-max-len -> (integer)
      Max slow requests number to log.
    timeout -> (integer)
      Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.
  redis-config-7-0 -> (struct)
    client-output-buffer-limit-normal -> (struct)
      Redis connection output buffers limits for clients.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    client-output-buffer-limit-pubsub -> (struct)
      Redis connection output buffers limits for pubsub operations.
      hard-limit -> (integer)
        Total limit in bytes.
      soft-limit -> (integer)
        Limit in bytes during certain time period.
      soft-seconds -> (integer)
        Seconds for soft limit.
    databases -> (integer)
      Number of database buckets on a single redis-server process.
    maxmemory-percent -> (integer)
      Redis maxmemory percent
    maxmemory-policy -> (struct)
      Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis documentation. All policies are described in detail in Redis documentation.
    notify-keyspace-events -> (string)
      String setting for pub\sub functionality.
    password -> (string)
      Authentication password.
    slowlog-log-slower-than -> (integer)
      Threshold for logging slow requests to server in microseconds (log only slower than it).
    slowlog-max-len -> (integer)
      Max slow requests number to log.
    timeout -> (integer)
      Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the Redis cluster. ||
|| `--labels` | `map<string><string>`

Custom labels for the Redis cluster as '' key:value '' pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--maintenance-window` | `shorthand/json`

New maintenance window settings for the cluster.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
    Maintenance operation can be scheduled anytime.
  weekly-maintenance-window -> (struct)
    Maintenance operation can be scheduled on a weekly basis.
    day -> (struct)
      Day of the week (in 'DDD' format).
    hour -> (integer)
      Hour of the day in UTC (in 'HH' format).
``` ||
|| `--name` | `string`

New name for the cluster. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--persistence-mode` | `enum`

Persistence mode Possible Values: 'on', 'off', 'on-replicas' ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#