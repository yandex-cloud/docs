---
editable: false
sourcePath: en/_api-ref/cdn/api-ref/OriginGroup/create.md
---

# Method create
Creates origin group.
 

 
## HTTP request {#https-request}
```
POST https://cdn.{{ api-host }}/cdn/v1/originGroups
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "useNext": true,
  "origins": [
    {
      "source": "string",
      "enabled": true,
      "backup": true,
      "meta": {

        // `origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`
        "common": {
          "name": "string"
        },
        "bucket": {
          "name": "string"
        },
        "website": {
          "name": "string"
        },
        "balancer": {
          "id": "string"
        },
        // end of the list of possible fields`origins[].meta`

      }
    }
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder that the origin group belongs to.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the origin group.</p> 
useNext | **boolean** (boolean)<br><p>This option have two possible conditions: true - The option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - The option is disabled.</p> <p>default value is true</p> 
origins[] | **object**<br><p>List of origins: IP addresses or Domain names of your origins and the port (if custom).</p> 
origins[].<br>source | **string**<br><p>Source: IP address or Domain name of your origin and the port (if custom).</p> 
origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content.</p> 
origins[].<br>backup | **boolean** (boolean)<br><p>backup option has two possible values:</p> <p>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled.</p> 
origins[].<br>meta | **object**<br><p>Set up origin of the content.</p> <p>Origin type. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
origins[].<br>meta.<br>common | **object**<br>An Object Storage bucket configured as a static site hosting. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>common.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>bucket | **object**<br>A server with a domain name linked to it <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>bucket.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>website | **object**<br>An Object Storage bucket not configured as a static site hosting. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>website.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>balancer | **object**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>balancer.<br>id | **string**<br><p>ID of the origin.</p> 
 
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