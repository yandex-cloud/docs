---
editable: false
---

# Application Load Balancer Audit Trails Events: UpdateLoadBalancerSniMatch

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.UpdateLoadBalancerSniMatch2-schema}

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
    "loadBalancerId": "string",
    "listenerName": "string",
    "sniMatchName": "string",
    "loadBalancerName": "string",
    "status": "string",
    "regionId": "string",
    "networkId": "string",
    "listeners": [
      {
        "name": "string",
        "endpoints": [
          {
            "addresses": [
              {
                // Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`
                "externalIpv4Address": {
                  "address": "string"
                },
                "internalIpv4Address": {
                  "address": "string",
                  "subnetId": "string"
                },
                "externalIpv6Address": {
                  "address": "string"
                }
                // end of the list of possible fields
              }
            ],
            "ports": [
              "string"
            ]
          }
        ],
        // Includes only one of the fields `http`, `tls`, `stream`
        "http": {
          "handler": {
            "httpRouterId": "string",
            // Includes only one of the fields `http2Options`, `allowHttp10`
            "http2Options": {
              "maxConcurrentStreams": "string"
            },
            "allowHttp10": "boolean",
            // end of the list of possible fields
            "rewriteRequestId": "boolean"
          },
          "redirects": {
            "httpToHttps": "boolean"
          }
        },
        "tls": {
          "defaultHandler": {
            // Includes only one of the fields `httpHandler`, `streamHandler`
            "httpHandler": {
              "httpRouterId": "string",
              // Includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": "boolean",
              // end of the list of possible fields
              "rewriteRequestId": "boolean"
            },
            "streamHandler": {
              "backendGroupId": "string",
              "idleTimeout": "string"
            },
            // end of the list of possible fields
            "certificateIds": [
              "string"
            ]
          },
          "sniHandlers": [
            {
              "name": "string",
              "serverNames": [
                "string"
              ],
              "handler": {
                // Includes only one of the fields `httpHandler`, `streamHandler`
                "httpHandler": {
                  "httpRouterId": "string",
                  // Includes only one of the fields `http2Options`, `allowHttp10`
                  "http2Options": {
                    "maxConcurrentStreams": "string"
                  },
                  "allowHttp10": "boolean",
                  // end of the list of possible fields
                  "rewriteRequestId": "boolean"
                },
                "streamHandler": {
                  "backendGroupId": "string",
                  "idleTimeout": "string"
                },
                // end of the list of possible fields
                "certificateIds": [
                  "string"
                ]
              }
            }
          ]
        },
        "stream": {
          "handler": {
            "backendGroupId": "string",
            "idleTimeout": "string"
          }
        }
        // end of the list of possible fields
      }
    ],
    "allocationPolicy": {
      "locations": [
        {
          "zoneId": "string",
          "subnetId": "string",
          "disableTraffic": "boolean",
          "zonalShiftActive": "boolean",
          "zonalTrafficDisabled": "boolean"
        }
      ]
    },
    "logGroupId": "string",
    "securityGroupIds": [
      "string"
    ],
    "autoScalePolicy": {
      "minZoneSize": "string",
      "maxSize": "string"
    },
    "logOptions": {
      "logGroupId": "string",
      "discardRules": [
        {
          "httpCodes": [
            "string"
          ],
          "httpCodeIntervals": [
            "string"
          ],
          "grpcCodes": [
            "string"
          ],
          "discardPercent": "string"
        }
      ],
      "disable": "boolean"
    },
    "securityGroups": [
      {
        "securityGroupId": "string",
        "securityGroupName": "string"
      }
    ]
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.UpdateLoadBalancerSniMatch2}

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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.UpdateLoadBalancerSniMatch.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.UpdateLoadBalancerSniMatch.EventDetails}

#|
||Field | Description ||
|| loadBalancerId | **string** ||
|| listenerName | **string** ||
|| sniMatchName | **string** ||
|| loadBalancerName | **string** ||
|| status | **enum** (Status)

