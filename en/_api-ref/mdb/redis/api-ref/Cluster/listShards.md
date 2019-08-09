---
editable: false
---

# Method listShards
Retrieves a list of shards.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/shards
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "shards": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
shards[] | **object**<br>
shards[].<br>name | **string**<br><p>Name of the Redis shard. The host name is assigned by user at creation time, and cannot be changed. 1-63 characters long.</p> 
shards[].<br>clusterId | **string**<br><p>ID of the Redis cluster. The ID is assigned by MDB at creation time.</p> 
nextPageToken | **string**<br>