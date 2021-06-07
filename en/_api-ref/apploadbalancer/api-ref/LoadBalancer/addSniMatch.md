---
editable: false
---

# Method addSniMatch

 

 
## HTTP request {#https-request}
```
POST https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addSniMatch
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "listenerName": "string",
  "name": "string",
  "serverNames": [
    "string"
  ],
  "handler": {
    "certificateIds": [
      "string"
    ],
    "httpHandler": {
      "httpRouterId": "string",

      // `handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
      "http2Options": {
        "maxConcurrentStreams": "string"
      },
      "allowHttp10": true,
      // end of the list of possible fields`handler.httpHandler`

    }
  }
}
```

 
Field | Description
--- | ---
listenerName | **string**<br><p>Required.</p> 
name | **string**<br><p>Required.</p> 
serverNames[] | **string**<br><p>Required. Must contain at least one element.</p> 
handler | **object**<br><p>Required.</p> 
handler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
handler.<br>httpHandler | **object**<br>
handler.<br>httpHandler.<br>httpRouterId | **string**<br>
handler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
 
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