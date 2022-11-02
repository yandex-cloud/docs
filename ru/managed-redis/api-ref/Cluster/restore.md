---
editable: false
sourcePath: en/_api-ref/mdb/redis/api-ref/Cluster/restore.md
---

# Method restore
Creates a new Redis cluster using the specified backup.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-redis/v1/clusters:restore
```
 
## Body parameters {#body_params}
 
```json 
{
  "backupId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
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

    // `configSpec` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`
    "redisConfig_5_0": {
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
    "redisConfig_6_0": {
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
    "redisConfig_6_2": {
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
    "redisConfig_7_0": {
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
    // end of the list of possible fields`configSpec`

  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "shardName": "string",
      "replicaPriority": "integer",
      "assignPublicIp": true
    }
  ],
  "networkId": "string",
  "folderId": "string",
  "securityGroupIds": [
    "string"
  ],
  "tlsEnabled": true,
  "persistenceMode": "string",
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
backupId | **string**<br><p>Required. ID of the backup to create a cluster from. To get the backup ID, use a <a href="/docs/managed-redis/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
name | **string**<br><p>Required. Name of the new Redis cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the new Redis cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Redis cluster as ``key:value`` pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary".</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Required. Deployment environment of the new Redis cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Configuration for the Redis cluster to be created.</p> 
configSpec.<br>version | **string**<br><p>Version of Redis used in the cluster.</p> 
configSpec.<br>resources | **object**<br>Resources allocated to Redis hosts.
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-redis/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br>Access policy to DB
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
configSpec.<br>redisConfig_5_0 | **object** <br>`configSpec` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br><br><p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
configSpec.<br>redisConfig_5_0.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
configSpec.<br>redisConfig_5_0.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
configSpec.<br>redisConfig_5_0.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
configSpec.<br>redisConfig_5_0.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>redisConfig_5_0.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAt.</p> <p>Value must match the regular expression ``[KEg$lshzxeAt]{0,12}``.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_5_0.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0 | **object** <br>`configSpec` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br><br><p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
configSpec.<br>redisConfig_6_0.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
configSpec.<br>redisConfig_6_0.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
configSpec.<br>redisConfig_6_0.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
configSpec.<br>redisConfig_6_0.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>redisConfig_6_0.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_0.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2 | **object** <br>`configSpec` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br><br><p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
configSpec.<br>redisConfig_6_2.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
configSpec.<br>redisConfig_6_2.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
configSpec.<br>redisConfig_6_2.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
configSpec.<br>redisConfig_6_2.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>redisConfig_6_2.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_6_2.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0 | **object** <br>`configSpec` includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`<br><br><p>Fields and structure of ``RedisConfig`` reflects Redis configuration file parameters.</p> 
configSpec.<br>redisConfig_7_0.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with ``expire set``.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with ``expire set``.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with ``expire set`` randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with ``expire set`` and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
configSpec.<br>redisConfig_7_0.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
configSpec.<br>redisConfig_7_0.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression ``[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}``.</p> 
configSpec.<br>redisConfig_7_0.<br>databases | **integer** (int64)<br><p>Number of database buckets on a single redis-server process.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>redisConfig_7_0.<br>slowlogLogSlowerThan | **integer** (int64)<br><p>Threshold for logging slow requests to server in microseconds (log only slower than it).</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>slowlogMaxLen | **integer** (int64)<br><p>Max slow requests number to log.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>notifyKeyspaceEvents | **string**<br><p>String setting for pub\sub functionality; subset of KEg$lshzxeAtm.</p> <p>Value must match the regular expression ``[KEg$lshzxeAtm]{0,13}``.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitPubsub | **object**<br><p>Redis connection output buffers limits for pubsub operations.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitPubsub.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitPubsub.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitPubsub.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitNormal | **object**<br><p>Redis connection output buffers limits for clients.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitNormal.<br>hardLimit | **integer** (int64)<br><p>Total limit in bytes.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitNormal.<br>softLimit | **integer** (int64)<br><p>Limit in bytes during certain time period.</p> <p>The minimum value is 0.</p> 
configSpec.<br>redisConfig_7_0.<br>clientOutputBufferLimitNormal.<br>softSeconds | **integer** (int64)<br><p>Seconds for soft limit.</p> <p>The minimum value is 0.</p> 
hostSpecs[] | **object**<br><p>Required. Configurations for Redis hosts that should be created for the cluster that is being created from the backup.</p> <p>Must contain at least one element.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-redis/api-ref/Cluster#representation">Cluster.networkId</a>.</p> 
hostSpecs[].<br>shardName | **string**<br><p>ID of the Redis shard the host belongs to. To get the shard ID use a <a href="/docs/managed-redis/api-ref/Cluster/listShards">listShards</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
hostSpecs[].<br>replicaPriority | **integer** (int64)<br><p>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>Possible values:</p> <ul> <li>false - don't assign a public IP to the host.</li> <li>true - the host should have a public IP address.</li> </ul> 
networkId | **string**<br><p>Required. ID of the network to create the Redis cluster in.</p> <p>The maximum string length in characters is 50.</p> 
folderId | **string**<br><p>ID of the folder to create the Redis cluster in.</p> <p>The maximum string length in characters is 50.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
tlsEnabled | **boolean** (boolean)<br><p>TLS port and functionality on\off</p> 
persistenceMode | **string**<br><p>Persistence mode</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 