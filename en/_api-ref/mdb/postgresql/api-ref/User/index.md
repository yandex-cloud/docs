---
editable: false
---

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
  "connLimit": "string",
  "settings": {
    "defaultTransactionIsolation": "string",
    "lockTimeout": "integer",
    "logMinDurationStatement": "integer",
    "synchronousCommit": "string",
    "tempFileLimit": "integer",
    "logStatement": "string"
  },
  "login": true,
  "grants": [
    "string"
  ]
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the PostgreSQL user.</p> 
clusterId | **string**<br><p>ID of the PostgreSQL cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
connLimit | **string** (int64)<br><p>Number of database connections available to the user.</p> 
settings | **object**<br><p>Postgresql settings for this user</p> <p>Postgresql user settings config</p> 
settings.<br>defaultTransactionIsolation | **string**<br>
settings.<br>lockTimeout | **integer** (int64)<br><p>in milliseconds.</p> 
settings.<br>logMinDurationStatement | **integer** (int64)<br><p>in milliseconds.</p> 
settings.<br>synchronousCommit | **string**<br>
settings.<br>tempFileLimit | **integer** (int64)<br><p>in bytes.</p> 
settings.<br>logStatement | **string**<br>
login | **boolean** (boolean)<br><p>User can login (default True)</p> 
grants[] | **string**<br><p>User grants (GRANT <role> TO <user>), role must be other user</p> <p>The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 

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