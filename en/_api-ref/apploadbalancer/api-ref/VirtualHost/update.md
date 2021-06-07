---
editable: false
---

# Method update
Updates an existing VirtualHost in the specified HTTP Router.
 

 
## HTTP request {#https-request}
```
PATCH https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required. ID of the HTTP Router that the virtual host belongs to.
virtualHostName | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "authority": [
    "string"
  ],
  "routes": [
    {
      "name": "string",

      // `routes[]` includes only one of the fields `http`, `grpc`
      "http": {
        "match": {
          "httpMethod": [
            "string"
          ],
          "path": {

            // `routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            // end of the list of possible fields`routes[].http.match.path`

          }
        },

        // `routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`
        "route": {
          "backendGroupId": "string",
          "timeout": "string",
          "idleTimeout": "string",
          "prefixRewrite": "string",
          "upgradeTypes": [
            "string"
          ],

          // `routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
          "hostRewrite": "string",
          "autoHostRewrite": true,
          // end of the list of possible fields`routes[].http.route`

        },
        "redirect": {
          "replaceScheme": "string",
          "replaceHost": "string",
          "replacePort": "string",
          "removeQuery": true,
          "responseCode": "string",

          // `routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`
          "replacePath": "string",
          "replacePrefix": "string",
          // end of the list of possible fields`routes[].http.redirect`

        },
        "directResponse": {
          "status": "string",
          "body": {
            "text": "string"
          }
        },
        // end of the list of possible fields`routes[].http`

      },
      "grpc": {
        "match": {
          "fqmn": {

            // `routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            // end of the list of possible fields`routes[].grpc.match.fqmn`

          }
        },

        // `routes[].grpc` includes only one of the fields `route`, `statusResponse`
        "route": {
          "backendGroupId": "string",
          "maxTimeout": "string",
          "idleTimeout": "string",

          // `routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
          "hostRewrite": "string",
          "autoHostRewrite": true,
          // end of the list of possible fields`routes[].grpc.route`

        },
        "statusResponse": {
          "status": "string"
        },
        // end of the list of possible fields`routes[].grpc`

      },
      // end of the list of possible fields`routes[]`

    }
  ],
  "modifyRequestHeaders": [
    {
      "name": "string",

      // `modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
      "append": "string",
      "replace": "string",
      "remove": true,
      "rename": "string",
      // end of the list of possible fields`modifyRequestHeaders[]`

    }
  ],
  "modifyResponseHeaders": [
    {
      "name": "string",

      // `modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
      "append": "string",
      "replace": "string",
      "remove": true,
      "rename": "string",
      // end of the list of possible fields`modifyResponseHeaders[]`

    }
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
authority[] | **string**<br><p>Fields of the virtual host to update. Except name, that field used to address virtual host within the http router and cannot be changed after creation.</p> 
routes[] | **object**<br>
routes[].<br>name | **string**<br><p>Required.</p> 
routes[].<br>http | **object** <br>`routes[]` includes only one of the fields `http`, `grpc`<br><br>
routes[].<br>http.<br>match | **object**<br>Checks "/" prefix by default.<br>
routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br>
routes[].<br>http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
routes[].<br>http.<br>route | **object** <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds.</p> 
routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Only specified upgrade types will be allowed. For example, &quot;websocket&quot;.</p> 
routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
routes[].<br>http.<br>redirect | **object** <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>Replaces scheme. If the original scheme is ``http`` or ``https``, will also remove the 80 or 443 port, if present.</p> 
routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>Replaces hostname.</p> 
routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>Replaces port.</p> 
routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Remove query part.</p> 
routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>The HTTP status code to use in the redirect response.<br><ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace path.</p> 
routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace only matched prefix. Example: match:    { prefix_match: &quot;/some&quot; } redirect: { replace_prefix: &quot;/other&quot; } will redirect &quot;/something&quot; to &quot;/otherthing&quot;</p> 
routes[].<br>http.<br>directResponse | **object** <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP response status.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Optional response body.</p> 
routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
routes[].<br>grpc | **object** <br>`routes[]` includes only one of the fields `http`, `grpc`<br><br>
routes[].<br>grpc.<br>match | **object**<br>Checks "/" prefix by default.<br>
routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>If not set, all services/methods are assumed.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
routes[].<br>grpc.<br>route | **object** <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.</p> 
routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
routes[].<br>grpc.<br>statusResponse | **object** <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br>
modifyRequestHeaders[] | **object**<br>
modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyRequestHeaders[].<br>append | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
modifyRequestHeaders[].<br>replace | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
modifyRequestHeaders[].<br>rename | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
modifyResponseHeaders[] | **object**<br>
modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyResponseHeaders[].<br>append | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
modifyResponseHeaders[].<br>replace | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
modifyResponseHeaders[].<br>rename | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
 
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