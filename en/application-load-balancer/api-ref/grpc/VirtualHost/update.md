---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/VirtualHost/update.md
---

# Application Load Balancer API, gRPC: VirtualHostService.Update

Updates the specified virtual host of the specified HTTP router.

## gRPC request

**rpc Update ([UpdateVirtualHostRequest](#yandex.cloud.apploadbalancer.v1.UpdateVirtualHostRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateVirtualHostRequest {#yandex.cloud.apploadbalancer.v1.UpdateVirtualHostRequest}

```json
{
  "http_router_id": "string",
  "virtual_host_name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "authority": [
    "string"
  ],
  "routes": [
    {
      "name": "string",
      // Includes only one of the fields `http`, `grpc`
      "http": {
        "match": {
          "http_method": [
            "string"
          ],
          "path": {
            // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
            "exact_match": "string",
            "prefix_match": "string",
            "regex_match": "string"
            // end of the list of possible fields
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                "exact_match": "string",
                "prefix_match": "string",
                "regex_match": "string"
                // end of the list of possible fields
              }
            }
          ],
          "query_parameters": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                "exact_match": "string",
                "prefix_match": "string",
                "regex_match": "string"
                // end of the list of possible fields
              }
            }
          ]
        },
        // Includes only one of the fields `route`, `redirect`, `direct_response`
        "route": {
          "backend_group_id": "string",
          "timeout": "google.protobuf.Duration",
          "idle_timeout": "google.protobuf.Duration",
          // Includes only one of the fields `host_rewrite`, `auto_host_rewrite`
          "host_rewrite": "string",
          "auto_host_rewrite": "bool",
          // end of the list of possible fields
          "prefix_rewrite": "string",
          "upgrade_types": [
            "string"
          ],
          "rate_limit": {
            "all_requests": {
              // Includes only one of the fields `per_second`, `per_minute`
              "per_second": "int64",
              "per_minute": "int64"
              // end of the list of possible fields
            },
            "requests_per_ip": {
              // Includes only one of the fields `per_second`, `per_minute`
              "per_second": "int64",
              "per_minute": "int64"
              // end of the list of possible fields
            }
          },
          "regex_rewrite": {
            "regex": "string",
            "substitute": "string"
          }
        },
        "redirect": {
          "replace_scheme": "string",
          "replace_host": "string",
          "replace_port": "int64",
          // Includes only one of the fields `replace_path`, `replace_prefix`
          "replace_path": "string",
          "replace_prefix": "string",
          // end of the list of possible fields
          "remove_query": "bool",
          "response_code": "RedirectResponseCode"
        },
        "direct_response": {
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
            // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
            "exact_match": "string",
            "prefix_match": "string",
            "regex_match": "string"
            // end of the list of possible fields
          }
        },
        // Includes only one of the fields `route`, `status_response`
        "route": {
          "backend_group_id": "string",
          "max_timeout": "google.protobuf.Duration",
          "idle_timeout": "google.protobuf.Duration",
          // Includes only one of the fields `host_rewrite`, `auto_host_rewrite`
          "host_rewrite": "string",
          "auto_host_rewrite": "bool",
          // end of the list of possible fields
          "rate_limit": {
            "all_requests": {
              // Includes only one of the fields `per_second`, `per_minute`
              "per_second": "int64",
              "per_minute": "int64"
              // end of the list of possible fields
            },
            "requests_per_ip": {
              // Includes only one of the fields `per_second`, `per_minute`
              "per_second": "int64",
              "per_minute": "int64"
              // end of the list of possible fields
            }
          }
        },
        "status_response": {
          "status": "Status"
        }
        // end of the list of possible fields
      },
      // end of the list of possible fields
      "route_options": {
        "modify_request_headers": [
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
        "modify_response_headers": [
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
              "and_principals": [
                {
                  // Includes only one of the fields `header`, `remote_ip`, `any`
                  "header": {
                    "name": "string",
                    "value": {
                      // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                      "exact_match": "string",
                      "prefix_match": "string",
                      "regex_match": "string"
                      // end of the list of possible fields
                    }
                  },
                  "remote_ip": "string",
                  "any": "bool"
                  // end of the list of possible fields
                }
              ]
            }
          ]
        },
        "security_profile_id": "string"
      },
      "disable_security_profile": "bool"
    }
  ],
  "modify_request_headers": [
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
  "modify_response_headers": [
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
  "route_options": {
    "modify_request_headers": [
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
    "modify_response_headers": [
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
          "and_principals": [
            {
              // Includes only one of the fields `header`, `remote_ip`, `any`
              "header": {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                  "exact_match": "string",
                  "prefix_match": "string",
                  "regex_match": "string"
                  // end of the list of possible fields
                }
              },
              "remote_ip": "string",
              "any": "bool"
              // end of the list of possible fields
            }
          ]
        }
      ]
    },
    "security_profile_id": "string"
  },
  "rate_limit": {
    "all_requests": {
      // Includes only one of the fields `per_second`, `per_minute`
      "per_second": "int64",
      "per_minute": "int64"
      // end of the list of possible fields
    },
    "requests_per_ip": {
      // Includes only one of the fields `per_second`, `per_minute`
      "per_second": "int64",
      "per_minute": "int64"
      // end of the list of possible fields
    }
  }
}
```

#|
||Field | Description ||
|| http_router_id | **string**

Required field. ID of the HTTP router to update a virtual host in.

To get the HTTP router ID, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| virtual_host_name | **string**

Required field. Name of the virtual host.

Used only to refer to the virtual host. The name of a host cannot be changed.

To get the virtual host name, make a [VirtualHostService.List](/docs/application-load-balancer/api-ref/grpc/VirtualHost/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the virtual host should be updated. ||
|| authority[] | **string**

New list of domains to attribute to the virtual host.

The host is selected to process the request received by the load balancer
if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain
specified in the host.

A wildcard asterisk character (`*`) matches 0 or more characters.

Existing list of domains is completely replaced by the specified list.

If not specified, all domains are attributed to the host, which is the same as specifying a `*` value.
An HTTP router must not contain more than one virtual host to which all domains are attributed. ||
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route)**

New list of routes of the virtual host.

A route contains a set of conditions (predicates) that are used by the load balancer to select the route
for the request and an action on the request.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

The order of routes matters: the first route whose predicate matches the request is selected.
The most specific routes should be at the top of the list, so that they are not overridden.
For example, if the first HTTP route is configured, via [HttpRoute.match](#yandex.cloud.apploadbalancer.v1.HttpRoute), to match paths prefixed with just `/`,
other routes are never matched.

Existing list of routes is completely replaced by the specified list, so if you just want to remove a route,
make a [VirtualHostService.RemoveRoute](/docs/application-load-balancer/api-ref/grpc/VirtualHost/removeRoute#RemoveRoute) request. ||
|| modify_request_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

New list of modifications that are made to the headers of incoming HTTP requests
before they are forwarded to backends.

Existing list of modifications is completely replaced by the specified list. ||
|| modify_response_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

New list of modifications that are made to the headers of HTTP responses received from backends
before responses are forwarded to clients.

Existing list of modifications is completely replaced by the specified list. ||
|| route_options | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)**

New route options for the virtual host. ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

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
|| route_options | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|| disable_security_profile | **bool**

Whether set to 'true' disables security profile for the route. ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|| direct_response | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| http_method[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch)**

Headers specify HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route. Headers must be unique. ||
|| query_parameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch)**

Query Parameters specify HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route. Query parameters must be unique. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch}

A string matcher resource.

#|
||Field | Description ||
|| exact_match | **string**

Exact match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|| prefix_match | **string**

Prefix match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|| regex_match | **string**

Regular expression match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|#

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP Header to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP Header to be matched. ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP query parameter to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP query parameter to be matched. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction}

