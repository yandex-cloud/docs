---
editable: false
---

# Method get
Returns the specified Redis cluster.
 
To get the list of available Redis clusters, make a [list](/docs/managed-redis/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Redis cluster to return. To get the cluster ID use a <a href="/docs/managed-redis/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
      "dataLens": true
    },

    // `config` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`
    "redisConfig_5_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      }
    },
    "redisConfig_6_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      }
    },
    "redisConfig_6_2": {
      "effectiveConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      }
    },
    "redisConfig_7_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "userConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      },
      "defaultConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string",
        "databases": "integer",
        "slowlogLogSlowerThan": "integer",
        "slowlogMaxLen": "integer",
        "notifyKeyspaceEvents": "string",
        "clientOutputBufferLimitPubsub": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        },
        "clientOutputBufferLimitNormal": {
          "hardLimit": "integer",
          "softLimit": "integer",
          "softSeconds": "integer"
        }
      }
    },
    // end of the list of possible fields`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string",
  "sharded": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string"
  },
  "securityGroupIds": [
    "string"
  ],
  "tlsEnabled": true,
  "deletionProtection": true,
  "persistenceMode": "string"
}
```
Description of a Redis cluster. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Redis cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Redis cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the Redis cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Redis cluster as ``key:value`` pairs. Maximum 64 per cluster.</p> 
environment | **string**<br><p>Deployment environment of the Redis cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Redis cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Redis cluster.</p> 
config | **object**<br><p>Configuration of the Redis cluster.</p> 
config.<br>version | **string**<br><p>Version of Redis server software.</p> 
config.<br>resources | **object**<br>Resources allocated to Redis hosts.
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-redis/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>access | **object**<br>Access policy to DB
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
config.<br>redisConfig_5_0 | **object**<br>Configuration of a Redis 5.0 server. <br>`config` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br>
config.<br>redisConfig_5_0.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAt.</p> <p>Value must match the regular expression ``[KEg$lshzxeAt]{0,12}``.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig | **object**<br><p>User-defined settings for a Redis 5.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAt.</p> <p>Value must match the regular expression ``[KEg$lshzxeAt]{0,12}``.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 5.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAt.</p> <p>Value must match the regular expression ``[KEg$lshzxeAt]{0,12}``.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0 | **object**<br>Configuration of a Redis 6.0 server. <br>`config` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br>
config.<br>redisConfig_6_0.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig | **object**<br><p>User-defined settings for a Redis 6.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 6.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2 | **object**<br>Configuration of a Redis 6.2 server. <br>`config` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br>
config.<br>redisConfig_6_2.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 6.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig | **object**<br><p>User-defined settings for a Redis 6.2 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_2.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 6.2 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_6_2.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0 | **object**<br>Configuration of a Redis 7.0 server. <br>`config` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br>
config.<br>redisConfig_7_0.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 7.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>effectiveConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig | **object**<br><p>User-defined settings for a Redis 7.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_7_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>userConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 7.0 cluster.</p> <p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
config.<br>redisConfig_7_0.<br>defaultConfig.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
networkId | **string**
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Cluster is in unknown state (we have no data)</li> <li>ALIVE: Cluster is alive and well (all hosts are alive)</li> <li>DEAD: Cluster is inoperable (it cannot perform any of its essential functions)</li> <li>DEGRADED: Cluster is partially alive (it can perform some of its essential functions)</li> </ul> 
status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster status is unknown</li> <li>CREATING: Cluster is being created</li> <li>RUNNING: Cluster is running</li> <li>ERROR: Cluster failed</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
sharded | **boolean** (boolean)<br><p>Redis cluster mode on/off.</p> 
maintenanceWindow | **object**<br><p>Maintenance window for the cluster.</p> <p>A maintenance window settings.</p> 
maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Planned maintenance operation to be started for the cluster within the nearest <a href="/docs/managed-redis/api-ref/Cluster#representation">maintenanceWindow</a>.</p> <p>A planned maintenance operation.</p> 
plannedOperation.<br>info | **string**<br><p>Information about this maintenance operation.</p> <p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Time until which this maintenance operation is delayed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
tlsEnabled | **boolean** (boolean)<br><p>TLS port and functionality on\off</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
persistenceMode | **string**<br><p>Persistence mode</p> 