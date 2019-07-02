---
editable: false
---

# Method get
Returns the specified MySQL user.
 
To get the list of available MySQL users, make a [list](/docs/managed-mysql/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MySQL cluster.  The maximum string length in characters is 50.
userName | Required. Name of the user.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A MySQL user. For more information, see
the [documentation](/docs/managed-mysql/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the MySQL user.</p> 
clusterId | **string**<br><p>ID of the MySQL cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: All privileges that can be made available to the user.</li> <li>ALTER: Altering tables.</li> <li>ALTER_ROUTINE: Altering stored routines (stored procedures and functions).</li> <li>CREATE: Creating tables or indexes.</li> <li>CREATE_ROUTINE: Creating stored routines.</li> <li>CREATE_TEMPORARY_TABLES: Creating temporary tables.</li> <li>CREATE_VIEW: Creating views.</li> <li>DELETE: Deleting tables.</li> <li>DROP: Removing tables or views.</li> <li>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</li> <li>EXECUTE: Executing stored routines.</li> <li>INDEX: Creating and removing indexes.</li> <li>INSERT: Inserting rows into the database.</li> <li>LOCK_TABLES: Using LOCK TABLES statement for tables available with SELECT privilege.</li> <li>SELECT: Selecting rows from tables.</li> </ul> <p>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">MySQL documentation</a>.</p> <ul> <li>SHOW_VIEW: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li> <li>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</li> <li>UPDATE: Updating rows in the database.</li> </ul> 