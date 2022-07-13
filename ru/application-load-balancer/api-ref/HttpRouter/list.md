---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/HttpRouter/list.md
---

# Method list
Lists HTTP routers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://alb.{{ api-host }}/apploadbalancer/v1/httpRouters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list HTTP routers in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/application-load-balancer/api-ref/HttpRouter/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters HTTP routers listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/application-load-balancer/api-ref/HttpRouter#representation">HttpRouter.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-http-router``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "httpRouters": [
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
              "routeOptions": {
                "modifyRequestHeaders": [
                  {
                    "name": "string",

                    // `httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                    "append": "string",
                    "replace": "string",
                    "remove": true,
                    "rename": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]`

                  }
                ],
                "modifyResponseHeaders": [
                  {
                    "name": "string",

                    // `httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                    "append": "string",
                    "replace": "string",
                    "remove": true,
                    "rename": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]`

                  }
                ]
              },

              // `httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`
              "http": {
                "match": {
                  "httpMethod": [
                    "string"
                  ],
                  "path": {

                    // `httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
                    "exactMatch": "string",
                    "prefixMatch": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http.match.path`

                  }
                },

                // `httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`
                "route": {
                  "backendGroupId": "string",
                  "timeout": "string",
                  "idleTimeout": "string",
                  "prefixRewrite": "string",
                  "upgradeTypes": [
                    "string"
                  ],

                  // `httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
                  "hostRewrite": "string",
                  "autoHostRewrite": true,
                  // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http.route`

                },
                "redirect": {
                  "replaceScheme": "string",
                  "replaceHost": "string",
                  "replacePort": "string",
                  "removeQuery": true,
                  "responseCode": "string",

                  // `httpRouters[].virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`
                  "replacePath": "string",
                  "replacePrefix": "string",
                  // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http.redirect`

                },
                "directResponse": {
                  "status": "string",
                  "body": {
                    "text": "string"
                  }
                },
                // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http`

              },
              "grpc": {
                "match": {
                  "fqmn": {

                    // `httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
                    "exactMatch": "string",
                    "prefixMatch": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn`

                  }
                },

                // `httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`
                "route": {
                  "backendGroupId": "string",
                  "maxTimeout": "string",
                  "idleTimeout": "string",

                  // `httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
                  "hostRewrite": "string",
                  "autoHostRewrite": true,
                  // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc.route`

                },
                "statusResponse": {
                  "status": "string"
                },
                // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc`

              },
              // end of the list of possible fields`httpRouters[].virtualHosts[].routes[]`

            }
          ],
          "modifyRequestHeaders": [
            {
              "name": "string",

              // `httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": true,
              "rename": "string",
              // end of the list of possible fields`httpRouters[].virtualHosts[].modifyRequestHeaders[]`

            }
          ],
          "modifyResponseHeaders": [
            {
              "name": "string",

              // `httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": true,
              "rename": "string",
              // end of the list of possible fields`httpRouters[].virtualHosts[].modifyResponseHeaders[]`

            }
          ],
          "routeOptions": {
            "modifyRequestHeaders": [
              {
                "name": "string",

                // `httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": true,
                "rename": "string",
                // end of the list of possible fields`httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]`

              }
            ],
            "modifyResponseHeaders": [
              {
                "name": "string",

                // `httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": true,
                "rename": "string",
                // end of the list of possible fields`httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]`

              }
            ]
          }
        }
      ],
      "createdAt": "string",
      "routeOptions": {
        "modifyRequestHeaders": [
          {
            "name": "string",

            // `httpRouters[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`httpRouters[].routeOptions.modifyRequestHeaders[]`

          }
        ],
        "modifyResponseHeaders": [
          {
            "name": "string",

            // `httpRouters[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": true,
            "rename": "string",
            // end of the list of possible fields`httpRouters[].routeOptions.modifyResponseHeaders[]`

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
httpRouters[] | **object**<br><p>List of HTTP routers in the specified folder.</p> 
httpRouters[].<br>id | **string**<br><p>ID of the router. Generated at creation time.</p> 
httpRouters[].<br>name | **string**<br><p>Name of the router. The name is unique within the folder.</p> 
httpRouters[].<br>description | **string**<br><p>Description of the router.</p> 
httpRouters[].<br>folderId | **string**<br><p>ID of the folder that the router belongs to.</p> 
httpRouters[].<br>labels | **object**<br><p>Router labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
httpRouters[].<br>virtualHosts[] | **object**<br><p>Virtual hosts that combine routes inside the router. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#virtual-host">documentation</a>.</p> <p>Only one virtual host with no authority (default match) can be specified.</p> 
httpRouters[].<br>virtualHosts[].<br>name | **string**<br><p>Required. Name of the virtual host. The name is unique within the HTTP router.</p> 
httpRouters[].<br>virtualHosts[].<br>authority[] | **string**<br><p>List of domains that are attributed to the virtual host.</p> <p>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header matches a domain specified in the host.</p> <p>A wildcard asterisk character (``*``) matches 0 or more characters.</p> <p>If not specified, all domains are attributed to the host, which is the same as specifying a ``*`` value. An HTTP router must not contain more than one virtual host to which all domains are attributed.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[] | **object**<br><p>Routes of the virtual host.</p> <p>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router#routes">documentation</a>.</p> <p>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via ``match``, to match paths prefixed with just ``/``, other routes are never matched.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>name | **string**<br><p>Required. Name of the route.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions | **object**
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].routes[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http | **object**<br>HTTP route configuration. <br>`httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match | **object**<br>Condition (predicate) used to select the route.
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br><p>HTTP method specified in the request.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path | **object**<br><p>Match settings for the path specified in the request.</p> <p>If not specified, the route matches all paths.</p> <p>A string matcher resource.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> <p>Stream (TCP) backend groups are not supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>timeout | **string**<br><p>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>Default value: ``60``.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``timeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events (``EventSource`` interface) etc.</p> <p>If a connection times out, the load balancer responds to the client with a ``504 Gateway Timeout`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``timeout``).</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``/foobaz`` path is forwarded with ``/barbaz`` path. For ``exactMatch``, the whole path is replaced.</p> <p>If not specified, the path is not changed.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>upgradeTypes[] | **string**<br><p>Supported values for HTTP ``Upgrade`` header. E.g. ``websocket``.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect | **object**<br>Redirects the request as configured. <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>URI scheme replacement.</p> <p>If ``http`` or ``https`` scheme is to be replaced and ``80`` or ``443`` port is specified in the original URI, the port is also removed.</p> <p>If not specified, the original scheme and port are used.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceHost | **string**<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePort | **string** (int64)<br><p>URI host replacement.</p> <p>If not specified, the original host is used.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>removeQuery | **boolean** (boolean)<br><p>Removes URI query.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>responseCode | **string**<br>HTTP status code to use in redirect responses.<br><ul> <li>MOVED_PERMANENTLY: ``301 Moved Permanently`` status code.</li> <li>FOUND: ``302 Found`` status code.</li> <li>SEE_OTHER: ``303 See Other`` status code.</li> <li>TEMPORARY_REDIRECT: ``307 Temporary Redirect`` status code.</li> <li>PERMANENT_REDIRECT: ``308 Permanent Redirect`` status code.</li> </ul> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePath | **string** <br>`httpRouters[].virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the whole path.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replacePrefix | **string** <br>`httpRouters[].virtualHosts[].routes[].http.redirect` includes only one of the fields `replacePath`, `replacePrefix`<br><br><p>Replacement for the path prefix matched by ``StringMatch``.</p> <p>For instance, if ``prefixMatch`` value is ``/foo`` and ``replace_prefix`` value is ``/bar``, a request with ``https://example.com/foobaz`` URI is redirected to ``https://example.com/barbaz``. For ``exactMatch``, the whole path is replaced.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse | **object**<br>Instructs the load balancer to respond directly as configured. <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP status code to use in responses.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Response body.</p> <p>A health check payload resource.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc | **object**<br>gRPC route configuration. <br>`httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match | **object**<br>Condition (predicate) used to select the route.
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>Match settings for gRPC service method called in the request.</p> <p>A match string must be a fully qualified method name, e.g. ``foo.bar.v1.BazService/Get``, or a prefix of such.</p> <p>If not specified, the route matches all methods.</p> <p>A string matcher resource.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Exact match string.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br><p>Prefix match string.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route | **object**<br>Forwards the request to a backend group for processing as configured. <br>`httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to forward requests to.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it.</p> <p>If a client specifies a lower timeout in HTTP ``grpc-timeout`` header, the ``max_timeout`` value is ignored.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>Default value: ``60``.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>idleTimeout | **string**<br><p>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.</p> <p>Specifying meaningful values for both ``maxTimeout`` and ``idle_timeout`` is useful for implementing server-push mechanisms such as long polling, server-sent events etc.</p> <p>If a connection times out, the load balancer responds to the client with an ``UNAVAILABLE`` status code.</p> <p>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see ``maxTimeout``).</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Host replacement.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br><p>Automatically replaces the host with that of the target.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse | **object**<br>Instructs the load balancer to respond directly with a specified status. <br>`httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br><p>gRPC <a href="https://grpc.github.io/grpc/core/md_doc_statuscodes.html">status code</a> to use in responses.</p> <p>gRPC status code supported for use in responses.</p> <ul> <li>OK: ``OK`` (0) status code.</li> <li>INVALID_ARGUMENT: ``INVALID_ARGUMENT`` (3) status code.</li> <li>NOT_FOUND: ``NOT_FOUND`` (5) status code.</li> <li>PERMISSION_DENIED: ``PERMISSION_DENIED`` (7) status code.</li> <li>UNAUTHENTICATED: ``UNAUTHENTICATED`` (16) status code.</li> <li>UNIMPLEMENTED: ``UNIMPLEMENTED`` (12) status code.</li> <li>INTERNAL: ``INTERNAL`` (13) status code.</li> <li>UNAVAILABLE: ``UNAVAILABLE`` (14) status code.</li> </ul> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[] | **object**<br><p>Deprecated, use route_options.modify_request_headers.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[] | **object**<br><p>Deprecated, use route_options.modify_response_headers.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions | **object**
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>virtualHosts[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
httpRouters[].<br>routeOptions | **object**
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[].<br>append | **string** <br>`httpRouters[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[].<br>replace | **string** <br>`httpRouters[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>routeOptions.<br>modifyRequestHeaders[].<br>rename | **string** <br>`httpRouters[].routeOptions.modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[].<br>append | **string** <br>`httpRouters[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Appends the specified string to the header value.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[].<br>replace | **string** <br>`httpRouters[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the value of the header with the specified string.</p> <p>Variables <a href="https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers">defined for Envoy proxy</a> are supported.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Removes the header.</p> 
httpRouters[].<br>routeOptions.<br>modifyResponseHeaders[].<br>rename | **string** <br>`httpRouters[].routeOptions.modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/HttpRouter/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/HttpRouter/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 