---
editable: false
---

# Method get
Returns the specified VirtualHost resource.
 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required. ID of the HTTP Router that the virtual host belongs to.
virtualHostName | Required. Name of the VirtualHost resource to return.  Value must match the regular expression `` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
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
name | **string**<br><p>Required.</p> 
authority[] | **string**<br><p>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '<em>.foo.com' or '</em>-bar.foo.com'. If not specified, all domains will be matched.</p> 
routes[] | **object**<br><p>Routes are matched <em>in-order</em>. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.</p> 
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
modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyRequestHeaders[].<br>append | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
modifyRequestHeaders[].<br>replace | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
modifyRequestHeaders[].<br>rename | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyResponseHeaders[].<br>append | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
modifyResponseHeaders[].<br>replace | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
modifyResponseHeaders[].<br>rename | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 