---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/VirtualHost/list.md
---

# Application Load Balancer API, gRPC: VirtualHostService.List {#List}

Lists virtual hosts of the specified HTTP router.

## gRPC request

**rpc List ([ListVirtualHostsRequest](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsRequest)) returns ([ListVirtualHostsResponse](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsResponse))**

## ListVirtualHostsRequest {#yandex.cloud.apploadbalancer.v1.ListVirtualHostsRequest}

```json
{
  "httpRouterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| httpRouterId | **string**

Required field. ID of the HTTP router to list virtual hosts in.

To get the HTTP router ID, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListVirtualHostsResponse.nextPageToken](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVirtualHostsResponse.nextPageToken](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsResponse) returned by a previous list request. ||
|#

## ListVirtualHostsResponse {#yandex.cloud.apploadbalancer.v1.ListVirtualHostsResponse}

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
          // Includes only one of the fields `http`, `grpc`
          "http": {
            "match": {
              "httpMethod": [
                "string"
              ],
              "path": {
                // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                "regexMatch": "string"
                // end of the list of possible fields
              }
            },
            // Includes only one of the fields `route`, `redirect`, `directResponse`
            "route": {
              "backendGroupId": "string",
              "timeout": "google.protobuf.Duration",
              "idleTimeout": "google.protobuf.Duration",
              // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": "bool",
              // end of the list of possible fields
              "prefixRewrite": "string",
              "upgradeTypes": [
                "string"
              ],
              "rateLimit": {
                "allRequests": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "int64",
                  "perMinute": "int64"
                  // end of the list of possible fields
                },
                "requestsPerIp": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "int64",
                  "perMinute": "int64"
                  // end of the list of possible fields
                }
              }
            },
            "redirect": {
              "replaceScheme": "string",
              "replaceHost": "string",
              "replacePort": "int64",
              // Includes only one of the fields `replacePath`, `replacePrefix`
              "replacePath": "string",
              "replacePrefix": "string",
              // end of the list of possible fields
              "removeQuery": "bool",
              "responseCode": "RedirectResponseCode"
            },
            "directResponse": {
              "status": "int64",
              "body": {
                // Includes only one of the fields `text`
                "text": "string"
                // end of the list of possible fields
              }
            }
            // end of the list of possible fields
          },
          "grpc": {
            "match": {
              "fqmn": {
                // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                "regexMatch": "string"
                // end of the list of possible fields
              }
            },
            // Includes only one of the fields `route`, `statusResponse`
            "route": {
              "backendGroupId": "string",
              "maxTimeout": "google.protobuf.Duration",
              "idleTimeout": "google.protobuf.Duration",
              // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": "bool",
              // end of the list of possible fields
              "rateLimit": {
                "allRequests": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "int64",
                  "perMinute": "int64"
                  // end of the list of possible fields
                },
                "requestsPerIp": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "int64",
                  "perMinute": "int64"
                  // end of the list of possible fields
                }
              }
            },
            "statusResponse": {
              "status": "Status"
            }
            // end of the list of possible fields
          },
          // end of the list of possible fields
          "routeOptions": {
            "modifyRequestHeaders": [
              {
                "name": "string",
                // Includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": "bool",
                "rename": "string"
                // end of the list of possible fields
              }
            ],
            "modifyResponseHeaders": [
              {
                "name": "string",
                // Includes only one of the fields `append`, `replace`, `remove`, `rename`
                "append": "string",
                "replace": "string",
                "remove": "bool",
                "rename": "string"
                // end of the list of possible fields
              }
            ],
            "rbac": {
              "action": "Action",
              "principals": [
                {
                  "andPrincipals": [
                    {
                      // Includes only one of the fields `header`, `remoteIp`, `any`
                      "header": {
                        "name": "string",
                        "value": {
                          // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                          "exactMatch": "string",
                          "prefixMatch": "string",
                          "regexMatch": "string"
                          // end of the list of possible fields
                        }
                      },
                      "remoteIp": "string",
                      "any": "bool"
                      // end of the list of possible fields
                    }
                  ]
                }
              ]
            },
            "securityProfileId": "string"
          }
        }
      ],
      "modifyRequestHeaders": [
        {
          "name": "string",
          // Includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": "bool",
          "rename": "string"
          // end of the list of possible fields
        }
      ],
      "modifyResponseHeaders": [
        {
          "name": "string",
          // Includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": "bool",
          "rename": "string"
          // end of the list of possible fields
        }
      ],
      "routeOptions": {
        "modifyRequestHeaders": [
          {
            "name": "string",
            // Includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": "bool",
            "rename": "string"
            // end of the list of possible fields
          }
        ],
        "modifyResponseHeaders": [
          {
            "name": "string",
            // Includes only one of the fields `append`, `replace`, `remove`, `rename`
            "append": "string",
            "replace": "string",
            "remove": "bool",
            "rename": "string"
            // end of the list of possible fields
          }
        ],
        "rbac": {
          "action": "Action",
          "principals": [
            {
              "andPrincipals": [
                {
                  // Includes only one of the fields `header`, `remoteIp`, `any`
                  "header": {
                    "name": "string",
                    "value": {
                      // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                      "exactMatch": "string",
                      "prefixMatch": "string",
                      "regexMatch": "string"
                      // end of the list of possible fields
                    }
                  },
                  "remoteIp": "string",
                  "any": "bool"
                  // end of the list of possible fields
                }
              ]
            }
          ]
        },
        "securityProfileId": "string"
      },
      "rateLimit": {
        "allRequests": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "int64",
          "perMinute": "int64"
          // end of the list of possible fields
        },
        "requestsPerIp": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "int64",
          "perMinute": "int64"
          // end of the list of possible fields
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| virtualHosts[] | **[VirtualHost](#yandex.cloud.apploadbalancer.v1.VirtualHost)**

List of virtual hosts of the specified HTTP router. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListVirtualHostsRequest.pageSize](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsRequest), use `next_page_token` as the value
for the [ListVirtualHostsRequest.pageToken](#yandex.cloud.apploadbalancer.v1.ListVirtualHostsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## VirtualHost {#yandex.cloud.apploadbalancer.v1.VirtualHost}

A virtual host resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#virtual-host).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the virtual host. The name is unique within the HTTP router. ||
|| authority[] | **string**

List of domains that are attributed to the virtual host.

The host is selected to process the request received by the load balancer
if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain
specified in the host.

A wildcard asterisk character (`*`) matches 0 or more characters.

If not specified, all domains are attributed to the host, which is the same as specifying a `*` value.
An HTTP router must not contain more than one virtual host to which all domains are attributed. ||
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route)**

Routes of the virtual host.

A route contains a set of conditions (predicates) that are used by the load balancer to select the route
for the request and an action on the request.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

The order of routes matters: the first route whose predicate matches the request is selected.
The most specific routes should be at the top of the list, so that they are not overridden.
For example, if the first HTTP route is configured, via [HttpRoute.match](#yandex.cloud.apploadbalancer.v1.HttpRoute), to match paths prefixed with just `/`,
other routes are never matched. ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Deprecated, use route_options.modify_request_headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Deprecated, use route_options.modify_response_headers. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for a whole virtual host. ||
|#

## Route {#yandex.cloud.apploadbalancer.v1.Route}

A route resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the route. ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute)**

HTTP route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute)**

gRPC route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| directResponse | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| httpMethod[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch}

A string matcher resource.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| prefixMatch | **string**

Prefix match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| regexMatch | **string**

Regular expression match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction}

An HTTP route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idleTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefixRewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

If not specified, the path is not changed. ||
|| upgradeTypes[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| allRequests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requestsPerIp | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| perSecond | **int64**

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **int64**

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction}

A redirect action resource.

#|
||Field | Description ||
|| replaceScheme | **string**

URI scheme replacement.

If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
the port is also removed.

If not specified, the original scheme and port are used. ||
|| replaceHost | **string**

URI host replacement.

If not specified, the original host is used. ||
|| replacePort | **int64**

URI host replacement.

If not specified, the original host is used. ||
|| replacePath | **string**

Replacement for the whole path.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replacePrefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| removeQuery | **bool**

Removes URI query. ||
|| responseCode | enum **RedirectResponseCode**

HTTP status code to use in redirect responses.

- `MOVED_PERMANENTLY`: `301 Moved Permanently` status code.
- `FOUND`: `302 Found` status code.
- `SEE_OTHER`: `303 See Other` status code.
- `TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.
- `PERMANENT_REDIRECT`: `308 Permanent Redirect` status code. ||
|#

