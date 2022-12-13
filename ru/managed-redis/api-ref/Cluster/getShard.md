---
editable: false
sourcePath: en/_api-ref/mdb/redis/api-ref/Cluster/getShard.md
---

# Managed Service for Redis API, REST: Cluster.getShard
Returns the specified shard.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Redis cluster the shard belongs to. To get the cluster ID use a <a href="/docs/managed-redis/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
shardName | <p>Required. Name of Redis shard to return. To get the shard name use a <a href="/docs/managed-redis/api-ref/Cluster/listShards">listShards</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed. 1-63 characters long.</p> 
clusterId | **string**<br><p>ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time.</p> 