---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/User/revokePermission.md
---

# Method revokePermission
Revokes permission to access a database from a user in a cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/users/{userName}:revokePermission
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to revoke permission from the user in.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
userName | <p>Required. Name of the user to revoke permission from.</p> <p>To get this name, make a <a href="/docs/managed-mysql/api-ref/User/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "permission": {
    "databaseName": "string",
    "roles": [
      "string"
    ]
  }
}
```

 
Field | Description
--- | ---
permission | **object**<br><p>Required. Permission that should be revoked from the user.</p> 
permission.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permission.<br>roles[] | **string**<br><p>Required. Roles granted to the user within the database.</p> <p>See <a href="/docs/managed-mysql/operations/grant">the documentation</a> for details.</p> <p>The minimum number of elements is 1.</p> <ul> <li> <p>ALL_PRIVILEGES: All privileges that can be made available to the user.</p> </li> <li> <p>ALTER: Altering tables.</p> </li> <li> <p>ALTER_ROUTINE: Altering stored routines and functions.</p> </li> <li> <p>CREATE: Creating tables or indexes.</p> </li> <li> <p>CREATE_ROUTINE: Creating stored routines.</p> </li> <li> <p>CREATE_TEMPORARY_TABLES: Creating temporary tables.</p> </li> <li> <p>CREATE_VIEW: Creating views.</p> </li> <li> <p>DELETE: Deleting tables.</p> </li> <li> <p>DROP: Removing tables or views.</p> </li> <li> <p>EVENT: Creating, altering, dropping, or displaying events for the Event Scheduler.</p> </li> <li> <p>EXECUTE: Executing stored routines.</p> </li> <li> <p>INDEX: Creating and removing indexes.</p> </li> <li> <p>INSERT: Inserting rows into the database.</p> </li> <li> <p>LOCK_TABLES: Using ``LOCK TABLES`` statement for tables available with ``SELECT`` privilege.</p> </li> <li> <p>SELECT: Selecting rows from tables.</p> <p>Some ``SELECT`` statements can be allowed without the ``SELECT`` privilege. All statements that read column values require the ``SELECT`` privilege.</p> <p>See <a href="https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select">MySQL documentation</a> for details.</p> </li> <li> <p>SHOW_VIEW: Using the ``SHOW CREATE VIEW`` statement. Also needed for views used with ``EXPLAIN``.</p> </li> <li> <p>TRIGGER: Creating, removing, executing, or displaying triggers for a table.</p> </li> <li> <p>UPDATE: Updating rows in the database.</p> </li> <li> <p>REFERENCES: Creation of a foreign key constraint for the parent table.</p> </li> </ul> 
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 