## DirectResponseAction {#yandex.cloud.apploadbalancer.v1.DirectResponseAction}

A direct response action resource.

#|
||Field | Description ||
|| status | **int64**

HTTP status code to use in responses. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**

Response body. ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload}

A health check payload resource.

#|
||Field | Description ||
|| text | **string**

Payload text.

Includes only one of the fields `text`.

Payload. ||
|#

## GrpcRoute {#yandex.cloud.apploadbalancer.v1.GrpcRoute}

A gRPC route configuration resource.

#|
||Field | Description ||
|| match | **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch)**

Condition (predicate) used to select the route. ||
|| route | **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|| statusResponse | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|#

## GrpcRouteMatch {#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch}

A gRPC route condition (predicate) resource.

#|
||Field | Description ||
|| fqmn | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Match settings for gRPC service method called in the request.

A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such.

If not specified, the route matches all methods. ||
|#

## GrpcRouteAction {#yandex.cloud.apploadbalancer.v1.GrpcRouteAction}

A gRPC route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to. ||
|| maxTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idleTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `maxTimeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events etc.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration
(see `maxTimeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction}

A gRPC status response action resource.

#|
||Field | Description ||
|| status | enum **Status**

gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses.

- `OK`: `OK` (0) status code.
- `INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.
- `NOT_FOUND`: `NOT_FOUND` (5) status code.
- `PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.
- `UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.
- `UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.
- `INTERNAL`: `INTERNAL` (13) status code.
- `UNAVAILABLE`: `UNAVAILABLE` (14) status code. ||
|#

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the request headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC)** ||
|| securityProfileId | **string**

Security profile that will take effect to all requests routed via particular virtual host. ||
|#

## HeaderModification {#yandex.cloud.apploadbalancer.v1.HeaderModification}

A header modification resource.

#|
||Field | Description ||
|| name | **string**

Name of the header. ||
|| append | **string**

Appends the specified string to the header value.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| replace | **string**

Replaces the value of the header with the specified string.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| remove | **bool**

Removes the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| rename | **string**

Replaces the name of the header with the specified string.
This operation is only supported for ALB Virtual Hosts.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|#

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC}

Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB
service. Requests are allowed or denied based on the `action` and whether a matching principal is
found. For instance, if the action is ALLOW and a matching principal is found the request should be
allowed.

#|
||Field | Description ||
|| action | enum **Action**

Required field. The action to take if a principal matches. Every action either allows or denies a request.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Allows the request if and only if there is a principal that matches the request.
- `DENY`: Allows the request if and only if there are no principal that match the request. ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals)**

Required. A match occurs when at least one matches the request. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| remoteIp | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| any | **bool**

When any is set, it matches any request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|#

## HeaderMatcher {#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher}

#|
||Field | Description ||
|| name | **string**

Required field. Specifies the name of the header in the request. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Specifies how the header match will be performed to route the request.
In the absence of value a request that has specified header name will match,
regardless of the header's value. ||
|#