---
editable: false
---

# Method getShard
Returns the specified shard.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Redis cluster the shard belongs to. To get the cluster ID use a [list](/docs/managed-redis/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
shardName | Required. Name of Redis shard to return. To get the shard name use a [listShards](/docs/managed-redis/api-ref/Cluster/listShards) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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