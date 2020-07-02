---
editable: false
---

# Cluster
A set of methods for managing Redis clusters.
## JSON Representation {#representation}
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
      "diskSize": "string"
    },
    "redisConfig_5_0": {
      "effectiveConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string"
      },
      "userConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string"
      },
      "defaultConfig": {
        "maxmemoryPolicy": "string",
        "timeout": "integer",
        "password": "string"
      }
    }
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Redis cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Redis cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the Redis cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Redis cluster as <code>key:value</code> pairs. Maximum 64 per cluster.</p> 
environment | **string**<br><p>Deployment environment of the Redis cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Redis cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Redis cluster.</p> 
config | **object**<br><p>Configuration of the Redis cluster.</p> 
config.<br>version | **string**<br><p>Version of Redis server software.</p> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-redis/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>redisConfig_5_0 | **object**<br>
config.<br>redisConfig_5_0.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 5.0 cluster (a combination of settings defined in <code>userConfig</code> and <code>defaultConfig</code>).</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
config.<br>redisConfig_5_0.<br>userConfig | **object**<br><p>User-defined settings for a Redis 5.0 cluster.</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 5.0 cluster.</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
networkId | **string**<br>
health | **string**<br><p>Aggregated cluster health</p> <ul> <li>HEALTH_UNKNOWN: Cluster is in unknown state (we have no data)</li> <li>ALIVE: Cluster is alive and well (all hosts are alive)</li> <li>DEAD: Cluster is inoperable (it cannot perform any of its essential functions)</li> <li>DEGRADED: Cluster is partially alive (it can perform some of its essential functions)</li> </ul> 
status | **string**<br><p>Cluster status</p> <ul> <li>STATUS_UNKNOWN: Cluster status is unknown</li> <li>CREATING: Cluster is being created</li> <li>RUNNING: Cluster is running</li> <li>ERROR: Cluster failed</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[addHosts](addHosts.md) | Creates new hosts for a cluster.
[backup](backup.md) | Creates a backup for the specified Redis cluster.
[create](create.md) | Creates a Redis cluster in the specified folder.
[delete](delete.md) | Deletes the specified Redis cluster.
[deleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster.
[get](get.md) | Returns the specified Redis cluster.
[list](list.md) | Retrieves the list of Redis clusters that belong to the specified folder.
[listBackups](listBackups.md) | Retrieves the list of available backups for the specified Redis cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified Redis cluster.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified cluster.
[restore](restore.md) | Creates a new Redis cluster using the specified backup.
[start](start.md) | Start the specified Redis cluster.
[startFailover](startFailover.md) | Start a manual failover on the specified Redis cluster.
[stop](stop.md) | Stop the specified Redis cluster.
[update](update.md) | Updates the specified Redis cluster.