An HTTP route action resource.

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). ||
|| host_rewrite | **string**

Host replacement.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| auto_host_rewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefix_rewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefix_match](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exact_match](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

If not specified, the path is not changed.

Only one of regex_rewrite, or prefix_rewrite may be specified. ||
|| upgrade_types[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|| regex_rewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute)**

Replacement for portions of the path that match the pattern should be rewritten,
even allowing the substitution of capture groups from the pattern into the new path as specified
by the rewrite substitution string.

Only one of regex_rewrite, or prefix_rewrite may be specified.

Examples of using:
- The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform
/service/foo/v1/api into /v1/api/instance/foo.
- The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz
into /xxx/two/yyy/two/zzz.
- The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first
occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.
- The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform
path /aaa/XxX/bbb to /aaa/yyy/bbb. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| all_requests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requests_per_ip | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| per_second | **int64**

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `per_second`, `per_minute`. ||
|| per_minute | **int64**

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `per_second`, `per_minute`. ||
|#

## RegexMatchAndSubstitute {#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute}

#|
||Field | Description ||
|| regex | **string**

The regular expression used to find portions of a string that should be replaced. ||
|| substitute | **string**

The string that should be substituted into matching portions of the subject string during a substitution operation
to produce a new string. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction}

A redirect action resource.

