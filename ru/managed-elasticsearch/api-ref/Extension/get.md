---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Extension/get.md
---

# Method get
Returns the specified extension of Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions/{extensionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster.</p> <p>The maximum string length in characters is 50.</p> 
extensionId | <p>Required. ID of the extension to return.</p> 
 
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
id | **string**<br><p>Unique ID of the extension.</p> 
clusterId | **string**<br><p>ID of the Elasticsearch cluster the extension belongs to.</p> 
version | **string** (int64)<br><p>Version of the extension.</p> 
active | **boolean** (boolean)<br><p>The flag shows whether the extension is active.</p> 