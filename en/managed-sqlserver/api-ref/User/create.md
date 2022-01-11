---
editable: false
sourcePath: en/_api-ref/mdb/sqlserver/api-ref/User/create.md
---


# Method create
Creates an SQL Server user in the specified cluster.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the SQL Server cluster to create a user for.  To get the cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string",
        "roles": [
          "string"
        ]
      }
    ]
  }
}
```

 
Field | Description
--- | ---
userSpec | **object**<br><p>Required. Properties of the user to be created.</p> 
userSpec.<br>name | **string**<br><p>Required. Name of the SQL Server user.</p> <p>The maximum string length in characters is 32. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
userSpec.<br>password | **string**<br><p>Required. Password of the SQL Server user.</p> <p>The string length in characters must be 8-128.</p> 
userSpec.<br>permissions[] | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpec.<br>permissions[].<br>databaseName | **string**<br><p>Name of the database the permission grants access to.</p> 
userSpec.<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Members of this fixed database role can perform all configuration and maintenance activities on the database, and can also drop the database in SQL Server.</li> <li>DB_SECURITYADMIN: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li> <li>DB_ACCESSADMIN: Members of this fixed database role can add or remove access to the database for Windows logins, Windows groups, and SQL Server logins.</li> <li>DB_BACKUPOPERATOR: Members of this fixed database role can back up the database.</li> <li>DB_DDLADMIN: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li> <li>DB_DATAWRITER: Members of this fixed database role can add, delete, or change data in all user tables.</li> <li>DB_DATAREADER: Members of this fixed database role can read all data from all user tables.</li> <li>DB_DENYDATAWRITER: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> <li>DB_DENYDATAREADER: Members of this fixed database role cannot read any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 