#|
||Field | Description ||
|| replace_scheme | **string**

URI scheme replacement.

If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
the port is also removed.

If not specified, the original scheme and port are used. ||
|| replace_host | **string**

URI host replacement.

If not specified, the original host is used. ||
|| replace_port | **int64**

URI host replacement.

If not specified, the original host is used. ||
|| replace_path | **string**

Replacement for the whole path.

Includes only one of the fields `replace_path`, `replace_prefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replace_prefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefix_match](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exact_match](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

Includes only one of the fields `replace_path`, `replace_prefix`.

URI path replacement.

If not specified, the original path is used. ||
|| remove_query | **bool**

Removes URI query. ||
|| response_code | enum **RedirectResponseCode**

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

Includes only one of the fields `route`, `status_response`.

Action performed on the request if the route is selected. ||
|| status_response | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `status_response`.

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
|| backend_group_id | **string**

Required field. Backend group to forward requests to. ||
|| max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events etc.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration
(see `max_timeout`). ||
|| host_rewrite | **string**

Host replacement.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| auto_host_rewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

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
|| modify_request_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the request headers. ||
|| modify_response_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC)** ||
|| security_profile_id | **string**

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
|| and_principals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remote_ip`, `any`. ||
|| remote_ip | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remote_ip`, `any`. ||
|| any | **bool**

When any is set, it matches any request.

Includes only one of the fields `header`, `remote_ip`, `any`. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "http_router_id": "string",
    "virtual_host_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
            "http_method": [
              "string"
            ],
            "path": {
              // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
              "exact_match": "string",
              "prefix_match": "string",
              "regex_match": "string"
              // end of the list of possible fields
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                  "exact_match": "string",
                  "prefix_match": "string",
                  "regex_match": "string"
                  // end of the list of possible fields
                }
              }
            ],
            "query_parameters": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                  "exact_match": "string",
                  "prefix_match": "string",
                  "regex_match": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          // Includes only one of the fields `route`, `redirect`, `direct_response`
          "route": {
            "backend_group_id": "string",
            "timeout": "google.protobuf.Duration",
            "idle_timeout": "google.protobuf.Duration",
            // Includes only one of the fields `host_rewrite`, `auto_host_rewrite`
            "host_rewrite": "string",
            "auto_host_rewrite": "bool",
            // end of the list of possible fields
            "prefix_rewrite": "string",
            "upgrade_types": [
              "string"
            ],
            "rate_limit": {
              "all_requests": {
                // Includes only one of the fields `per_second`, `per_minute`
                "per_second": "int64",
                "per_minute": "int64"
                // end of the list of possible fields
              },
              "requests_per_ip": {
                // Includes only one of the fields `per_second`, `per_minute`
                "per_second": "int64",
                "per_minute": "int64"
                // end of the list of possible fields
              }
            },
            "regex_rewrite": {
              "regex": "string",
              "substitute": "string"
            }
          },
          "redirect": {
            "replace_scheme": "string",
            "replace_host": "string",
            "replace_port": "int64",
            // Includes only one of the fields `replace_path`, `replace_prefix`
            "replace_path": "string",
            "replace_prefix": "string",
            // end of the list of possible fields
            "remove_query": "bool",
            "response_code": "RedirectResponseCode"
          },
          "direct_response": {
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
              // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
              "exact_match": "string",
              "prefix_match": "string",
              "regex_match": "string"
              // end of the list of possible fields
            }
          },
          // Includes only one of the fields `route`, `status_response`
          "route": {
            "backend_group_id": "string",
            "max_timeout": "google.protobuf.Duration",
            "idle_timeout": "google.protobuf.Duration",
            // Includes only one of the fields `host_rewrite`, `auto_host_rewrite`
            "host_rewrite": "string",
            "auto_host_rewrite": "bool",
            // end of the list of possible fields
            "rate_limit": {
              "all_requests": {
                // Includes only one of the fields `per_second`, `per_minute`
                "per_second": "int64",
                "per_minute": "int64"
                // end of the list of possible fields
              },
              "requests_per_ip": {
                // Includes only one of the fields `per_second`, `per_minute`
                "per_second": "int64",
                "per_minute": "int64"
                // end of the list of possible fields
              }
            }
          },
          "status_response": {
            "status": "Status"
          }
          // end of the list of possible fields
        },
        // end of the list of possible fields
        "route_options": {
          "modify_request_headers": [
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
          "modify_response_headers": [
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
                "and_principals": [
                  {
                    // Includes only one of the fields `header`, `remote_ip`, `any`
                    "header": {
                      "name": "string",
                      "value": {
                        // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                        "exact_match": "string",
                        "prefix_match": "string",
                        "regex_match": "string"
                        // end of the list of possible fields
                      }
                    },
                    "remote_ip": "string",
                    "any": "bool"
                    // end of the list of possible fields
                  }
                ]
              }
            ]
          },
          "security_profile_id": "string"
        },
        "disable_security_profile": "bool"
      }
    ],
    "modify_request_headers": [
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
    "modify_response_headers": [
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
    "route_options": {
      "modify_request_headers": [
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
      "modify_response_headers": [
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
            "and_principals": [
              {
                // Includes only one of the fields `header`, `remote_ip`, `any`
                "header": {
                  "name": "string",
                  "value": {
                    // Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`
                    "exact_match": "string",
                    "prefix_match": "string",
                    "regex_match": "string"
                    // end of the list of possible fields
                  }
                },
                "remote_ip": "string",
                "any": "bool"
                // end of the list of possible fields
              }
            ]
          }
        ]
      },
      "security_profile_id": "string"
    },
    "rate_limit": {
      "all_requests": {
        // Includes only one of the fields `per_second`, `per_minute`
        "per_second": "int64",
        "per_minute": "int64"
        // end of the list of possible fields
      },
      "requests_per_ip": {
        // Includes only one of the fields `per_second`, `per_minute`
        "per_second": "int64",
        "per_minute": "int64"
        // end of the list of possible fields
      }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateVirtualHostMetadata](#yandex.cloud.apploadbalancer.v1.UpdateVirtualHostMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[VirtualHost](#yandex.cloud.apploadbalancer.v1.VirtualHost)**

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

## UpdateVirtualHostMetadata {#yandex.cloud.apploadbalancer.v1.UpdateVirtualHostMetadata}

#|
||Field | Description ||
|| http_router_id | **string**

ID of the HTTP router that the virtual host is being updated in. ||
|| virtual_host_name | **string**

Name of the virtual host that is being updated. ||
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
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route2)**

