---
editable: false
---

# Method get
Returns the specified extension of Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}/extensions/{extensionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the cluster.  The maximum string length in characters is 50.
extensionId | Required. Required. ID of the extension to return.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "id": "string",
  "clusterId": "string",
  "version": "string",
  "active": true
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Name of the extension.</p> 
id | **string**<br><p>Extension unique ID</p> 
clusterId | **string**<br><p>ID of the Elasticsearch cluster the extension belongs to.</p> 
version | **string** (int64)<br><p>Extension version</p> 
active | **boolean** (boolean)<br><p>Flag is extension active now</p> 