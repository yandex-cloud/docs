---
editable: false
---

# Database
A set of methods for managing ClickHouse Database resources.
NOTE: these methods are available only if database management through SQL is disabled.
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
clusterId | **string**<br><p>ID of the ClickHouse cluster that the database belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new ClickHouse database in the specified cluster.
[delete](delete.md) | Deletes the specified ClickHouse database.
[get](get.md) | Returns the specified ClickHouse Database resource.
[list](list.md) | Retrieves the list of ClickHouse Database resources in the specified cluster.