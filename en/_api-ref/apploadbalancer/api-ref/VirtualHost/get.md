---
editable: false
---

# Method get
Returns the specified virtual host.
 
To get the list of all virtual hosts of an HTTP router, make a [list](/docs/application-load-balancer/api-ref/VirtualHost/list) request.
 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required. ID of the HTTP router that the virtual host belongs to.  To get the HTTP router ID, make a [list](/docs/application-load-balancer/api-ref/HttpRouter/list) request.
virtualHostName | Required. Name of the virtual host to return.  To get the virtual host name, make a [list](/docs/application-load-balancer/api-ref/VirtualHost/list) request.  Value must match the regular expression `` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? ``.
 
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
A virtual host resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#virtual-host).
 
Field | Description
--- | ---
name | **string**<br><p>Required. Name of the virtual host. The name is unique within the HTTP router.</p> 
authority[] | **string**<br><p>List of domains that are attributed to the virtual host.</p> <p>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header matches a domain specified in the host.</p> <p>A wildcard asterisk character (``*``) matches 0 or more characters.</p> <p>If not specified, all domains are attributed to the host, which is the same as specifying a ``*`` value. An HTTP router must not contain more than one virtual host to which all domains are attributed.</p> 
routes[] | **object**<br><p>A route resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#routes">documentation</a>.</p> 
routes[].<br>name | **string**<br><p>Required. Name of the route.</p> 
routes[].<br>http | **object**<br>HTTP route configuration. <br>`routes[]` includes only one of the fields `http`, `grpc`<br><br><p>An HTTP route configuration resource.</p> 
routes[].<br>http.<br>match | **object**<br>Condition (predicate) used to select the route.<br><p>An HTTP route condition (predicate) resource.</p> 
routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br><p>HTTP method specified in the request.</p> 
routes[].<br>http.<br>match.<br>path | **object**<br><p>Match settings for the path specified in the request.</p> <p>If not specified, the route matches all paths.</p> <p>A string matcher resource.</p> 
routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
routes[].<br>http.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>An HTTP route action resource.</p> 
routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>Default value: ``60``.</p> 
routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``timeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events (``EventSource`` interface) etc.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``timeout``).</p> 
routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>Replacement for the path prefix matched by [StringMatch.match].</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``/foobaz`` path is forwarded with ``/barbaz`` path. For ``exactMatch``, the whole path is replaced.</p> <p>If not specified, the path is not changed.</p> 
routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Supported values for HTTP ``Upgrade`` header. E.g. ``websocket``.</p> 
routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
routes[].<br>http.<br>redirect | **object**<br>Redirects the request as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>A redirect action resource.</p> 
routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>URI scheme replacement.</p> <p>If ``http`` or ``https`` scheme is to be replaced and ``80`` or ``443`` port is specified in the original URI, the port is also removed.</p> <p>If not specified, the original scheme and port are used.</p> 
routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Removes URI query.</p> 
routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>HTTP status code to use in redirect responses.<br><p>HTTP status codes supported for use in redirect responses.</p> <ul> <li>MOVED_PERMANENTLY: ``301 Moved Permanently`` status code.</li> <li>FOUND: ``302 Found`` status code.</li> <li>SEE_OTHER: ``303 See Other`` status code.</li> <li>TEMPORARY_REDIRECT: ``307 Temporary Redirect`` status code.</li> <li>PERMANENT_REDIRECT: ``308 Permanent Redirect`` status code.</li> </ul> 
routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the whole path.</p> 
routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the path prefix matched by [StringMatch.match].</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``https://example.com/foobaz`` URI is redirected to ``https://example.com/barbaz``. For ``exactMatch``, the whole path is replaced.</p> 
routes[].<br>http.<br>directResponse | **object**<br>Instructs the load balancer to respond directly as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br><p>A direct response action resource.</p> 
routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP status code to use in responses.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Response body.</p> <p>A health check payload resource.</p> 
routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
routes[].<br>grpc | **object**<br>gRPC route configuration. <br>`routes[]` includes only one of the fields `http`, `grpc`<br><br><p>A gRPC route configuration resource.</p> 
routes[].<br>grpc.<br>match | **object**<br>Condition (predicate) used to select the route.<br><p>A gRPC route condition (predicate) resource.</p> 
routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>Match settings for gRPC service method called in the request.</p> <p>A match string must be a fully qualified method name, e.g. ``foo.bar.v1.BazService/Get``, or a prefix of such.</p> <p>If not specified, the route matches all methods.</p> <p>A string matcher resource.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
routes[].<br>grpc.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br><p>A gRPC route action resource.</p> 
routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a client specifies a lower timeout in HTTP ``grpc-timeout`` header, the ``max_timeout`` value is ignored.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>Default value: ``60``.</p> 
routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``maxTimeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events etc.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``maxTimeout``).</p> 
routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
routes[].<br>grpc.<br>statusResponse | **object**<br>Instructs the load balancer to respond directly with a specified status. <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br><p>A gRPC status response action resource.</p> 
routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br><p>gRPC <a href="https://grpc.github.io/grpc/core/md_doc_statuscodes.html">status code</a> to use in responses.</p> <p>gRPC status code supported for use in responses.</p> <ul> <li>OK: ``OK`` (0) status code.</li> <li>INVALID_ARGUMENT: ``INVALID_ARGUMENT`` (3) status code.</li> <li>NOT_FOUND: ``NOT_FOUND`` (5) status code.</li> <li>PERMISSION_DENIED: ``PERMISSION_DENIED`` (7) status code.</li> <li>UNAUTHENTICATED: ``UNAUTHENTICATED`` (16) status code.</li> <li>UNIMPLEMENTED: ``UNIMPLEMENTED`` (12) status code.</li> <li>INTERNAL: ``INTERNAL`` (13) status code.</li> <li>UNAVAILABLE: ``UNAVAILABLE`` (14) status code.</li> </ul> 
modifyRequestHeaders[] | **object**<br><p>A header modification resource.</p> 
modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyRequestHeaders[].<br>append | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyRequestHeaders[].<br>replace | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
modifyRequestHeaders[].<br>rename | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string.</p> 
modifyResponseHeaders[] | **object**<br><p>A header modification resource.</p> 
modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyResponseHeaders[].<br>append | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyResponseHeaders[].<br>replace | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
modifyResponseHeaders[].<br>rename | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string.</p> 