# Method create
Creates a PostgreSQL user in the specified cluster.
 

 
## HTTP request {#https-request}
`POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the PostgreSQL cluster to create a user in. To get the cluster ID, use a [list](/docs/mdb/api-ref/postgresql/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
 {
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string"
      }
    ],
    "connLimit": "integer"
  }
}
```

 
Field | Description
--- | ---
userSpec | **object**<br><p>Required. Properties of the user to be created.</p> 
userSpec.<br>name | **string**<br><p>Required. Name of the PostgreSQL user.</p> <p>The string length in characters must be 1-63. Value must match the regular expression <code>[a-zA-Z0-9_]+</code>.</p> 
userSpec.<br>password | **string**<br><p>Required. Password of the PostgreSQL user.</p> <p>The string length in characters must be 8-128.</p> 
userSpec.<br>permissions | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpec.<br>permissions.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpec.<br>connLimit | **integer** (int64)<br><p>Number of database connections that should be available to the user.</p> <p>The minimum value is 10.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified. This value is in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 