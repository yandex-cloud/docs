---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/VirtualHost/index.md
---

# VirtualHost
A set of methods for managing virtual hosts of HTTP routers.
## JSON Representation {#representation}
```json 
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

            // `routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`routes[].routeOptions.modifyRequestHeaders[]`

          }
        ],
        "modifyResponseHeaders": [
          {
            "name": "string",

            // `routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`routes[].routeOptions.modifyResponseHeaders[]`

          }
        ],
        "rbac": {
          "action": "string",
          "principals": [
            {
              "andPrincipals": [
                {

                  // `routes[].routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`
                  "header": {
                    "name": "string",
                    "value": {

                      // `routes[].routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                      "exactMatch": "string",
                      "prefixMatch": "string",
                      "regexMatch": "string",
                      // end of the list of possible fields`routes[].routeOptions.rbac.principals[].andPrincipals[].header.value`

                    }
                  },
                  "remoteIp": "string",
                  "any": true,
                  // end of the list of possible fields`routes[].routeOptions.rbac.principals[].andPrincipals[]`

                }
              ]
            }
          ]
        }
      },

      // `routes[]` includes only one of the fields `http`, `grpc`
      "http": {
        "match": {
          "httpMethod": [
            "string"
          ],
          "path": {

            // `routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string",
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

            // `routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string",
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
  ],
  "routeOptions": {
    "modifyRequestHeaders": [
      {
        "name": "string",

        // `routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": true,
        "rename": "string",
        // end of the list of possible fields`routeOptions.modifyRequestHeaders[]`

      }
    ],
    "modifyResponseHeaders": [
      {
        "name": "string",

        // `routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": true,
        "rename": "string",
        // end of the list of possible fields`routeOptions.modifyResponseHeaders[]`

      }
    ],
    "rbac": {
      "action": "string",
      "principals": [
        {
          "andPrincipals": [
            {

              // `routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`
              "header": {
                "name": "string",
                "value": {

                  // `routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string",
                  // end of the list of possible fields`routeOptions.rbac.principals[].andPrincipals[].header.value`

                }
              },
              "remoteIp": "string",
              "any": true,
              // end of the list of possible fields`routeOptions.rbac.principals[].andPrincipals[]`

            }
          ]
        }
      ]
    }
  }
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Required. Name of the virtual host. The name is unique within the HTTP router.</p> 
authority[] | **string**<br><p>List of domains that are attributed to the virtual host.</p> <p>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header matches a domain specified in the host.</p> <p>A wildcard asterisk character (``*``) matches 0 or more characters.</p> <p>If not specified, all domains are attributed to the host, which is the same as specifying a ``*`` value. An HTTP router must not contain more than one virtual host to which all domains are attributed.</p> 
routes[] | **object**<br><p>Routes of the virtual host.</p> <p>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#routes">documentation</a>.</p> <p>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via ``match``, to match paths prefixed with just ``/``, other routes are never matched.</p> 
routes[].<br>name | **string**<br><p>Required. Name of the route.</p> 
routes[].<br>routeOptions | **object**
routes[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
routes[].<br>routeOptions.<br>rbac | **object**<br><p>Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB service. Requests are allowed or denied based on the ``action`` and whether a matching principal is found. For instance, if the action is ALLOW and a matching principal is found the request should be allowed.</p> 
routes[].<br>routeOptions.<br>rbac.<br>action | **string**<br><p>Required. The action to take if a principal matches. Every action either allows or denies a request.</p> <ul> <li>ALLOW: Allows the request if and only if there is a principal that matches the request.</li> <li>DENY: Allows the request if and only if there are no principal that match the request.</li> </ul> 
routes[].<br>routeOptions.<br>rbac.<br>principals[] | **object**<br><p>Required. Required. A match occurs when at least one matches the request.</p> <p>The minimum number of elements is 1.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[] | **object**<br><p>Required. Required. A match occurs when all principals match the request.</p> <p>The minimum number of elements is 1.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header | **object**<br>A header (or pseudo-header such as :path or :method) of the incoming HTTP request. <br>`routes[].routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br>
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>name | **string**<br><p>Required. Specifies the name of the header in the request.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value | **object**<br><p>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value.</p> <p>A string matcher resource.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>exactMatch | **string** <br>`routes[].routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Exact match string.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>prefixMatch | **string** <br>`routes[].routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Prefix match string.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>regexMatch | **string** <br>`routes[].routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Regular expression match string.</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>remoteIp | **string** <br>`routes[].routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br><br><p>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .</p> 
routes[].<br>routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>any | **boolean** (boolean) <br>`routes[].routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br><br><p>When any is set, it matches any request.</p> 
routes[].<br>http | **object**<br>HTTP route configuration. <br>`routes[]` includes only one of the fields `http`, `grpc`<br>
routes[].<br>http.<br>match | **object**<br>Condition (predicate) used to select the route.
routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br><p>HTTP method specified in the request.</p> 
routes[].<br>http.<br>match.<br>path | **object**<br><p>Match settings for the path specified in the request.</p> <p>If not specified, the route matches all paths.</p> <p>A string matcher resource.</p> 
routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Exact match string.</p> 
routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Prefix match string.</p> 
routes[].<br>http.<br>match.<br>path.<br>regexMatch | **string** <br>`routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Regular expression match string.</p> 
routes[].<br>http.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> <p>Stream (TCP) backend groups are not supported.</p> 
routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>Default value: ``60``.</p> 
routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``timeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events (``EventSource`` interface) etc.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``timeout``).</p> 
routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``/foobaz`` path is forwarded with ``/barbaz`` path. For ``exactMatch``, the whole path is replaced.</p> <p>If not specified, the path is not changed.</p> 
routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Supported values for HTTP ``Upgrade`` header. E.g. ``websocket``.</p> 
routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
routes[].<br>http.<br>redirect | **object**<br>Redirects the request as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>URI scheme replacement.</p> <p>If ``http`` or ``https`` scheme is to be replaced and ``80`` or ``443`` port is specified in the original URI, the port is also removed.</p> <p>If not specified, the original scheme and port are used.</p> 
routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Removes URI query.</p> 
routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>HTTP status code to use in redirect responses.<br><ul> <li>MOVED_PERMANENTLY: ``301 Moved Permanently`` status code.</li> <li>FOUND: ``302 Found`` status code.</li> <li>SEE_OTHER: ``303 See Other`` status code.</li> <li>TEMPORARY_REDIRECT: ``307 Temporary Redirect`` status code.</li> <li>PERMANENT_REDIRECT: ``308 Permanent Redirect`` status code.</li> </ul> 
routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the whole path.</p> 
routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``https://example.com/foobaz`` URI is redirected to ``https://example.com/barbaz``. For ``exactMatch``, the whole path is replaced.</p> 
routes[].<br>http.<br>directResponse | **object**<br>Instructs the load balancer to respond directly as configured. <br>`routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP status code to use in responses.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Response body.</p> <p>A health check payload resource.</p> 
routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
routes[].<br>grpc | **object**<br>gRPC route configuration. <br>`routes[]` includes only one of the fields `http`, `grpc`<br>
routes[].<br>grpc.<br>match | **object**<br>Condition (predicate) used to select the route.
routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>Match settings for gRPC service method called in the request.</p> <p>A match string must be a fully qualified method name, e.g. ``foo.bar.v1.BazService/Get``, or a prefix of such.</p> <p>If not specified, the route matches all methods.</p> <p>A string matcher resource.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Exact match string.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Prefix match string.</p> 
routes[].<br>grpc.<br>match.<br>fqmn.<br>regexMatch | **string** <br>`routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Regular expression match string.</p> 
routes[].<br>grpc.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br>
routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a client specifies a lower timeout in HTTP ``grpc-timeout`` header, the ``max_timeout`` value is ignored.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>Default value: ``60``.</p> 
routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``maxTimeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events etc.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``maxTimeout``).</p> 
routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
routes[].<br>grpc.<br>statusResponse | **object**<br>Instructs the load balancer to respond directly with a specified status. <br>`routes[].grpc` includes only one of the fields `route`, `statusResponse`<br>
routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br><p>gRPC <a href="https://grpc.github.io/grpc/core/md_doc_statuscodes.html">status code</a> to use in responses.</p> <p>gRPC status code supported for use in responses.</p> <ul> <li>OK: ``OK`` (0) status code.</li> <li>INVALID_ARGUMENT: ``INVALID_ARGUMENT`` (3) status code.</li> <li>NOT_FOUND: ``NOT_FOUND`` (5) status code.</li> <li>PERMISSION_DENIED: ``PERMISSION_DENIED`` (7) status code.</li> <li>UNAUTHENTICATED: ``UNAUTHENTICATED`` (16) status code.</li> <li>UNIMPLEMENTED: ``UNIMPLEMENTED`` (12) status code.</li> <li>INTERNAL: ``INTERNAL`` (13) status code.</li> <li>UNAVAILABLE: ``UNAVAILABLE`` (14) status code.</li> </ul> 
modifyRequestHeaders[] | **object**<br><p>Deprecated, use route_options.modify_request_headers.</p> 
modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyRequestHeaders[].<br>append | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyRequestHeaders[].<br>replace | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
modifyRequestHeaders[].<br>rename | **string** <br>`modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
modifyResponseHeaders[] | **object**<br><p>Deprecated, use route_options.modify_response_headers.</p> 
modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
modifyResponseHeaders[].<br>append | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyResponseHeaders[].<br>replace | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
modifyResponseHeaders[].<br>rename | **string** <br>`modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
routeOptions | **object**
routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
routeOptions.<br>rbac | **object**<br><p>Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB service. Requests are allowed or denied based on the ``action`` and whether a matching principal is found. For instance, if the action is ALLOW and a matching principal is found the request should be allowed.</p> 
routeOptions.<br>rbac.<br>action | **string**<br><p>Required. The action to take if a principal matches. Every action either allows or denies a request.</p> <ul> <li>ALLOW: Allows the request if and only if there is a principal that matches the request.</li> <li>DENY: Allows the request if and only if there are no principal that match the request.</li> </ul> 
routeOptions.<br>rbac.<br>principals[] | **object**<br><p>Required. Required. A match occurs when at least one matches the request.</p> <p>The minimum number of elements is 1.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[] | **object**<br><p>Required. Required. A match occurs when all principals match the request.</p> <p>The minimum number of elements is 1.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header | **object**<br>A header (or pseudo-header such as :path or :method) of the incoming HTTP request. <br>`routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br>
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>name | **string**<br><p>Required. Specifies the name of the header in the request.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value | **object**<br><p>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value.</p> <p>A string matcher resource.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>exactMatch | **string** <br>`routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Exact match string.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>prefixMatch | **string** <br>`routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Prefix match string.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>header.<br>value.<br>regexMatch | **string** <br>`routeOptions.rbac.principals[].andPrincipals[].header.value` includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`<br><br><p>Regular expression match string.</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>remoteIp | **string** <br>`routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br><br><p>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .</p> 
routeOptions.<br>rbac.<br>principals[].<br>andPrincipals[].<br>any | **boolean** (boolean) <br>`routeOptions.rbac.principals[].andPrincipals[]` includes only one of the fields `header`, `remoteIp`, `any`<br><br><p>When any is set, it matches any request.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a virtual host in the specified HTTP router.
[delete](delete.md) | Deletes the specified virtual host.
[get](get.md) | Returns the specified virtual host.
[list](list.md) | Lists virtual hosts of the specified HTTP router.
[removeRoute](removeRoute.md) | Deletes the specified route from the specified virtual host.
[update](update.md) | Updates the specified virtual host of the specified HTTP router.
[updateRoute](updateRoute.md) | Updates the specified route of the specified virtual host.