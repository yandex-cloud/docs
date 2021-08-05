---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method getShard
Returns the specified shard.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MongoDB cluster that the shard belongs to. To get the cluster ID use a [list](/docs/managed-mongodb/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
shardName | Required. Name of the MongoDB shard to return. To get the name of the shard use a [listShards](/docs/managed-mongodb/api-ref/Cluster/listShards) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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