Routes of the virtual host.

A route contains a set of conditions (predicates) that are used by the load balancer to select the route
for the request and an action on the request.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

The order of routes matters: the first route whose predicate matches the request is selected.
The most specific routes should be at the top of the list, so that they are not overridden.
For example, if the first HTTP route is configured, via [HttpRoute.match](#yandex.cloud.apploadbalancer.v1.HttpRoute2), to match paths prefixed with just `/`,
other routes are never matched. ||
|| modify_request_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_request_headers. ||
|| modify_response_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_response_headers. ||
|| route_options | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

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
|| route_options | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|| disable_security_profile | **bool**

Whether set to 'true' disables security profile for the route. ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute2}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction2)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction2)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|| direct_response | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction2)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `direct_response`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| http_method[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch2)**

Headers specify HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route. Headers must be unique. ||
|| query_parameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch2)**

Query Parameters specify HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route. Query parameters must be unique. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch2}

A string matcher resource.

#|
||Field | Description ||
|| exact_match | **string**

Exact match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|| prefix_match | **string**

Prefix match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|| regex_match | **string**

Regular expression match string.

Includes only one of the fields `exact_match`, `prefix_match`, `regex_match`.

Match string for either exact or prefix match. ||
|#

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch2}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP Header to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Value of HTTP Header to be matched. ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch2}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP query parameter to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Value of HTTP query parameter to be matched. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction2}

