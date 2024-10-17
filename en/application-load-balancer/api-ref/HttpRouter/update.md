---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/HttpRouter/update.md
---

# Application Load Balancer API, REST: HttpRouter.Update {#Update}

Updates the specified HTTP router.

## HTTP request

```
PATCH https://alb.{{ api-host }}/apploadbalancer/v1/httpRouters/{httpRouterId}
```

## Path parameters

#|
||Field | Description ||
|| httpRouterId | **string**

Required field. ID of the HTTP router to update.

To get the HTTP router ID, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.UpdateHttpRouterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
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
              "timeout": "string",
              "idleTimeout": "string",
              // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": "boolean",
              // end of the list of possible fields
              "prefixRewrite": "string",
              "upgradeTypes": [
                "string"
              ],
              "rateLimit": {
                "allRequests": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "string",
                  "perMinute": "string"
                  // end of the list of possible fields
                },
                "requestsPerIp": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "string",
                  "perMinute": "string"
                  // end of the list of possible fields
                }
              }
            },
            "redirect": {
              "replaceScheme": "string",
              "replaceHost": "string",
              "replacePort": "string",
              // Includes only one of the fields `replacePath`, `replacePrefix`
              "replacePath": "string",
              "replacePrefix": "string",
              // end of the list of possible fields
              "removeQuery": "boolean",
              "responseCode": "string"
            },
            "directResponse": {
              "status": "string",
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
              "maxTimeout": "string",
              "idleTimeout": "string",
              // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": "boolean",
              // end of the list of possible fields
              "rateLimit": {
                "allRequests": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "string",
                  "perMinute": "string"
                  // end of the list of possible fields
                },
                "requestsPerIp": {
                  // Includes only one of the fields `perSecond`, `perMinute`
                  "perSecond": "string",
                  "perMinute": "string"
                  // end of the list of possible fields
                }
              }
            },
            "statusResponse": {
              "status": "string"
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
                "remove": "boolean",
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
                "remove": "boolean",
                "rename": "string"
                // end of the list of possible fields
              }
            ],
            "rbac": {
              "action": "string",
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
                      "any": "boolean"
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
          "remove": "boolean",
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
          "remove": "boolean",
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
            "remove": "boolean",
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
            "remove": "boolean",
            "rename": "string"
            // end of the list of possible fields
          }
        ],
        "rbac": {
          "action": "string",
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
                  "any": "boolean"
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
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        },
        "requestsPerIp": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        }
      }
    }
  ],
  "routeOptions": {
    "modifyRequestHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
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
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "rbac": {
      "action": "string",
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
              "any": "boolean"
              // end of the list of possible fields
            }
          ]
        }
      ]
    },
    "securityProfileId": "string"
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the HTTP router.
The name must be unique within the folder. ||
|| description | **string**

New description of the HTTP router. ||
|| labels | **string**

