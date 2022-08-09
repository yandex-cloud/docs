---
editable: false
---

# Method update
Updates the specified proxy.
 

 
## HTTP request {#https-request}
```
PATCH https://serverless-mdbproxy.{{ api-host }}/mdbproxy/v1/proxies/{proxyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
proxyId | <p>Required. ID of the proxy to update.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "target": {

    // `target` includes only one of the fields `clickhouse`, `postgresql`
    "clickhouse": {
      "clusterId": "string",
      "user": "string",
      "password": "string",
      "db": "string",
      "endpoint": "string"
    },
    "postgresql": {
      "clusterId": "string",
      "user": "string",
      "password": "string",
      "db": "string",
      "endpoint": "string"
    },
    // end of the list of possible fields`target`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which attributes of the proxy should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>New name for the proxy. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>New description for the proxy.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Proxy labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
target | **object**<br><p>Proxy target.</p> 
target.<br>clickhouse | **object**<br>Clickhouse settings for proxy. <br>`target` includes only one of the fields `clickhouse`, `postgresql`<br>
target.<br>clickhouse.<br>clusterId | **string**<br><p>Required. Cluster identifier for clickhouse.</p> <p>The maximum string length in characters is 50.</p> 
target.<br>clickhouse.<br>user | **string**<br><p>Required. Clickhouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
target.<br>clickhouse.<br>password | **string**<br><p>Clickhouse password, input only field.</p> 
target.<br>clickhouse.<br>db | **string**<br><p>Required. Clickhouse database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>clickhouse.<br>endpoint | **string**<br><p>Clickhouse proxy-host for connection, output only field.</p> 
target.<br>postgresql | **object**<br>PostgreSQL settings for proxy. <br>`target` includes only one of the fields `clickhouse`, `postgresql`<br>
target.<br>postgresql.<br>clusterId | **string**<br><p>Required. Cluster identifier for postgresql.</p> <p>The maximum string length in characters is 50.</p> 
target.<br>postgresql.<br>user | **string**<br><p>Required. PostgreSQL user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>postgresql.<br>password | **string**<br><p>PostgreSQL password, input only field.</p> 
target.<br>postgresql.<br>db | **string**<br><p>Required. PostgreSQL database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>postgresql.<br>endpoint | **string**<br><p>PostgreSQL proxy-host for connection, output only field.</p> 
 
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