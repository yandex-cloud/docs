[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Valkey™](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > Update

# Managed Service for Redis API, gRPC: ClusterService.Update

Updates the specified Redis cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.mdb.redis.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.mdb.redis.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
    "version": "string",
    // Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`
    "redis_config_5_0": {
      "maxmemory_policy": "MaxmemoryPolicy",
      "timeout": "google.protobuf.Int64Value",
      "password": "string",
      "databases": "google.protobuf.Int64Value",
      "slowlog_log_slower_than": "google.protobuf.Int64Value",
      "slowlog_max_len": "google.protobuf.Int64Value",
      "notify_keyspace_events": "string",
      "client_output_buffer_limit_pubsub": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "client_output_buffer_limit_normal": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      }
    },
    "redis_config_6_0": {
      "maxmemory_policy": "MaxmemoryPolicy",
      "timeout": "google.protobuf.Int64Value",
      "password": "string",
      "databases": "google.protobuf.Int64Value",
      "slowlog_log_slower_than": "google.protobuf.Int64Value",
      "slowlog_max_len": "google.protobuf.Int64Value",
      "notify_keyspace_events": "string",
      "client_output_buffer_limit_pubsub": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "client_output_buffer_limit_normal": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      }
    },
    "redis_config_6_2": {
      "maxmemory_policy": "MaxmemoryPolicy",
      "timeout": "google.protobuf.Int64Value",
      "password": "string",
      "databases": "google.protobuf.Int64Value",
      "slowlog_log_slower_than": "google.protobuf.Int64Value",
      "slowlog_max_len": "google.protobuf.Int64Value",
      "notify_keyspace_events": "string",
      "client_output_buffer_limit_pubsub": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "client_output_buffer_limit_normal": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "maxmemory_percent": "google.protobuf.Int64Value"
    },
    "redis_config_7_0": {
      "maxmemory_policy": "MaxmemoryPolicy",
      "timeout": "google.protobuf.Int64Value",
      "password": "string",
      "databases": "google.protobuf.Int64Value",
      "slowlog_log_slower_than": "google.protobuf.Int64Value",
      "slowlog_max_len": "google.protobuf.Int64Value",
      "notify_keyspace_events": "string",
      "client_output_buffer_limit_pubsub": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "client_output_buffer_limit_normal": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "maxmemory_percent": "google.protobuf.Int64Value"
    },
    // end of the list of possible fields
    "resources": {
      "resource_preset_id": "string",
      "disk_size": "int64",
      "disk_type_id": "string"
    },
    "backup_window_start": "google.type.TimeOfDay",
    "access": {
      "data_lens": "bool",
      "web_sql": "bool"
    },
    "redis": {
      "maxmemory_policy": "MaxmemoryPolicy",
      "timeout": "google.protobuf.Int64Value",
      "password": "string",
      "databases": "google.protobuf.Int64Value",
      "slowlog_log_slower_than": "google.protobuf.Int64Value",
      "slowlog_max_len": "google.protobuf.Int64Value",
      "notify_keyspace_events": "string",
      "client_output_buffer_limit_pubsub": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "client_output_buffer_limit_normal": {
        "hard_limit": "google.protobuf.Int64Value",
        "soft_limit": "google.protobuf.Int64Value",
        "soft_seconds": "google.protobuf.Int64Value"
      },
      "maxmemory_percent": "google.protobuf.Int64Value",
      "lua_time_limit": "google.protobuf.Int64Value",
      "repl_backlog_size_percent": "google.protobuf.Int64Value",
      "cluster_require_full_coverage": "google.protobuf.BoolValue",
      "cluster_allow_reads_when_down": "google.protobuf.BoolValue",
      "cluster_allow_pubsubshard_when_down": "google.protobuf.BoolValue",
      "lfu_decay_time": "google.protobuf.Int64Value",
      "lfu_log_factor": "google.protobuf.Int64Value",
      "turn_before_switchover": "google.protobuf.BoolValue",
      "allow_data_loss": "google.protobuf.BoolValue",
      "use_luajit": "google.protobuf.BoolValue",
      "io_threads_allowed": "google.protobuf.BoolValue",
      "zset_max_listpack_entries": "google.protobuf.Int64Value",
      "aof_max_size_percent": "google.protobuf.Int64Value",
      "activedefrag": "google.protobuf.BoolValue",
      "audit_log": "google.protobuf.BoolValue"
    },
    "disk_size_autoscaling": {
      "planned_usage_threshold": "google.protobuf.Int64Value",
      "emergency_usage_threshold": "google.protobuf.Int64Value",
      "disk_size_limit": "google.protobuf.Int64Value"
    },
    "backup_retain_period_days": "google.protobuf.Int64Value",
    "modules": {
      "valkey_search": {
        "enabled": "bool",
        "reader_threads": "google.protobuf.Int64Value",
        "writer_threads": "google.protobuf.Int64Value",
        "version": "string"
      },
      "valkey_json": {
        "enabled": "bool",
        "version": "string"
      },
      "valkey_bloom": {
        "enabled": "bool",
        "version": "string"
      }
    }
  },
  "name": "string",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "persistence_mode": "PersistenceMode",
  "network_id": "string",
  "announce_hostnames": "bool",
  "auth_sentinel": "bool"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster to update.
To get the Redis cluster ID, use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Redis cluster should be updated. ||
|| description | **string**