HTTP router labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [HttpRouterService.Get](/docs/application-load-balancer/api-ref/HttpRouter/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| virtualHosts[] | **[VirtualHost](#yandex.cloud.apploadbalancer.v1.VirtualHost)**

New virtual hosts that combine routes inside the router.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#virtual-host).

Only one virtual host with no authority (default match) can be specified.

Existing list of virtual hosts is completely replaced by the specified list, so if you just want to add or remove
a virtual host, make a [VirtualHostService.Create](/docs/application-load-balancer/api-ref/VirtualHost/create#Create) request or a [VirtualHostService.Delete](/docs/application-load-balancer/api-ref/VirtualHost/delete#Delete) request. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)**

New route options for the HTTP router. ||
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
|| timeout | **string** (duration)

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

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
|| autoHostRewrite | **boolean**

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
|| perSecond | **string** (int64)

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

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
|| replacePort | **string** (int64)

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
|| removeQuery | **boolean**

Removes URI query. ||
|| responseCode | **enum** (RedirectResponseCode)

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
|| status | **string** (int64)

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
|| maxTimeout | **string** (duration)

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

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
|| autoHostRewrite | **boolean**

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
|| status | **enum** (Status)

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
|| remove | **boolean**

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
|| action | **enum** (Action)

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
|| any | **boolean**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "httpRouterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folderId": "string",
    "labels": "string",
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
                "timeout": "string",
                "idleTimeout": "string",
                // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
                "hostRewrite": "string",
                "autoHostRewrite": "boolean",
                // end of the list of possible fields
                "prefixRewrite": "string",
                "upgradeTypes": [
                  "string"
                ],
                "rateLimit": {
                  "allRequests": {
                    // Includes only one of the fields `perSecond`, `perMinute`
                    "perSecond": "string",
                    "perMinute": "string"
                    // end of the list of possible fields
                  },
                  "requestsPerIp": {
                    // Includes only one of the fields `perSecond`, `perMinute`
                    "perSecond": "string",
                    "perMinute": "string"
                    // end of the list of possible fields
                  }
                }
              },
              "redirect": {
                "replaceScheme": "string",
                "replaceHost": "string",
                "replacePort": "string",
                // Includes only one of the fields `replacePath`, `replacePrefix`
                "replacePath": "string",
                "replacePrefix": "string",
                // end of the list of possible fields
                "removeQuery": "boolean",
                "responseCode": "string"
              },
              "directResponse": {
                "status": "string",
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
                "maxTimeout": "string",
                "idleTimeout": "string",
                // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
                "hostRewrite": "string",
                "autoHostRewrite": "boolean",
                // end of the list of possible fields
                "rateLimit": {
                  "allRequests": {
                    // Includes only one of the fields `perSecond`, `perMinute`
                    "perSecond": "string",
                    "perMinute": "string"
                    // end of the list of possible fields
                  },
                  "requestsPerIp": {
                    // Includes only one of the fields `perSecond`, `perMinute`
                    "perSecond": "string",
                    "perMinute": "string"
                    // end of the list of possible fields
                  }
                }
              },
              "statusResponse": {
                "status": "string"
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
                  "remove": "boolean",
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
                  "remove": "boolean",
                  "rename": "string"
                  // end of the list of possible fields
                }
              ],
              "rbac": {
                "action": "string",
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
                        "any": "boolean"
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
            "remove": "boolean",
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
            "remove": "boolean",
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
              "remove": "boolean",
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
              "remove": "boolean",
              "rename": "string"
              // end of the list of possible fields
            }
          ],
          "rbac": {
            "action": "string",
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
                    "any": "boolean"
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
            "perSecond": "string",
            "perMinute": "string"
            // end of the list of possible fields
          },
          "requestsPerIp": {
            // Includes only one of the fields `perSecond`, `perMinute`
            "perSecond": "string",
            "perMinute": "string"
            // end of the list of possible fields
          }
        }
      }
    ],
    "createdAt": "string",
    "routeOptions": {
      "modifyRequestHeaders": [
        {
          "name": "string",
          // Includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": "boolean",
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
          "remove": "boolean",
          "rename": "string"
          // end of the list of possible fields
        }
      ],
      "rbac": {
        "action": "string",
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
                "any": "boolean"
                // end of the list of possible fields
              }
            ]
          }
        ]
      },
      "securityProfileId": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateHttpRouterMetadata](#yandex.cloud.apploadbalancer.v1.UpdateHttpRouterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[HttpRouter](#yandex.cloud.apploadbalancer.v1.HttpRouter)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateHttpRouterMetadata {#yandex.cloud.apploadbalancer.v1.UpdateHttpRouterMetadata}

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## HttpRouter {#yandex.cloud.apploadbalancer.v1.HttpRouter}

An HTTP router resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router).

#|
||Field | Description ||
|| id | **string**

ID of the router. Generated at creation time. ||
|| name | **string**

Name of the router. The name is unique within the folder. ||
|| description | **string**

Description of the router. ||
|| folderId | **string**

ID of the folder that the router belongs to. ||
|| labels | **string**

Router labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| virtualHosts[] | **[VirtualHost](#yandex.cloud.apploadbalancer.v1.VirtualHost2)**

Virtual hosts that combine routes inside the router.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#virtual-host).

Only one virtual host with no authority (default match) can be specified. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|#

## VirtualHost {#yandex.cloud.apploadbalancer.v1.VirtualHost2}

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
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route2)**

