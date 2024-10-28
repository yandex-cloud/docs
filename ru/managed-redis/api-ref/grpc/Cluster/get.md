---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/get.md
---

# Managed Service for Redis API, gRPC: ClusterService.Get {#Get}

Returns the specified Redis cluster.

To get the list of available Redis clusters, make a [List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request.

## gRPC request

**rpc Get ([GetClusterRequest](#yandex.cloud.mdb.redis.v1.GetClusterRequest)) returns ([Cluster](#yandex.cloud.mdb.redis.v1.Cluster))**

## GetClusterRequest {#yandex.cloud.mdb.redis.v1.GetClusterRequest}

```json
{
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to return.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|#

## Cluster {#yandex.cloud.mdb.redis.v1.Cluster}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "Environment",
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
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      }
    },
    "redisConfig_6_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        }
      }
    },
    "redisConfig_6_2": {
      "effectiveConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      },
      "userConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      },
      "defaultConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      }
    },
    "redisConfig_7_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      },
      "userConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      },
      "defaultConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value"
      }
    },
    // end of the list of possible fields
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "int64",
      "diskTypeId": "string"
    },
    "backupWindowStart": "google.type.TimeOfDay",
    "access": {
      "dataLens": "bool",
      "webSql": "bool"
    },
    "redis": {
      "effectiveConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value",
        "luaTimeLimit": "google.protobuf.Int64Value",
        "replBacklogSizePercent": "google.protobuf.Int64Value",
        "clusterRequireFullCoverage": "google.protobuf.BoolValue",
        "clusterAllowReadsWhenDown": "google.protobuf.BoolValue",
        "clusterAllowPubsubshardWhenDown": "google.protobuf.BoolValue",
        "lfuDecayTime": "google.protobuf.Int64Value",
        "lfuLogFactor": "google.protobuf.Int64Value",
        "turnBeforeSwitchover": "google.protobuf.BoolValue",
        "allowDataLoss": "google.protobuf.BoolValue"
      },
      "userConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value",
        "luaTimeLimit": "google.protobuf.Int64Value",
        "replBacklogSizePercent": "google.protobuf.Int64Value",
        "clusterRequireFullCoverage": "google.protobuf.BoolValue",
        "clusterAllowReadsWhenDown": "google.protobuf.BoolValue",
        "clusterAllowPubsubshardWhenDown": "google.protobuf.BoolValue",
        "lfuDecayTime": "google.protobuf.Int64Value",
        "lfuLogFactor": "google.protobuf.Int64Value",
        "turnBeforeSwitchover": "google.protobuf.BoolValue",
        "allowDataLoss": "google.protobuf.BoolValue"
      },
      "defaultConfig": {
        "maxmemoryPolicy": "MaxmemoryPolicy",
        "timeout": "google.protobuf.Int64Value",
        "password": "string",
        "databases": "google.protobuf.Int64Value",
        "slowlogLogSlowerThan": "google.protobuf.Int64Value",
        "slowlogMaxLen": "google.protobuf.Int64Value",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "google.protobuf.Int64Value",
          "softLimit": "google.protobuf.Int64Value",
          "softSeconds": "google.protobuf.Int64Value"
        },
        "maxmemoryPercent": "google.protobuf.Int64Value",
        "luaTimeLimit": "google.protobuf.Int64Value",
        "replBacklogSizePercent": "google.protobuf.Int64Value",
        "clusterRequireFullCoverage": "google.protobuf.BoolValue",
        "clusterAllowReadsWhenDown": "google.protobuf.BoolValue",
        "clusterAllowPubsubshardWhenDown": "google.protobuf.BoolValue",
        "lfuDecayTime": "google.protobuf.Int64Value",
        "lfuLogFactor": "google.protobuf.Int64Value",
        "turnBeforeSwitchover": "google.protobuf.BoolValue",
        "allowDataLoss": "google.protobuf.BoolValue"
      }
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "google.protobuf.Int64Value",
      "emergencyUsageThreshold": "google.protobuf.Int64Value",
      "diskSizeLimit": "google.protobuf.Int64Value"
    }
  },
  "networkId": "string",
  "health": "Health",
  "status": "Status",
  "sharded": "bool",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "AnytimeMaintenanceWindow",
    "weeklyMaintenanceWindow": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "google.protobuf.Timestamp"
  },
  "securityGroupIds": [
    "string"
  ],
  "tlsEnabled": "bool",
  "deletionProtection": "bool",
  "persistenceMode": "PersistenceMode",
  "announceHostnames": "bool"
}
```

Description of a Redis cluster. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the Redis cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the Redis cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the Redis cluster.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the Redis cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the Redis cluster as `key:value` pairs.
Maximum 64 per cluster. ||
|| environment | enum **Environment**

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
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)
- `ALIVE`: Cluster is alive and well (all hosts are alive)
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions) ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster status is unknown
- `CREATING`: Cluster is being created
- `RUNNING`: Cluster is running
- `ERROR`: Cluster failed
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| sharded | **bool**

Redis cluster mode on/off. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.redis.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| tlsEnabled | **bool**

TLS port and functionality on\off ||
|| deletionProtection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| persistenceMode | enum **PersistenceMode**

Persistence mode

- `ON`: cluster persistence mode on
- `OFF`: cluster persistence mode off ||
|| announceHostnames | **bool**

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
|| backupWindowStart | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

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
|| maxmemoryPolicy | enum **MaxmemoryPolicy**

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
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| hardLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| softLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| softSeconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| maxmemoryPolicy | enum **MaxmemoryPolicy**

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
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| hardLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| softLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| softSeconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| maxmemoryPolicy | enum **MaxmemoryPolicy**

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
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| softLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| softSeconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| maxmemoryPolicy | enum **MaxmemoryPolicy**

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
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| softLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| softSeconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| dataLens | **bool**

Allow access for DataLens ||
|| webSql | **bool**

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
|| maxmemoryPolicy | enum **MaxmemoryPolicy**

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
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlogLogSlowerThan | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlogMaxLen | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|| luaTimeLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism ||
|| replBacklogSizePercent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication backlog size as a percentage of flavor maxmemory ||
|| clusterRequireFullCoverage | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether all hash slots must be covered by nodes ||
|| clusterAllowReadsWhenDown | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows read operations when cluster is down ||
|| clusterAllowPubsubshardWhenDown | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Permits Pub/Sub shard operations when cluster is down ||
|| lfuDecayTime | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10) ||
|| lfuLogFactor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Determines how the frequency counter represents key hits. ||
|| turnBeforeSwitchover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to turn before switchover in RDSync ||
|| allowDataLoss | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows some data to be lost in favor of faster switchover/restart ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| softLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| softSeconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.redis.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

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

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.redis.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#