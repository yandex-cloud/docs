---
editable: false
noIndex: true
---

# yc beta managed-redis cluster create

Creates a Redis cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-redis cluster create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--announce-hostnames` | Enable FQDN instead of ip ||
|| `--auth-sentinel` | Allows to use ACL users to auth in sentinel ||
|| `--config-spec` | `shorthand/json`

Configuration and resources for hosts that should be created for the Redis cluster.

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

Description of the Redis cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the Redis cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the Redis cluster in. ||
|| `--host-specs` | `shorthand/json`

Individual configurations for hosts that should be created for the Redis cluster.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    replica-priority = integer,
    shard-name = string,
    subnet-id = string,
    zone-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "replica-priority": "integer",
    "shard-name": "string",
    "subnet-id": "string",
    "zone-id": "string"
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Whether the host should get a public IP address on creation. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
replica-priority -> (integer)
  A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100.
shard-name -> (string)
  ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards] request.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `map<string><string>`

Custom labels for the Redis cluster as 'key:value' pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary". ||
|| `--maintenance-window` | `shorthand/json`

Window of maintenance operations.

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

Name of the Redis cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--persistence-mode` | `enum`

Persistence mode Possible Values: 'on', 'off', 'on-replicas' ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--sharded` | Redis cluster mode on/off. ||
|| `--tls-enabled` | TLS port and functionality on\off ||
|| `--user-specs` | `shorthand/json`

Descriptions of users to be created in the Redis cluster.

Shorthand Syntax:

```hcl
[
  {
    enabled = boolean,
    name = string,
    passwords = string,...,
    permissions = {
      categories = string,
      commands = string,
      patterns = string,
      pub-sub-channels = string,
      sanitize-payload = string
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "enabled": "boolean",
    "name": "string",
    "passwords": [
      "string", ...
    ],
    "permissions": {
      "categories": "string",
      "commands": "string",
      "patterns": "string",
      "pub-sub-channels": "string",
      "sanitize-payload": "string"
    }
  }, ...
]
```

Fields:

```
enabled -> (boolean)
  Is Redis user enabled
name -> (string)
  Name of the Redis user.
passwords -> ([]string)
  Password of the Redis user.
permissions -> (struct)
  Set of permissions to grant to the user.
  categories -> (string)
    Command categories user has permissions to.
  commands -> (string)
    Commands user can execute.
  patterns -> (string)
    Keys patterns user has permission to.
  pub-sub-channels -> (string)
    Channel patterns user has permissions to.
  sanitize-payload -> (string)
    SanitizePayload parameter.
``` ||
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