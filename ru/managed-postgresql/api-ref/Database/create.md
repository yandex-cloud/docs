---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/api-ref/Database/create.md
---

# Managed Service for PostgreSQL API, REST: Database.create
Creates a new PostgreSQL database in the specified cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the PostgreSQL cluster to create a database in. To get the cluster ID use a <a href="/docs/managed-postgresql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "databaseSpec": {
    "name": "string",
    "owner": "string",
    "lcCollate": "string",
    "lcCtype": "string",
    "extensions": [
      {
        "name": "string",
        "version": "string"
      }
    ],
    "templateDb": "string",
    "deletionProtection": true
  }
}
```

 
Field | Description
--- | ---
databaseSpec | **object**<br><p>Required. Configuration of the database to create.</p> 
databaseSpec.<br>name | **string**<br><p>Required. Name of the PostgreSQL database. 1-63 characters long.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
databaseSpec.<br>owner | **string**<br><p>Required. Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a <a href="/docs/managed-postgresql/api-ref/User/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
databaseSpec.<br>lcCollate | **string**<br><p>POSIX locale for string sorting order. Can only be set at creation time.</p> <p>Value must match the regular expression ``\|[a-zA-Z_]+.UTF-8\|C``.</p> 
databaseSpec.<br>lcCtype | **string**<br><p>POSIX locale for character classification. Can only be set at creation time.</p> <p>Value must match the regular expression ``\|[a-zA-Z_]+.UTF-8\|C``.</p> 
databaseSpec.<br>extensions[] | **object**<br><p>PostgreSQL extensions to be enabled for the database.</p> 
databaseSpec.<br>extensions[].<br>name | **string**<br><p>Name of the extension, e.g. ``pg_trgm`` or ``pg_btree``. Extensions supported by Managed Service for PostgreSQL are <a href="/docs/managed-postgresql/operations/cluster-extensions">listed in the Developer's Guide</a>.</p> 
databaseSpec.<br>extensions[].<br>version | **string**<br><p>Version of the extension.</p> 
databaseSpec.<br>templateDb | **string**<br><p>Name of the PostgreSQL database template.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
databaseSpec.<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the database</p> <p>Default value: ``unspecified`` (inherits cluster's deletion_protection)</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 