- `CREATING`: The application load balancer is being created.
- `STARTING`: The application load balancer is being started.
- `ACTIVE`: The application load balancer is active and sends traffic to the targets.
- `STOPPING`: The application load balancer is being stopped.
- `STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.
- `DELETING`: The application load balancer is being deleted. ||
|| regionId | **string** ||
|| networkId | **string** ||
|| listeners[] | **[Listener](#yandex.cloud.apploadbalancer.v1.Listener)** ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy)** ||
|| logGroupId | **string** ||
|| securityGroupIds[] | **string** ||
|| autoScalePolicy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy)** ||
|| logOptions | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions)** ||
|| securityGroups[] | **[SecurityGroupInfo](#yandex.cloud.audit.SecurityGroupInfo)** ||
|#

## Listener {#yandex.cloud.apploadbalancer.v1.Listener}

A listener resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener).

#|
||Field | Description ||
|| name | **string**

Name of the listener. The name is unique within the application load balancer.
The string length in characters is 3-63. ||
|| endpoints[] | **[Endpoint](#yandex.cloud.apploadbalancer.v1.Endpoint)**

Endpoints of the listener.

Endpoints are defined by their IP addresses and ports. ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**

Unencrypted HTTP listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**

TLS-encrypted HTTP or TCP stream listener settings.

All handlers within a listener ([TlsListener.defaultHandler](#yandex.cloud.apploadbalancer.v1.TlsListener) and [TlsListener.sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**

Unencrypted stream (TCP) listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|#

## Endpoint {#yandex.cloud.apploadbalancer.v1.Endpoint}

An endpoint resource.

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.apploadbalancer.v1.Address)**

Endpoint public (external) and internal addresses.

The number of elements must be greater than 0. ||
|| ports[] | **string** (int64)

Endpoint ports.

The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive. ||
|#

## Address {#yandex.cloud.apploadbalancer.v1.Address}

An endpoint address resource.

#|
||Field | Description ||
|| externalIpv4Address | **[ExternalIpv4Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address)**

Public IPv4 endpoint address.

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internalIpv4Address | **[InternalIpv4Address](#yandex.cloud.apploadbalancer.v1.InternalIpv4Address)**

Internal IPv4 endpoint address.

To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| externalIpv6Address | **[ExternalIpv6Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address)**

Public IPv6 endpoint address.

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|#

## ExternalIpv4Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address}

A public (external) IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|#

## InternalIpv4Address {#yandex.cloud.apploadbalancer.v1.InternalIpv4Address}

An internal IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|| subnetId | **string**

ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address}

A public (external) IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv6 address. ||
|#

## HttpListener {#yandex.cloud.apploadbalancer.v1.HttpListener}

An HTTP listener resource.

#|
||Field | Description ||
|| handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

Settings for handling HTTP requests.

Only one of `handler` and `redirects` can be specified. ||
|| redirects | **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects)**

Redirects settings.

Only one of `redirects` and `handler` can be specified. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler}

An HTTP handler resource.

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List] request. ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allowHttp10 | **boolean**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewriteRequestId | **boolean**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| maxConcurrentStreams | **string** (int64)

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects}

A listener redirects resource.

#|
||Field | Description ||
|| httpToHttps | **boolean**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.

The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replaceScheme](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener}

TLS-encrypted (HTTP or TCP stream) listener resource.

#|
||Field | Description ||
|| defaultHandler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Settings for handling requests by default, with Server Name
Indication (SNI) not matching any of the `sniHandlers`. ||
|| sniHandlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch)**

Settings for handling requests with Server Name Indication (SNI)
matching one of [SniMatch.serverNames](#yandex.cloud.apploadbalancer.v1.SniMatch) values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| certificateIds[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used.

The number of elements must be greater than 0. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List] request. ||
|| idleTimeout | **string** (duration)

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Name of the SNI handler. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler.

The number of elements must be greater than 0. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Settings for handling stream (TCP) requests. ||
|#

## AllocationPolicy {#yandex.cloud.apploadbalancer.v1.AllocationPolicy}

A locality settings (allocation policy) resource.

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.apploadbalancer.v1.Location)**

Availability zones and subnets that the application load balancer resides.

The minimum number of elements is 1. ||
|#

## Location {#yandex.cloud.apploadbalancer.v1.Location}

An application load balancer location resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location).

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the application load balancer resides.

Each availability zone can only be specified once. ||
|| subnetId | **string**

ID of the subnet that the application load balancer belongs to. ||
|| disableTraffic | **boolean**

Disables the load balancer node in the specified availability zone.

Backends in the availability zone are not directly affected by this setting.
They still may receive traffic from the load balancer nodes in other availability zones,
subject to [LoadBalancingConfig.localityAwareRoutingPercent](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) and [LoadBalancingConfig.strictLocality](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) settings. ||
|| zonalShiftActive | **boolean**

Show zonal shift status for the location.
Deprecated: use `zonalTrafficDisabled` below to track traffic status. ||
|| zonalTrafficDisabled | **boolean**

Computed field: will be set to true if all traffic in zone is disabled
either manually by user or automatically by Cloud infrastructure. ||
|#

## AutoScalePolicy {#yandex.cloud.apploadbalancer.v1.AutoScalePolicy}

A resource for scaling settings of an application load balancer.

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Lower limit for the number of resource units in each availability zone.

If not specified previously (using other instruments such as management console), the default value is 2.
To revert to it, specify it explicitly.

The minimum value is 2.

Acceptable values are 0 to 1000, inclusive. ||
|| maxSize | **string** (int64)

Upper limit for the total number of resource units across all availability zones.

If a positive value is specified, it must be at least `minZoneSize` multiplied by the size of
[AllocationPolicy.locations](#yandex.cloud.apploadbalancer.v1.AllocationPolicy).

If the value is 0, there is no upper limit.

Acceptable values are 0 to 1000, inclusive. ||
|#

## LogOptions {#yandex.cloud.apploadbalancer.v1.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

Cloud Logging log group ID to store access logs.
If not set then logs will be stored in default log group for the folder
where load balancer located. ||
|| discardRules[] | **[LogDiscardRule](#yandex.cloud.apploadbalancer.v1.LogDiscardRule)**

ordered list of rules, first matching rule applies ||
|| disable | **boolean**

Do not send logs to Cloud Logging log group. ||
|#

## LogDiscardRule {#yandex.cloud.apploadbalancer.v1.LogDiscardRule}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| httpCodes[] | **string** (int64)

HTTP codes that should be discarded.

Acceptable values are 100 to 599, inclusive. ||
|| httpCodeIntervals[] | **enum** (HttpCodeInterval)

Groups of HTTP codes like 4xx that should be discarded.

- `HTTP_1XX`
- `HTTP_2XX`
- `HTTP_3XX`
- `HTTP_4XX`
- `HTTP_5XX`
- `HTTP_ALL` ||
|| grpcCodes[] | **enum** (Code)

GRPC codes that should be discarded

- `OK`: Not an error; returned on success

  HTTP Mapping: 200 OK
- `CANCELLED`: The operation was cancelled, typically by the caller.

  HTTP Mapping: 499 Client Closed Request
- `UNKNOWN`: Unknown error.  For example, this error may be returned when
a `Status` value received from another address space belongs to
an error space that is not known in this address space.  Also
errors raised by APIs that do not return enough error information
may be converted to this error.

  HTTP Mapping: 500 Internal Server Error
- `INVALID_ARGUMENT`: The client specified an invalid argument.  Note that this differs
from `FAILED_PRECONDITION`.  `INVALID_ARGUMENT` indicates arguments
that are problematic regardless of the state of the system
(e.g., a malformed file name).

  HTTP Mapping: 400 Bad Request
- `DEADLINE_EXCEEDED`: The deadline expired before the operation could complete. For operations
that change the state of the system, this error may be returned
even if the operation has completed successfully.  For example, a
successful response from a server could have been delayed long
enough for the deadline to expire.

  HTTP Mapping: 504 Gateway Timeout
- `NOT_FOUND`: Some requested entity (e.g., file or directory) was not found.

  Note to server developers: if a request is denied for an entire class
of users, such as gradual feature rollout or undocumented whitelist,
`NOT_FOUND` may be used. If a request is denied for some users within
a class of users, such as user-based access control, `PERMISSION_DENIED`
must be used.

  HTTP Mapping: 404 Not Found
- `ALREADY_EXISTS`: The entity that a client attempted to create (e.g., file or directory)
already exists.

  HTTP Mapping: 409 Conflict
- `PERMISSION_DENIED`: The caller does not have permission to execute the specified
operation. `PERMISSION_DENIED` must not be used for rejections
caused by exhausting some resource (use `RESOURCE_EXHAUSTED`
instead for those errors). `PERMISSION_DENIED` must not be
used if the caller can not be identified (use `UNAUTHENTICATED`
instead for those errors). This error code does not imply the
request is valid or the requested entity exists or satisfies
other pre-conditions.

  HTTP Mapping: 403 Forbidden
- `UNAUTHENTICATED`: The request does not have valid authentication credentials for the
operation.

  HTTP Mapping: 401 Unauthorized
- `RESOURCE_EXHAUSTED`: Some resource has been exhausted, perhaps a per-user quota, or
perhaps the entire file system is out of space.

  HTTP Mapping: 429 Too Many Requests
- `FAILED_PRECONDITION`: The operation was rejected because the system is not in a state
required for the operation's execution.  For example, the directory
to be deleted is non-empty, an rmdir operation is applied to
a non-directory, etc.

  Service implementors can use the following guidelines to decide
between `FAILED_PRECONDITION`, `ABORTED`, and `UNAVAILABLE`:
(a) Use `UNAVAILABLE` if the client can retry just the failing call.
(b) Use `ABORTED` if the client should retry at a higher level
(e.g., when a client-specified test-and-set fails, indicating the
client should restart a read-modify-write sequence).
(c) Use `FAILED_PRECONDITION` if the client should not retry until
the system state has been explicitly fixed.  E.g., if an "rmdir"
fails because the directory is non-empty, `FAILED_PRECONDITION`
should be returned since the client should not retry unless
the files are deleted from the directory.

  HTTP Mapping: 400 Bad Request
- `ABORTED`: The operation was aborted, typically due to a concurrency issue such as
a sequencer check failure or transaction abort.

  See the guidelines above for deciding between `FAILED_PRECONDITION`,
`ABORTED`, and `UNAVAILABLE`.

  HTTP Mapping: 409 Conflict
- `OUT_OF_RANGE`: The operation was attempted past the valid range.  E.g., seeking or
reading past end-of-file.

  Unlike `INVALID_ARGUMENT`, this error indicates a problem that may
be fixed if the system state changes. For example, a 32-bit file
system will generate `INVALID_ARGUMENT` if asked to read at an
offset that is not in the range [0,2^32-1], but it will generate
`OUT_OF_RANGE` if asked to read from an offset past the current
file size.

  There is a fair bit of overlap between `FAILED_PRECONDITION` and
`OUT_OF_RANGE`.  We recommend using `OUT_OF_RANGE` (the more specific
error) when it applies so that callers who are iterating through
a space can easily look for an `OUT_OF_RANGE` error to detect when
they are done.

  HTTP Mapping: 400 Bad Request
- `UNIMPLEMENTED`: The operation is not implemented or is not supported/enabled in this
service.

  HTTP Mapping: 501 Not Implemented
- `INTERNAL`: Internal errors.  This means that some invariants expected by the
underlying system have been broken.  This error code is reserved
for serious errors.

  HTTP Mapping: 500 Internal Server Error
- `UNAVAILABLE`: The service is currently unavailable.  This is most likely a
transient condition, which can be corrected by retrying with
a backoff.

  See the guidelines above for deciding between `FAILED_PRECONDITION`,
`ABORTED`, and `UNAVAILABLE`.

  HTTP Mapping: 503 Service Unavailable
- `DATA_LOSS`: Unrecoverable data loss or corruption.

  HTTP Mapping: 500 Internal Server Error ||
|| discardPercent | **string** (int64)

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all

Acceptable values are 0 to 100, inclusive. ||
|#

## SecurityGroupInfo {#yandex.cloud.audit.SecurityGroupInfo}

#|
||Field | Description ||
|| securityGroupId | **string** ||
|| securityGroupName | **string** ||
|#