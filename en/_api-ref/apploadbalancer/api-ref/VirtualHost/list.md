---
editable: false
---

# Method list
Lists virtual hosts of the specified HTTP router.
 

 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required. ID of the HTTP router to list virtual hosts in.  To get the HTTP router ID, make a [list](/docs/application-load-balancer/api-ref/HttpRouter/list) request.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/application-load-balancer/api-ref/VirtualHost/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/application-load-balancer/api-ref/VirtualHost/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "virtualHosts": [
    {
      "name": "string",
      "authority": [
        "string"
      ],
      "routes": [
        {
          "name": "string",
          "routeOptions": {
            "modifyRequestHeaders": [
              {
                "name": "string",

                // `virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": true,
                "rename": "string",
                // end of the list of possible fields`virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]`

              }
            ],
            "modifyResponseHeaders": [
              {
                "name": "string",

                // `virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": true,
                "rename": "string",
                // end of the list of possible fields`virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]`

              }
            ]
          },

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
      ],
      "routeOptions": {
        "modifyRequestHeaders": [
          {
            "name": "string",

            // `virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`virtualHosts[].routeOptions.modifyRequestHeaders[]`

          }
        ],
        "modifyResponseHeaders": [
          {
            "name": "string",

            // `virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`virtualHosts[].routeOptions.modifyResponseHeaders[]`

          }
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
virtualHosts[] | **object**<br><p>A virtual host resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#virtual-host">documentation</a>.</p> 
virtualHosts[].<br>name | **string**<br><p>Required. Name of the virtual host. The name is unique within the HTTP router.</p> 
virtualHosts[].<br>authority[] | **string**<br><p>List of domains that are attributed to the virtual host.</p> <p>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header matches a domain specified in the host.</p> <p>A wildcard asterisk character (``*``) matches 0 or more characters.</p> <p>If not specified, all domains are attributed to the host, which is the same as specifying a ``*`` value. An HTTP router must not contain more than one virtual host to which all domains are attributed.</p> 
virtualHosts[].<br>routes[] | **object**<br><p>A route resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#routes">documentation</a>.</p> 
virtualHosts[].<br>routes[].<br>name | **string**<br><p>Required. Name of the route.</p> 
virtualHosts[].<br>routes[].<br>routeOptions | **object**<br>
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
virtualHosts[].<br>routes[].<br>http | **object**<br>HTTP route configuration. <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br><p>An HTTP route configuration resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match | **object**<br>Condition (predicate) used to select the route.<br><p>An HTTP route condition (predicate) resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br><p>HTTP method specified in the request.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path | **object**<br><p>Match settings for the path specified in the request.</p> <p>If not specified, the route matches all paths.</p> <p>A string matcher resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>An HTTP route action resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>Default value: ``60``.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``timeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events (``EventSource`` interface) etc.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``timeout``).</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``/foobaz`` path is forwarded with ``/barbaz`` path. For ``exactMatch``, the whole path is replaced.</p> <p>If not specified, the path is not changed.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Supported values for HTTP ``Upgrade`` header. E.g. ``websocket``.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect | **object**<br>Redirects the request as configured. <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>A redirect action resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>URI scheme replacement.</p> <p>If ``http`` or ``https`` scheme is to be replaced and ``80`` or ``443`` port is specified in the original URI, the port is also removed.</p> <p>If not specified, the original scheme and port are used.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Removes URI query.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>HTTP status code to use in redirect responses.<br><p>HTTP status codes supported for use in redirect responses.</p> <ul> <li>MOVED_PERMANENTLY: ``301 Moved Permanently`` status code.</li> <li>FOUND: ``302 Found`` status code.</li> <li>SEE_OTHER: ``303 See Other`` status code.</li> <li>TEMPORARY_REDIRECT: ``307 Temporary Redirect`` status code.</li> <li>PERMANENT_REDIRECT: ``308 Permanent Redirect`` status code.</li> </ul> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the whole path.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``https://example.com/foobaz`` URI is redirected to ``https://example.com/barbaz``. For ``exactMatch``, the whole path is replaced.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse | **object**<br>Instructs the load balancer to respond directly as configured. <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>A direct response action resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP status code to use in responses.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Response body.</p> <p>A health check payload resource.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
virtualHosts[].<br>routes[].<br>grpc | **object**<br>gRPC route configuration. <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br><p>A gRPC route configuration resource.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match | **object**<br>Condition (predicate) used to select the route.<br><p>A gRPC route condition (predicate) resource.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>Match settings for gRPC service method called in the request.</p> <p>A match string must be a fully qualified method name, e.g. ``foo.bar.v1.BazService/Get``, or a prefix of such.</p> <p>If not specified, the route matches all methods.</p> <p>A string matcher resource.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br><p>A gRPC route action resource.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a client specifies a lower timeout in HTTP ``grpc-timeout`` header, the ``max_timeout`` value is ignored.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>Default value: ``60``.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``maxTimeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events etc.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``maxTimeout``).</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse | **object**<br>Instructs the load balancer to respond directly with a specified status. <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br><p>A gRPC status response action resource.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br><p>gRPC <a href="https://grpc.github.io/grpc/core/md_doc_statuscodes.html">status code</a> to use in responses.</p> <p>gRPC status code supported for use in responses.</p> <ul> <li>OK: ``OK`` (0) status code.</li> <li>INVALID_ARGUMENT: ``INVALID_ARGUMENT`` (3) status code.</li> <li>NOT_FOUND: ``NOT_FOUND`` (5) status code.</li> <li>PERMISSION_DENIED: ``PERMISSION_DENIED`` (7) status code.</li> <li>UNAUTHENTICATED: ``UNAUTHENTICATED`` (16) status code.</li> <li>UNIMPLEMENTED: ``UNIMPLEMENTED`` (12) status code.</li> <li>INTERNAL: ``INTERNAL`` (13) status code.</li> <li>UNAVAILABLE: ``UNAVAILABLE`` (14) status code.</li> </ul> 
virtualHosts[].<br>modifyRequestHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>append | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
virtualHosts[].<br>modifyResponseHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>append | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
virtualHosts[].<br>routeOptions | **object**<br>
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>A header modification resource.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/VirtualHost/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/VirtualHost/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 