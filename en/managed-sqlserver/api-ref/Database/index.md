---
editable: false
---

# Database
A set of methods for managing SQL Server databases.
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
clusterId | **string**<br><p>ID of the SQL Server cluster the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new SQL Server database in the specified cluster.
[delete](delete.md) | Deletes the specified SQL Server database.
[get](get.md) | Returns the specified SQL Server database.
[list](list.md) | Retrieves the list of SQL Server databases in the specified cluster.
[restore](restore.md) | Creates a new SQL Server database in the specified cluster from a backup