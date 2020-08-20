---
editable: false
---

# Database
A set of methods for managing SQLServer databases.
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
clusterId | **string**<br><p>ID of the sqlserver cluster that the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new SQLServer database in the specified cluster.
[delete](delete.md) | Deletes the specified SQLServer database.
[get](get.md) | Returns the specified SQLServer database.
[list](list.md) | Retrieves the list of SQLServer databases in the specified cluster.