# User
A set of methods for managing ClickHouse User resources.
## JSON Representation {#representation}
```json 
 {
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string"
    }
  ]
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a ClickHouse user in the specified cluster.
[delete](delete.md) | Deletes the specified ClickHouse user.
[get](get.md) | Returns the specified ClickHouse User resource.
[grantPermission](grantPermission.md) | Grants a permission to the specified ClickHouse user.
[list](list.md) | Retrieves the list of ClickHouse User resources in the specified cluster.
[revokePermission](revokePermission.md) | Revokes a permission from the specified ClickHouse user.
[update](update.md) | Updates the specified ClickHouse user.