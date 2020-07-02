---
editable: false
---

# Method getShardGroup
Returns the specified shard group.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster that the shard group belongs to.  The maximum string length in characters is 50.
shardGroupName | Required. Name of the shard group to request information about. To get the name of a shard group , use a [listShardGroups](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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
name | **string**<br><p>Name of the shard group</p> 
clusterId | **string**<br><p>ID of the cluster that the shard belongs to.</p> 
description | **string**<br><p>Description of the ClickHouse cluster shard group. 0-256 characters long.</p> 
shardNames[] | **string**<br><p>List of shard names contained in shard group</p> 