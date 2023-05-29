---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Database/index.md
---

# Managed Service for MySQL API, REST: Database methods
A set of methods for managing MySQL databases in a cluster.

See [the documentation](/docs/managed-mysql/operations/databases) for details.
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
clusterId | **string**<br><p>ID of the cluster that the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new database in a cluster.
[delete](delete.md) | Deletes a database from a cluster.
[get](get.md) | Retrieves information about the specified database.
[list](list.md) | Retrieves the list of databases in a cluster.