Routes of the virtual host.

A route contains a set of conditions (predicates) that are used by the load balancer to select the route
for the request and an action on the request.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

The order of routes matters: the first route whose predicate matches the request is selected.
The most specific routes should be at the top of the list, so that they are not overridden.
For example, if the first HTTP route is configured, via [HttpRoute.match](#yandex.cloud.apploadbalancer.v1.HttpRoute2), to match paths prefixed with just `/`,
other routes are never matched. ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_request_headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_response_headers. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for a whole virtual host. ||
|#

## Route {#yandex.cloud.apploadbalancer.v1.Route2}

A route resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the route. ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute2)**

HTTP route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute2)**

gRPC route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute2}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction2)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction2)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| directResponse | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction2)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| httpMethod[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch2}

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

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction2}

An HTTP route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **string** (duration)

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

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
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefixRewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

If not specified, the path is not changed. ||
|| upgradeTypes[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit2}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| allRequests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requestsPerIp | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| perSecond | **string** (int64)

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction2}

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
|| replacePort | **string** (int64)

URI host replacement.

If not specified, the original host is used. ||
|| replacePath | **string**

Replacement for the whole path.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replacePrefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| removeQuery | **boolean**

Removes URI query. ||
|| responseCode | **enum** (RedirectResponseCode)

HTTP status code to use in redirect responses.

- `MOVED_PERMANENTLY`: `301 Moved Permanently` status code.
- `FOUND`: `302 Found` status code.
- `SEE_OTHER`: `303 See Other` status code.
- `TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.
- `PERMANENT_REDIRECT`: `308 Permanent Redirect` status code. ||
|#

## DirectResponseAction {#yandex.cloud.apploadbalancer.v1.DirectResponseAction2}

A direct response action resource.

#|
||Field | Description ||
|| status | **string** (int64)

HTTP status code to use in responses. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload2)**

Response body. ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload2}

A health check payload resource.

#|
||Field | Description ||
|| text | **string**

Payload text.

Includes only one of the fields `text`.

Payload. ||
|#

## GrpcRoute {#yandex.cloud.apploadbalancer.v1.GrpcRoute2}

A gRPC route configuration resource.

#|
||Field | Description ||
|| match | **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch2)**

Condition (predicate) used to select the route. ||
|| route | **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction2)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|| statusResponse | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|#

## GrpcRouteMatch {#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch2}

A gRPC route condition (predicate) resource.

#|
||Field | Description ||
|| fqmn | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Match settings for gRPC service method called in the request.

A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such.

If not specified, the route matches all methods. ||
|#

## GrpcRouteAction {#yandex.cloud.apploadbalancer.v1.GrpcRouteAction2}

A gRPC route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to. ||
|| maxTimeout | **string** (duration)

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

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
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2}

A gRPC status response action resource.

#|
||Field | Description ||
|| status | **enum** (Status)

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

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions2}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the request headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC2)** ||
|| securityProfileId | **string**

Security profile that will take effect to all requests routed via particular virtual host. ||
|#

## HeaderModification {#yandex.cloud.apploadbalancer.v1.HeaderModification2}

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
|| remove | **boolean**

Removes the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| rename | **string**

Replaces the name of the header with the specified string.
This operation is only supported for ALB Virtual Hosts.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|#

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC2}

Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB
service. Requests are allowed or denied based on the `action` and whether a matching principal is
found. For instance, if the action is ALLOW and a matching principal is found the request should be
allowed.

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. The action to take if a principal matches. Every action either allows or denies a request.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Allows the request if and only if there is a principal that matches the request.
- `DENY`: Allows the request if and only if there are no principal that match the request. ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals2)**

Required. A match occurs when at least one matches the request. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals2}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal2)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal2}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher2)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| remoteIp | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| any | **boolean**

When any is set, it matches any request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|#

## HeaderMatcher {#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher2}

#|
||Field | Description ||
|| name | **string**

Required field. Specifies the name of the header in the request. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Specifies how the header match will be performed to route the request.
In the absence of value a request that has specified header name will match,
regardless of the header's value. ||
|#