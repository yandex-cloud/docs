---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/User/index.md
---

# Managed Service for MongoDB API, REST: User methods
A set of methods for managing MongoDB User resources.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ]
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the MongoDB user.</p> 
clusterId | **string**<br><p>ID of the MongoDB cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><p>MongoDB roles for the ``databaseName`` database that the permission grants.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a MongoDB user in the specified cluster.
[delete](delete.md) | Deletes the specified MongoDB user.
[get](get.md) | Returns the specified MongoDB User resource.
[grantPermission](grantPermission.md) | Grants permission to the specified MongoDB user.
[list](list.md) | Retrieves the list of MongoDB User resources in the specified cluster.
[revokePermission](revokePermission.md) | Revokes permission from the specified MongoDB user.
[update](update.md) | Updates the specified MongoDB user.