New description of the Redis cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Redis cluster as `` key:value `` pairs. Maximum 64 per cluster.
For example, "project": "mvp" or "source": "dictionary".
The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.redis.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| name | **string**

New name for the cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| persistence_mode | enum **PersistenceMode**

Persistence mode

- `ON`: Cluster persistence mode is on.
- `OFF`: Cluster persistence mode is off.
- `ON_REPLICAS`: Cluster persistence is on for replicas only. ||
|| network_id | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 150. ||
|| announce_hostnames | **bool**

Enable FQDN instead of ip ||
|| auth_sentinel | **bool**

Allows to use ACL users to auth in sentinel ||
|#

## ConfigSpec {#yandex.cloud.mdb.redis.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of Redis used in the cluster. ||
|| redis_config_5_0 | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Configuration of a Redis 5.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration of a Redis cluster. ||
|| redis_config_6_0 | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Configuration of a Redis 6.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration of a Redis cluster. ||
|| redis_config_6_2 | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Configuration of a Redis 6.2 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration of a Redis cluster. ||
|| redis_config_7_0 | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Configuration of a Redis 7.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration of a Redis cluster. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**

Resources allocated to Redis hosts. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.redis.v1.Access)**

Access policy to DB ||
|| redis | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Unified configuration of a Redis cluster ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days

Acceptable values are 7 to 60, inclusive. ||
|| modules | **[ValkeyModules](#yandex.cloud.mdb.redis.v1.ValkeyModules)**

Valkey modules settings ||
|#

## RedisConfig5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](../../../concepts/instance-types.md).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

Value must be greater than 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log.

The minimum value is 0. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,12} `. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes.

The minimum value is 0. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period.

The minimum value is 0. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](../../../concepts/instance-types.md).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

Value must be greater than 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log.

The minimum value is 0. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes.

The minimum value is 0. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period.

The minimum value is 0. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](../../../concepts/instance-types.md).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log.

The minimum value is 0. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes.

The minimum value is 0. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period.

The minimum value is 0. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](../../../concepts/instance-types.md).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log.

The minimum value is 0. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes.

The minimum value is 0. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period.

The minimum value is 0. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit.

The minimum value is 0. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](../../../concepts/instance-types.md). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|#

## RedisConfig {#yandex.cloud.mdb.redis.v1.config.RedisConfig}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](../../../concepts/instance-types.md).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process.

Acceptable values are 1 to 1024, inclusive. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 10. ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log.

The minimum value is 0. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|| lua_time_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism

Acceptable values are 0 to 5000, inclusive. ||
|| repl_backlog_size_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication backlog size as a percentage of flavor maxmemory

Acceptable values are 1 to 75, inclusive. ||
|| cluster_require_full_coverage | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether all hash slots must be covered by nodes ||
|| cluster_allow_reads_when_down | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows read operations when cluster is down ||
|| cluster_allow_pubsubshard_when_down | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Permits Pub/Sub shard operations when cluster is down ||
|| lfu_decay_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10)

Acceptable values are 0 to 100000, inclusive. ||
|| lfu_log_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Determines how the frequency counter represents key hits.

Acceptable values are 0 to 1000, inclusive. ||
|| turn_before_switchover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to turn before switchover in RDSync ||
|| allow_data_loss | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows some data to be lost in favor of faster switchover/restart ||
|| use_luajit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Use JIT for lua scripts and functions ||
|| io_threads_allowed | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allow redis to use io-threads ||
|| zset_max_listpack_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist

Acceptable values are 32 to 2048, inclusive. ||
|| aof_max_size_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

AOF maximum size as a percentage of disk available

Acceptable values are 1 to 99, inclusive. ||
|| activedefrag | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable active (online) memory defragmentation ||
|| audit_log | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable/disable audit logs for Valkey ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes.

The minimum value is 0. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period.

The minimum value is 0. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit.

The minimum value is 0. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## ValkeyModules {#yandex.cloud.mdb.redis.v1.ValkeyModules}

#|
||Field | Description ||
|| valkey_search | **[ValkeySearch](#yandex.cloud.mdb.redis.v1.ValkeySearch)**

valkey-search module settings ||
|| valkey_json | **[ValkeyJson](#yandex.cloud.mdb.redis.v1.ValkeyJson)**

valkey-json module settings ||
|| valkey_bloom | **[ValkeyBloom](#yandex.cloud.mdb.redis.v1.ValkeyBloom)**

valkey-bloom module settings ||
|#

## ValkeySearch {#yandex.cloud.mdb.redis.v1.ValkeySearch}

#|
||Field | Description ||
|| enabled | **bool**

Enable valkey-search module ||
|| reader_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls the amount of threads executing queries

The minimum value is 0. ||
|| writer_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls the amount of threads processing index mutations

The minimum value is 0. ||
|| version | **string**

Module version ||
|#

## ValkeyJson {#yandex.cloud.mdb.redis.v1.ValkeyJson}

#|
||Field | Description ||
|| enabled | **bool**

Enable valkey-json module ||
|| version | **string**

Module version ||
|#

## ValkeyBloom {#yandex.cloud.mdb.redis.v1.ValkeyBloom}

#|
||Field | Description ||
|| enabled | **bool**

Enable valkey-bloom module ||
|| version | **string**

Module version ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.redis.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.redis.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format).

Acceptable values are 1 to 24, inclusive. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#