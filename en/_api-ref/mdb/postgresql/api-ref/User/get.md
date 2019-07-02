---
editable: false
---

# Method get
Returns the specified PostgreSQL User resource.
 
To get the list of available PostgreSQL User resources, make a [list](/docs/managed-postgresql/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL cluster the user belongs to. To get the cluster ID, use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Name of the PostgreSQL User resource to return. To get the name of the user, use a [list](/docs/managed-postgresql/api-ref/User/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
    "tempFileLimit": "integer"
  },
  "login": true,
  "grants": [
    "string"
  ]
}
```
A PostgreSQL User resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).
 
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
login | **boolean** (boolean)<br><p>User can login (default True)</p> 
grants[] | **string**<br><p>User grants (GRANT <role> TO <user>), role must be other user</p> <p>The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 