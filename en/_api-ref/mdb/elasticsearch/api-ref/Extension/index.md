---
editable: false
---

# Extension

## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates new extension version.
[delete](delete.md) | Deletes the specified extension.
[get](get.md) | Returns the specified extension of Elasticsearch cluster.
[list](list.md) | Returns the list of available extensions for the specified Elasticsearch cluster.
[update](update.md) | Updates the specified extension.