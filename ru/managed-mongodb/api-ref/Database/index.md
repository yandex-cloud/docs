---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Database/index.md
---

# Managed Service for MongoDB API, REST: Database methods
A set of methods for managing MongoDB Database resources.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "clusterId": "string"
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the MongoDB cluster that the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new MongoDB database in the specified cluster.
[delete](delete.md) | Deletes the specified MongoDB database.
[get](get.md) | Returns the specified MongoDB Database resource.
[list](list.md) | Retrieves the list of MongoDB Database resources in the specified cluster.