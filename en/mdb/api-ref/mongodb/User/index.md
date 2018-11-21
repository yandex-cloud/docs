# User
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