---
editable: false
---

# Method updateRoute

 

 
## HTTP request {#https-request}
```
POST https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}:updateRoute
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required.
virtualHostName | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "routeName": "string",
  "updateMask": "string",

  //  includes only one of the fields `http`, `grpc`
  "http": {
    "match": {
      "httpMethod": [
        "string"
      ],
      "path": {

        // `http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
        "exactMatch": "string",
        "prefixMatch": "string",
        // end of the list of possible fields`http.match.path`

      }
    },

    // `http` includes only one of the fields `route`, `redirect`, `directResponse`
    "route": {
      "backendGroupId": "string",
      "timeout": "string",
      "prefixRewrite": "string",
      "supportWebsockets": true,

      // `http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
      "hostRewrite": "string",
      "autoHostRewrite": true,
      // end of the list of possible fields`http.route`

    },
    "redirect": {
      "redirectUri": "string",
      "responseCode": "string"
    },
    "directResponse": {
      "status": "string",
      "body": {
        "text": "string"
      }
    },
    // end of the list of possible fields`http`

  },
  "grpc": {
    "match": {
      "fqmn": {

        // `grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
        "exactMatch": "string",
        "prefixMatch": "string",
        // end of the list of possible fields`grpc.match.fqmn`

      }
    },

    // `grpc` includes only one of the fields `route`, `statusResponse`
    "route": {
      "backendGroupId": "string",
      "maxTimeout": "string",

      // `grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
      "hostRewrite": "string",
      "autoHostRewrite": true,
      // end of the list of possible fields`grpc.route`

    },
    "statusResponse": {
      "status": "string"
    },
    // end of the list of possible fields`grpc`

  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
routeName | **string**<br><p>Required.</p> 
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
http | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
http.<br>match | **object**<br>Checks "/" prefix by default.<br>
http.<br>match.<br>httpMethod[] | **string**<br>
http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
http.<br>match.<br>path.<br>exactMatch | **string** <br>`http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
http.<br>match.<br>path.<br>prefixMatch | **string** <br>`http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
http.<br>route | **object** <br>`http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
http.<br>route.<br>timeout | **string**<br><p>If not set, default is 60 seconds.</p> 
http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
http.<br>route.<br>supportWebsockets | **boolean** (boolean)<br><p>Allows websocket upgrades.</p> 
http.<br>route.<br>hostRewrite | **string** <br>`http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
http.<br>redirect | **object** <br>`http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
http.<br>redirect.<br>redirectUri | **string**<br><p>Required. A URI consists of the following components: protocol://hostname:port/path?query</p> <p>URI components of the original URL in the target URL using the following reserved keywords: #{protocol} - Retains the protocol. Use in the protocol and query components #{host} - Retains the domain. Use in the hostname, path, and query components #{port} - Retains the port. Use in the port, path, and query components #{path} - Retains the path. Use in the path and query components #{query} - Retains the query parameters. Use in the query component</p> 
http.<br>redirect.<br>responseCode | **string**<br><p>The HTTP status code to use in the redirect response.</p> <ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
http.<br>directResponse | **object** <br>`http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP response status.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
http.<br>directResponse.<br>body | **object**<br><p>Optional response body.</p> 
http.<br>directResponse.<br>body.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
grpc | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
grpc.<br>match | **object**<br>Checks "/" prefix by default.<br>
grpc.<br>match.<br>fqmn | **object**<br><p>If not set, all services/methods are assumed.</p> 
grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
grpc.<br>route | **object** <br>`grpc` includes only one of the fields `route`, `statusResponse`<br><br>
grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
grpc.<br>route.<br>maxTimeout | **string**<br><p>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.</p> 
grpc.<br>route.<br>hostRewrite | **string** <br>`grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
grpc.<br>statusResponse | **object** <br>`grpc` includes only one of the fields `route`, `statusResponse`<br><br>
grpc.<br>statusResponse.<br>status | **string**<br>
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 