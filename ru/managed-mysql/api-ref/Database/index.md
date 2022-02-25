---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Database/index.md
---


# Database
A set of methods for managing MySQL databases.
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
clusterId | **string**<br><p>ID of the MySQL cluster that the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new MySQL database in the specified cluster.
[delete](delete.md) | Deletes the specified MySQL database.
[get](get.md) | Returns the specified MySQL database.
[list](list.md) | Retrieves the list of MySQL databases in the specified cluster.