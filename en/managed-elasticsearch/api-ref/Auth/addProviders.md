---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Auth/addProviders.md
---

# Managed Service for Elasticsearch API, REST: Auth.addProviders
Adds new auth providers to Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the ElasticSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "providers": [
    {
      "type": "string",
      "name": "string",
      "order": "string",
      "enabled": true,
      "hidden": true,
      "description": "string",
      "hint": "string",
      "icon": "string",
      "saml": {
        "idpEntityId": "string",
        "idpMetadataFile": "string",
        "spEntityId": "string",
        "kibanaUrl": "string",
        "attributePrincipal": "string",
        "attributeGroups": "string",
        "attributeName": "string",
        "attributeEmail": "string",
        "attributeDn": "string"
      }
    }
  ]
}
```

 
Field | Description
--- | ---
providers[] | **object**<br><p>Required. List of providers to add.</p> <p>The maximum number of elements is 10.</p> 
providers[].<br>type | **string**
providers[].<br>name | **string**<br><p>The maximum string length in characters is 50. Value must match the regular expression ``[a-z][a-z0-9_-]*``.</p> 
providers[].<br>order | **string** (int64)
providers[].<br>enabled | **boolean** (boolean)
providers[].<br>hidden | **boolean** (boolean)<br><p>selector ui settings</p> 
providers[].<br>description | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>hint | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>icon | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml | **object**
providers[].<br>saml.<br>idpEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>idpMetadataFile | **string** (byte)<br><p>The maximum string length in characters is 10000.</p> 
providers[].<br>saml.<br>spEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>kibanaUrl | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>attributePrincipal | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeGroups | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeName | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeEmail | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeDn | **string**<br><p>The maximum string length in characters is 50.</p> 
 
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