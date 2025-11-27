---
editable: false
---

# Application Load Balancer Audit Trails Events: CreateVirtualHost

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.CreateVirtualHost2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    "subjectType": "string",
    "subjectId": "string",
    "subjectName": "string",
    "federationId": "string",
    "federationName": "string",
    "federationType": "string",
    "tokenInfo": {
      "maskedIamToken": "string",
      "iamTokenId": "string",
      "impersonatorId": "string",
      "impersonatorType": "string",
      "impersonatorName": "string",
      "impersonatorFederationId": "string",
      "impersonatorFederationName": "string",
      "impersonatorFederationType": "string"
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        "resourceName": "string"
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    "remotePort": "string"
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "httpRouterId": "string",
    "virtualHostName": "string",
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
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string"
                  // end of the list of possible fields
                }
              }
            ],
            "queryParameters": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string"
                  // end of the list of possible fields
                }
              }
            ]
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
            },
            "regexRewrite": {
              "regex": "string",
              "substitute": "string"
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
        },
        "disableSecurityProfile": "boolean"
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
    ]
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.CreateVirtualHost2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[Authentication](#yandex.cloud.audit.Authentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.CreateVirtualHost.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## Authentication {#yandex.cloud.audit.Authentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (SubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string**

Federation block will be filled only when subject_type = FEDERATED_USER_ACCOUNT ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.Authentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.Authentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (SubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string** ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64) ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.CreateVirtualHost.EventDetails}

#|
||Field | Description ||
|| httpRouterId | **string** ||
|| virtualHostName | **string** ||
|| authority[] | **string** ||
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route)** ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)** ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)** ||
|#

## Route {#yandex.cloud.apploadbalancer.v1.Route}

A route resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

#|
||Field | Description ||
|| name | **string**

Name of the route. ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute)**

HTTP route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute)**

gRPC route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)** ||
|| disableSecurityProfile | **boolean**

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
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch)**

Headers specify HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route. Headers must be unique.

The maximum number of elements is 32. ||
|| queryParameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch)**

Query Parameters specify HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route. Query parameters must be unique.

The maximum number of elements is 32. ||
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

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP Header to be matched.

The string length in characters must be 1-256. Value must match the regular expression ` [-0-9a-zA-Z]+ `. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP Header to be matched. ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP query parameter to be matched.

The string length in characters must be 1-256. Value must match the regular expression ` [-_0-9a-zA-Z]+ `. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP query parameter to be matched. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction}

An HTTP route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Backend group to forward requests to.

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

If not specified, the path is not changed.

Only one of regex_rewrite, or prefix_rewrite may be specified. ||
|| upgradeTypes[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|| regexRewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute)**

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

Value must be greater than 0.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

PerMinute is a limit value specified with per minute time unit.

Value must be greater than 0.

Includes only one of the fields `perSecond`, `perMinute`. ||
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

HTTP status code to use in responses.

Acceptable values are 100 to 599, inclusive. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**

Response body. ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload}

A health check payload resource.

#|
||Field | Description ||
|| text | **string**

Payload text.

The string length in characters must be greater than 0.

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

Backend group to forward requests to. ||
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

The action to take if a principal matches. Every action either allows or denies a request.

- `ALLOW`: Allows the request if and only if there is a principal that matches the request.
- `DENY`: Allows the request if and only if there are no principal that match the request. ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals)**

Required. A match occurs when at least one matches the request.

The minimum number of elements is 1. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**

Required. A match occurs when all principals match the request.

The minimum number of elements is 1. ||
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

Specifies the name of the header in the request. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Specifies how the header match will be performed to route the request.
In the absence of value a request that has specified header name will match,
regardless of the header's value. ||
|#