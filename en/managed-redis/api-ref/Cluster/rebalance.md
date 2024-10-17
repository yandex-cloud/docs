---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Cluster/rebalance.md
---

# Managed Service for Redis API, REST: Cluster.Rebalance {#Rebalance}

Rebalances the cluster. Evenly distributes all the hash slots between the shards.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}:rebalance
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to rebalance.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "environment": "string",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      // Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`
      "redisConfig_5_0": {
        "effectiveConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        },
        "userConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        },
        "defaultConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        }
      },
      "redisConfig_6_0": {
        "effectiveConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        },
        "userConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        },
        "defaultConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          }
        }
      },
      "redisConfig_6_2": {
        "effectiveConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "userConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "defaultConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        }
      },
      "redisConfig_7_0": {
        "effectiveConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "userConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "defaultConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        }
      },
      // end of the list of possible fields
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean"
      },
      "redis": {
        "effectiveConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "userConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        },
        "defaultConfig": {
          "maxmemoryPolicy": "string",
          "timeout": "string",
          "password": "string",
          "databases": "string",
          "slowlogLogSlowerThan": "string",
          "slowlogMaxLen": "string",
          "notifyKeyspaceEvents": "string",
          "clientOutputBufferLimitPubsub": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "clientOutputBufferLimitNormal": {
            "hardLimit": "string",
            "softLimit": "string",
            "softSeconds": "string"
          },
          "maxmemoryPercent": "string"
        }
      },
      "diskSizeAutoscaling": {
        "plannedUsageThreshold": "string",
        "emergencyUsageThreshold": "string",
        "diskSizeLimit": "string"
      }
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "sharded": "boolean",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    },
    "securityGroupIds": [
      "string"
    ],
    "tlsEnabled": "boolean",
    "deletionProtection": "boolean",
    "persistenceMode": "string",
    "announceHostnames": "boolean"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[RebalanceClusterMetadata](#yandex.cloud.mdb.redis.v1.RebalanceClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.redis.v1.Cluster)**

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

## RebalanceClusterMetadata {#yandex.cloud.mdb.redis.v1.RebalanceClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Redis cluster that is being rebalancing. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.redis.v1.Cluster}

Description of a Redis cluster. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the Redis cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the Redis cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Redis cluster.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the Redis cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the Redis cluster as `key:value` pairs.
Maximum 64 per cluster. ||
|| environment | **enum** (Environment)

Deployment environment of the Redis cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.redis.v1.Monitoring)**

Description of monitoring systems relevant to the Redis cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.redis.v1.ClusterConfig)**

Configuration of the Redis cluster. ||
|| networkId | **string** ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)
- `ALIVE`: Cluster is alive and well (all hosts are alive)
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions) ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster status is unknown
- `CREATING`: Cluster is being created
- `RUNNING`: Cluster is running
- `ERROR`: Cluster failed
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| sharded | **boolean**

Redis cluster mode on/off. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.redis.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| tlsEnabled | **boolean**

TLS port and functionality on\off ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| persistenceMode | **enum** (PersistenceMode)

Persistence mode

- `ON`: cluster persistence mode on
- `OFF`: cluster persistence mode off ||
|| announceHostnames | **boolean**

Enable FQDN instead of ip ||
|#

## Monitoring {#yandex.cloud.mdb.redis.v1.Monitoring}

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Redis cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.redis.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of Redis server software. ||
|| redisConfig_5_0 | **[RedisConfigSet5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0)**

Configuration of a Redis 5.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration for Redis servers in the cluster. ||
|| redisConfig_6_0 | **[RedisConfigSet6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0)**

Configuration of a Redis 6.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration for Redis servers in the cluster. ||
|| redisConfig_6_2 | **[RedisConfigSet6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2)**

Configuration of a Redis 6.2 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration for Redis servers in the cluster. ||
|| redisConfig_7_0 | **[RedisConfigSet7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0)**

Configuration of a Redis 7.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration for Redis servers in the cluster. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**

Resources allocated to Redis hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.redis.v1.Access)**

Access policy to DB ||
|| redis | **[RedisConfigSet](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet)**

Unified configuration of a Redis cluster. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## RedisConfigSet5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Effective settings for a Redis 5.0 cluster (a combination of settings
defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

User-defined settings for a Redis 5.0 cluster. ||
|| defaultConfig | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Default configuration for a Redis 5.0 cluster. ||
|#

## RedisConfig5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
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
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period. ||
|| softSeconds | **string** (int64)

Seconds for soft limit. ||
|#

## RedisConfigSet6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Effective settings for a Redis 6.0 cluster (a combination of settings
defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

User-defined settings for a Redis 6.0 cluster. ||
|| defaultConfig | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Default configuration for a Redis 6.0 cluster. ||
|#

## RedisConfig6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
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
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period. ||
|| softSeconds | **string** (int64)

Seconds for soft limit. ||
|#

## RedisConfigSet6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Effective settings for a Redis 6.2 cluster (a combination of settings
defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

User-defined settings for a Redis 6.2 cluster. ||
|| defaultConfig | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Default configuration for a Redis 6.2 cluster. ||
|#

## RedisConfig6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
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
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period. ||
|| softSeconds | **string** (int64)

Seconds for soft limit. ||
|#

## RedisConfigSet7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Effective settings for a Redis 7.0 cluster (a combination of settings
defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

User-defined settings for a Redis 7.0 cluster. ||
|| defaultConfig | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Default configuration for a Redis 7.0 cluster. ||
|#

## RedisConfig7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
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
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period. ||
|| softSeconds | **string** (int64)

Seconds for soft limit. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow access for DataLens ||
|| webSql | **boolean**

Allow access for Web SQL. ||
|#

## RedisConfigSet {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Effective settings for a Redis cluster (a combination of settings
defined in `userConfig` and `defaultConfig`). ||
|| userConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

User-defined settings for a Redis cluster. ||
|| defaultConfig | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Default configuration for a Redis cluster. ||
|#

## RedisConfig {#yandex.cloud.mdb.redis.v1.config.RedisConfig}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
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
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period. ||
|| softSeconds | **string** (int64)

Seconds for soft limit. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.redis.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#