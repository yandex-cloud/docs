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
clusterId | Required. The maximum string length in characters is 50.
shardName | Required. The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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
name | **string**<br><p>Name of the Redis shard. The host name is assigned by user at creation time, and cannot be changed. 1-63 characters long.</p> 
clusterId | **string**<br><p>ID of the Redis cluster. The ID is assigned by MDB at creation time.</p> 