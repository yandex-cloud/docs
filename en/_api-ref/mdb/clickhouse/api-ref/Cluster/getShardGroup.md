---
editable: false
---

# Method getShardGroup
Returns the specified shard group.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the shard group belongs to.</p> <p>To get the cluster ID, make a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
shardGroupName | <p>Required. Name of the shard group to request information about.</p> <p>To get the name of a shard group, make a <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups">listShardGroups</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "description": "string",
  "shardNames": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Name of the shard group.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster that the shard group belongs to.</p> 
description | **string**<br><p>Description of the shard group. 0-256 characters long.</p> 
shardNames[] | **string**<br><p>List of shard names contained in the shard group.</p> 