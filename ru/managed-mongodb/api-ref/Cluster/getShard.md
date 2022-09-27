---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/Cluster/getShard.md
---

# Method getShard
Returns the specified shard.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the MongoDB cluster that the shard belongs to. To get the cluster ID use a <a href="/docs/managed-mongodb/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
shardName | <p>Required. Name of the MongoDB shard to return. To get the name of the shard use a <a href="/docs/managed-mongodb/api-ref/Cluster/listShards">listShards</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
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
name | **string**<br><p>Name of the shard.</p> 
clusterId | **string**<br><p>ID of the cluster that the shard belongs to.</p> 