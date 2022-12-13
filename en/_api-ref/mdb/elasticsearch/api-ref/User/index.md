---
editable: false
---

# Managed Service for Elasticsearch API, REST: User methods
A set of methods for managing Elasticsearch users.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "clusterId": "string"
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the Elasticsearch user.</p> 
clusterId | **string**<br><p>ID of the Elasticsearch cluster the user belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a user in the specified cluster.
[delete](delete.md) | Deletes the specified user.
[get](get.md) | Returns the specified Elasticsearch user.
[list](list.md) | Retrieves the list of Elasticsearch users in the specified cluster.
[update](update.md) | Updates the specified user.