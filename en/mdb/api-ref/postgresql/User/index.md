# User
A set of methods for managing PostgreSQL User resources.
## JSON Representation {#representation}
```json 
 {
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string"
    }
  ],
  "connLimit": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a PostgreSQL user in the specified cluster.
[delete](delete.md) | Deletes the specified PostgreSQL user.
[get](get.md) | Returns the specified PostgreSQL User resource.
[grantPermission](grantPermission.md) | Grants permission to the specified PostgreSQL user.
[list](list.md) | Retrieves the list of PostgreSQL User resources in the specified cluster.
[revokePermission](revokePermission.md) | Revokes permission from the specified PostgreSQL user.
[update](update.md) | Updates the specified PostgreSQL user.