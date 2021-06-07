---
editable: false
---

# HttpRouter

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "labels": "object",
  "virtualHosts": [
    {
      "name": "string",
      "authority": [
        "string"
      ],
      "routes": [
        {
          "name": "string",

          // `virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`
          "http": {
            "match": {
              "httpMethod": [
                "string"
              ],
              "path": {

                // `virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                // end of the list of possible fields`virtualHosts[].routes[].http.match.path`

              }
            },

            // `virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`
            "route": {
              "backendGroupId": "string",
              "timeout": "string",
              "idleTimeout": "string",
              "prefixRewrite": "string",
              "upgradeTypes": [
                "string"
              ],

              // `virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": true,
              // end of the list of possible fields`virtualHosts[].routes[].http.route`

            },
            "redirect": {
              "replaceScheme": "string",
              "replaceHost": "string",
              "replacePort": "string",
              "removeQuery": true,
              "responseCode": "string",

              // `virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`
              "replacePath": "string",
              "replacePrefix": "string",
              // end of the list of possible fields`virtualHosts[].routes[].http.redirect`

            },
            "directResponse": {
              "status": "string",
              "body": {
                "text": "string"
              }
            },
            // end of the list of possible fields`virtualHosts[].routes[].http`

          },
          "grpc": {
            "match": {
              "fqmn": {

                // `virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                // end of the list of possible fields`virtualHosts[].routes[].grpc.match.fqmn`

              }
            },

            // `virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`
            "route": {
              "backendGroupId": "string",
              "maxTimeout": "string",
              "idleTimeout": "string",

              // `virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": true,
              // end of the list of possible fields`virtualHosts[].routes[].grpc.route`

            },
            "statusResponse": {
              "status": "string"
            },
            // end of the list of possible fields`virtualHosts[].routes[].grpc`

          },
          // end of the list of possible fields`virtualHosts[].routes[]`

        }
      ],
      "modifyRequestHeaders": [
        {
          "name": "string",

          // `virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": true,
          "rename": "string",
          // end of the list of possible fields`virtualHosts[].modifyRequestHeaders[]`

        }
      ],
      "modifyResponseHeaders": [
        {
          "name": "string",

          // `virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": true,
          "rename": "string",
          // end of the list of possible fields`virtualHosts[].modifyResponseHeaders[]`

        }
      ]
    }
  ],
  "createdAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the router.</p> 
name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the router. 0-256 characters long.</p> 
folderId | **string**<br><p>ID of the folder that the router belongs to.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
virtualHosts[] | **object**<br><p>Only one virtual host with no authority (default match) can be specified.</p> 
virtualHosts[].<br>name | **string**<br><p>Required.</p> 
virtualHosts[].<br>authority[] | **string**<br><p>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '<em>.foo.com' or '</em>-bar.foo.com'. If not specified, all domains will be matched.</p> 
virtualHosts[].<br>routes[] | **object**<br><p>Routes are matched <em>in-order</em>. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.</p> 
virtualHosts[].<br>routes[].<br>name | **string**<br><p>Required.</p> 
virtualHosts[].<br>routes[].<br>http | **object** <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>match | **object**<br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Only specified upgrade types will be allowed. For example, &quot;websocket&quot;.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>redirect | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>Replaces scheme. If the original scheme is ``http`` or ``https``, will also remove the 80 or 443 port, if present.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>Replaces hostname.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>Replaces port.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Remove query part.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>The HTTP status code to use in the redirect response.<br><ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace path.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replace only matched prefix. Example: match:    { prefix_match: &quot;/some&quot; } redirect: { replace_prefix: &quot;/other&quot; } will redirect &quot;/something&quot; to &quot;/otherthing&quot;</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP response status.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Optional response body.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
virtualHosts[].<br>routes[].<br>grpc | **object** <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>match | **object**<br>
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>If not set, all services/methods are assumed.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route | **object** <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse | **object** <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br>
virtualHosts[].<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>append | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
virtualHosts[].<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>append | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the http router.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[list](list.md) | 
[listOperations](listOperations.md) | Lists operations for the specified http router.
[update](update.md) | 