An HTTP route action resource.

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). ||
|| host_rewrite | **string**

Host replacement.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| auto_host_rewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefix_rewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefix_match](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exact_match](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

If not specified, the path is not changed.

Only one of regex_rewrite, or prefix_rewrite may be specified. ||
|| upgrade_types[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|| regex_rewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute2)**

Replacement for portions of the path that match the pattern should be rewritten,
even allowing the substitution of capture groups from the pattern into the new path as specified
by the rewrite substitution string.

Only one of regex_rewrite, or prefix_rewrite may be specified.

Examples of using:
- The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform
/service/foo/v1/api into /v1/api/instance/foo.
- The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz
into /xxx/two/yyy/two/zzz.
- The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first
occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.
- The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform
path /aaa/XxX/bbb to /aaa/yyy/bbb. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit2}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| all_requests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requests_per_ip | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| per_second | **int64**

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `per_second`, `per_minute`. ||
|| per_minute | **int64**

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `per_second`, `per_minute`. ||
|#

## RegexMatchAndSubstitute {#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute2}

#|
||Field | Description ||
|| regex | **string**

The regular expression used to find portions of a string that should be replaced. ||
|| substitute | **string**

The string that should be substituted into matching portions of the subject string during a substitution operation
to produce a new string. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction2}

A redirect action resource.

#|
||Field | Description ||
|| replace_scheme | **string**

URI scheme replacement.

If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
the port is also removed.

If not specified, the original scheme and port are used. ||
|| replace_host | **string**

URI host replacement.

If not specified, the original host is used. ||
|| replace_port | **int64**

URI host replacement.

If not specified, the original host is used. ||
|| replace_path | **string**

Replacement for the whole path.

Includes only one of the fields `replace_path`, `replace_prefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replace_prefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefix_match](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exact_match](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

Includes only one of the fields `replace_path`, `replace_prefix`.

URI path replacement.

If not specified, the original path is used. ||
|| remove_query | **bool**

Removes URI query. ||
|| response_code | enum **RedirectResponseCode**

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
|| status | **int64**

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

Includes only one of the fields `route`, `status_response`.

Action performed on the request if the route is selected. ||
|| status_response | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `status_response`.

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
|| backend_group_id | **string**

Required field. Backend group to forward requests to. ||
|| max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events etc.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration
(see `max_timeout`). ||
|| host_rewrite | **string**

Host replacement.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| auto_host_rewrite | **bool**

Automatically replaces the host with that of the target.

Includes only one of the fields `host_rewrite`, `auto_host_rewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rate_limit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2}

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

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions2}

#|
||Field | Description ||
|| modify_request_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the request headers. ||
|| modify_response_headers[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC2)** ||
|| security_profile_id | **string**

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

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC2}

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
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals2)**

Required. A match occurs when at least one matches the request. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals2}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| and_principals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal2)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal2}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher2)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remote_ip`, `any`. ||
|| remote_ip | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remote_ip`, `any`. ||
|| any | **bool**

When any is set, it matches any request.

Includes only one of the fields `header`, `remote_ip`, `any`. ||
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