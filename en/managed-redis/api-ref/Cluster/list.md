---
editable: false
---

# Method list
Retrieves the list of Redis clusters that belong
to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1alpha/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list Redis clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-redis/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-redis/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-redis/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-redis/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters clusters listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-redis/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 3-63 characters long and match the regular expression `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>Description of a Redis cluster. For more information, see the Managed Service for Redis <a href="/docs/managed-redis/concepts/">documentation</a>.</p> 
clusters[].<br>id | **string**<br><p>ID of the Redis cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Redis cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the Redis cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Redis cluster as <code>key:value</code> pairs. Maximum 64 per cluster.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the Redis cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Redis cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Redis cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the Redis cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of Redis server software.</p> 
clusters[].<br>config.<br>resources | **object**<br>Resources allocated to Redis hosts.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-redis/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>redisConfig_5_0 | **object**<br>Configuration of a Redis 5.0 server.<br>
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig | **object**<br><p>Effective settings for a Redis 5.0 cluster (a combination of settings defined in <code>userConfig</code> and <code>defaultConfig</code>).</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig | **object**<br><p>User-defined settings for a Redis 5.0 cluster.</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig | **object**<br><p>Default configuration for a Redis 5.0 cluster.</p> <p>Fields and structure of <code>RedisConfig</code> reflects Redis configuration file parameters.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Redis key eviction policy for a dataset that reaches maximum memory, available to the host. Redis maxmemory setting depends on Managed Service for Redis <a href="/docs/managed-redis/concepts/instance-types">host class</a>.</p> <p>All policies are described in detail in <a href="https://redis.io/topics/lru-cache">Redis documentation</a>.</p> <ul> <li>VOLATILE_LRU: Try to remove less recently used (LRU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LRU: Remove less recently used (LRU) keys.</li> <li>VOLATILE_LFU: Try to remove least frequently used (LFU) keys with <code>expire set</code>.</li> <li>ALLKEYS_LFU: Remove least frequently used (LFU) keys.</li> <li>VOLATILE_RANDOM: Try to remove keys with <code>expire set</code> randomly.</li> <li>ALLKEYS_RANDOM: Remove keys randomly.</li> <li>VOLATILE_TTL: Try to remove less recently used (LRU) keys with <code>expire set</code> and shorter TTL first.</li> <li>NOEVICTION: Return errors when memory limit was reached and commands could require more memory to be used.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Time that Redis keeps the connection open while the client is idle. If no new command is sent during that time, the connection is closed.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>password | **string**<br><p>Authentication password.</p> <p>Value must match the regular expression <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>networkId | **string**<br>
clusters[].<br>health | **string**<br><p>Aggregated cluster health</p> <ul> <li>HEALTH_UNKNOWN: Cluster is in unknown state (we have no data)</li> <li>ALIVE: Cluster is alive and well (all hosts are alive)</li> <li>DEAD: Cluster is inoperable (it cannot perform any of its essential functions)</li> <li>DEGRADED: Cluster is partially alive (it can perform some of its essential functions)</li> </ul> 
clusters[].<br>status | **string**<br><p>Cluster status</p> <ul> <li>STATUS_UNKNOWN: Cluster status is unknown</li> <li>CREATING: Cluster is being created</li> <li>RUNNING: Cluster is running</li> <li>ERROR: Cluster failed</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-redis/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-redis/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-redis/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-redis/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 