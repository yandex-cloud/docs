---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/LoadBalancer/updateSniMatch.md
---

# Method updateSniMatch
Updates the specified SNI handler of the specified listener.
 
This request does not allow to update `defaultHandler`. Make an [updateListener](/docs/application-load-balancer/api-ref/LoadBalancer/updateListener) request instead.
 
## HTTP request {#https-request}
```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:updateSniMatch
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | <p>Required. ID of the application load balancer to update the SNI handler in.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "listenerName": "string",
  "name": "string",
  "updateMask": "string",
  "serverNames": [
    "string"
  ],
  "handler": {
    "certificateIds": [
      "string"
    ],

    // `handler` includes only one of the fields `httpHandler`, `streamHandler`
    "httpHandler": {
      "httpRouterId": "string",

      // `handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
      "http2Options": {
        "maxConcurrentStreams": "string"
      },
      "allowHttp10": true,
      // end of the list of possible fields`handler.httpHandler`

    },
    "streamHandler": {
      "backendGroupId": "string"
    },
    // end of the list of possible fields`handler`

  }
}
```

 
Field | Description
--- | ---
listenerName | **string**<br><p>Required. Name of the listener to update the SNI handler in.</p> 
name | **string**<br><p>Required. Name of the SNI handler to update.</p> 
updateMask | **string**<br><p>Field mask that specifies which attributes of the SNI handler should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
serverNames[] | **string**<br><p>Required. New server names that are matched by the SNI handler.</p> <p>Existing set of server names is completely replaced by the provided set, so if you just want to add or remove a server name:</p> <ol> <li>Get the current set of server names with a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/get">get</a> request.</li> <li>Add or remove a server name in this set.</li> <li>Send the new set in this field.</li> </ol> <p>Must contain at least one element.</p> 
handler | **object**<br><p>Required. New settings for handling requests with Server Name Indication (SNI) matching one of <a href="/docs/application-load-balancer/api-ref/LoadBalancer/updateSniMatch#body_params">serverNames</a> values.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
handler.<br>httpHandler | **object**<br>HTTP handler. <br>`handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
handler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
 
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