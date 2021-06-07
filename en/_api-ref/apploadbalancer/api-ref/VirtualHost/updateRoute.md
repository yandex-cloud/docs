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
      "idleTimeout": "string",
      "prefixRewrite": "string",
      "upgradeTypes": [
        "string"
      ],

      // `http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
      "hostRewrite": "string",
      "autoHostRewrite": true,
      // end of the list of possible fields`http.route`

    },
    "redirect": {
      "replaceScheme": "string",
      "replaceHost": "string",
      "replacePort": "string",
      "removeQuery": true,
      "responseCode": "string",

      // `http.redirect` includes only one of the fields `replacePath`, `replacePrefix`
      "replacePath": "string",
      "replacePrefix": "string",
      // end of the list of possible fields`http.redirect`

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
      "idleTimeout": "string",

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
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
http | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
http.<br>match | **object**<br>Checks "/" prefix by default.<br>
http.<br>match.<br>httpMethod[] | **string**<br>
http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
http.<br>match.<br>path.<br>exactMatch | **string** <br>`http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
http.<br>match.<br>path.<br>prefixMatch | **string** <br>`http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
http.<br>route | **object** <br>`http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
http.<br>route.<br>timeout | **string**<br><p>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds.</p> 
http.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
http.<br>route.<br>upgradeTypes[] | **string**<br><p>Only specified upgrade types will be allowed. For example, &quot;websocket&quot;.</p> 
http.<br>route.<br>hostRewrite | **string** <br>`http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
http.<br>redirect | **object** <br>`http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
http.<br>redirect.<br>replaceScheme | **string**<br><p>Replaces scheme. If the original scheme is ``http`` or ``https``, will also remove the 80 or 443 port, if present.</p> 
http.<br>redirect.<br>replaceHost | **string**<br><p>Replaces hostname.</p> 
http.<br>redirect.<br>replacePort | **string** (int64)<br><p>Replaces port.</p> 
http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Remove query part.</p> 
http.<br>redirect.<br>responseCode | **string**<br>The HTTP status code to use in the redirect response.<br><ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
http.<br>redirect.<br>replacePath | **string** <br>`http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace path.</p> 
http.<br>redirect.<br>replacePrefix | **string** <br>`http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace only matched prefix. Example: match:    { prefix_match: &quot;/some&quot; } redirect: { replace_prefix: &quot;/other&quot; } will redirect &quot;/something&quot; to &quot;/otherthing&quot;</p> 
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
grpc.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
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
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 