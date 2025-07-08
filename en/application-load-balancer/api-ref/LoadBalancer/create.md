---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/LoadBalancer/create.md
---

# Application Load Balancer API, REST: LoadBalancer.Create

Creates an application load balancer in the specified folder.

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers
```

## Body parameters {#yandex.cloud.apploadbalancer.v1.CreateLoadBalancerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "networkId": "string",
  "listenerSpecs": [
    {
      "name": "string",
      "endpointSpecs": [
        {
          "addressSpecs": [
            {
              // Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`
              "externalIpv4AddressSpec": {
                "address": "string"
              },
              "internalIpv4AddressSpec": {
                "address": "string",
                "subnetId": "string"
              },
              "externalIpv6AddressSpec": {
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
  "allowZonalShift": "boolean"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create an application load balancer in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the application load balancer.
The name must be unique within the folder. ||
|| description | **string**

Description of the application load balancer. ||
|| labels | **object** (map<**string**, **string**>)

Application load balancer labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| regionId | **string**

Required field. ID of the region that the application load balancer is located at.

The only supported value is `ru-central1`. ||
|| networkId | **string**

Required field. ID of the network that the application load balancer belongs to. ||
|| listenerSpecs[] | **[ListenerSpec](#yandex.cloud.apploadbalancer.v1.ListenerSpec)**

Listeners that belong to the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy)**

Locality settings of the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). ||
|| securityGroupIds[] | **string**

ID's of the security groups attributed to the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). ||
|| autoScalePolicy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy)**

Scaling settings of the application load balancer.

The scaling settings relate to a special internal instance group which facilitates the balancer's work.
Instances in this group are called _resource units_. The group is scaled automatically based on incoming load
and within limitations specified in these settings.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling). ||
|| logOptions | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions)**

Cloud logging settings of the application load balancer. ||
|| allowZonalShift | **boolean**

Specifies whether application load balancer is available to zonal shift. ||
|#

## ListenerSpec {#yandex.cloud.apploadbalancer.v1.ListenerSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the listener. The name is unique within the application load balancer. ||
|| endpointSpecs[] | **[EndpointSpec](#yandex.cloud.apploadbalancer.v1.EndpointSpec)**

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

## EndpointSpec {#yandex.cloud.apploadbalancer.v1.EndpointSpec}

#|
||Field | Description ||
|| addressSpecs[] | **[AddressSpec](#yandex.cloud.apploadbalancer.v1.AddressSpec)**

Endpoint public (external) and internal addresses. ||
|| ports[] | **string** (int64)

Endpoint ports. ||
|#

## AddressSpec {#yandex.cloud.apploadbalancer.v1.AddressSpec}

#|
||Field | Description ||
|| externalIpv4AddressSpec | **[ExternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec)**

Public IPv4 endpoint address.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internalIpv4AddressSpec | **[InternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec)**

Internal IPv4 endpoint address.

To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| externalIpv6AddressSpec | **[ExternalIpv6AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec)**

Public IPv6 endpoint address.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|#

## ExternalIpv4AddressSpec {#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|| subnetId | **string**

ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6AddressSpec {#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec}

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

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
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

Required field. Settings for handling requests by default, with Server Name
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

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request. ||
|| idleTimeout | **string** (duration)

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Required field. Settings for handling stream (TCP) requests. ||
|#

## AllocationPolicy {#yandex.cloud.apploadbalancer.v1.AllocationPolicy}

A locality settings (allocation policy) resource.

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.apploadbalancer.v1.Location)**

Availability zones and subnets that the application load balancer resides. ||
|#

## Location {#yandex.cloud.apploadbalancer.v1.Location}

An application load balancer location resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location).

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the application load balancer resides.

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

The minimum value is 2. ||
|| maxSize | **string** (int64)

Upper limit for the total number of resource units across all availability zones.

If a positive value is specified, it must be at least `minZoneSize` multiplied by the size of
[AllocationPolicy.locations](#yandex.cloud.apploadbalancer.v1.AllocationPolicy).

If the value is 0, there is no upper limit. ||
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

HTTP codes that should be discarded. ||
|| httpCodeIntervals[] | **enum** (HttpCodeInterval)

Groups of HTTP codes like 4xx that should be discarded.

- `HTTP_CODE_INTERVAL_UNSPECIFIED`
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

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all ||
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
    "loadBalancerId": "string"
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
    "labels": "object",
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
    "createdAt": "string",
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
    "allowZonalShift": "boolean"
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
|| metadata | **[CreateLoadBalancerMetadata](#yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata)**

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
|| response | **[LoadBalancer](#yandex.cloud.apploadbalancer.v1.LoadBalancer)**

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

## CreateLoadBalancerMetadata {#yandex.cloud.apploadbalancer.v1.CreateLoadBalancerMetadata}

#|
||Field | Description ||
|| loadBalancerId | **string**

ID of the application load balancer that is being created. ||
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

## LoadBalancer {#yandex.cloud.apploadbalancer.v1.LoadBalancer}

An application load balancer resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer).

#|
||Field | Description ||
|| id | **string**

ID of the application load balancer. Generated at creation time. ||
|| name | **string**

Name of the application load balancer. The name is unique within the folder. ||
|| description | **string**

Description of the application load balancer. ||
|| folderId | **string**

ID of the folder that the application load balancer belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Application load balancer labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| status | **enum** (Status)

Status of the application load balancer.

- `STATUS_UNSPECIFIED`
- `CREATING`: The application load balancer is being created.
- `STARTING`: The application load balancer is being started.
- `ACTIVE`: The application load balancer is active and sends traffic to the targets.
- `STOPPING`: The application load balancer is being stopped.
- `STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.
- `DELETING`: The application load balancer is being deleted. ||
|| regionId | **string**

ID of the region that the application load balancer is located at. ||
|| networkId | **string**

ID of the network that the application load balancer belongs to. ||
|| listeners[] | **[Listener](#yandex.cloud.apploadbalancer.v1.Listener)**

Listeners that belong to the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy2)**

Locality settings of the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). ||
|| logGroupId | **string**

ID of the log group that stores access logs of the application load balancer.

The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloud-logging-trigger-create). ||
|| securityGroupIds[] | **string**

ID's of the security groups attributed to the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| autoScalePolicy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy2)**

Scaling settings of the application load balancer.

The scaling settings relate to a special internal instance group which facilitates the balancer's work.
Instances in this group are called _resource units_. The group is scaled automatically based on incoming load
and within limitations specified in these settings.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling). ||
|| logOptions | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions2)**

Cloud logging settings of the application load balancer. ||
|| allowZonalShift | **boolean**

Specifies whether application load balancer is available to zonal shift. ||
|#

## Listener {#yandex.cloud.apploadbalancer.v1.Listener}

A listener resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the listener. The name is unique within the application load balancer.
The string length in characters is 3-63. ||
|| endpoints[] | **[Endpoint](#yandex.cloud.apploadbalancer.v1.Endpoint)**

Endpoints of the listener.

Endpoints are defined by their IP addresses and ports. ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener2)**

Unencrypted HTTP listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener2)**

TLS-encrypted HTTP or TCP stream listener settings.

All handlers within a listener ([TlsListener.defaultHandler](#yandex.cloud.apploadbalancer.v1.TlsListener2) and [TlsListener.sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener2)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener2)**

Unencrypted stream (TCP) listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|#

## Endpoint {#yandex.cloud.apploadbalancer.v1.Endpoint}

An endpoint resource.

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.apploadbalancer.v1.Address)**

Endpoint public (external) and internal addresses. ||
|| ports[] | **string** (int64)

Endpoint ports. ||
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

## HttpListener {#yandex.cloud.apploadbalancer.v1.HttpListener2}

An HTTP listener resource.

#|
||Field | Description ||
|| handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2)**

Settings for handling HTTP requests.

Only one of `handler` and `redirects` can be specified. ||
|| redirects | **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects2)**

Redirects settings.

Only one of `redirects` and `handler` can be specified. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler2}

An HTTP handler resource.

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options2)**

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

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options2}

An HTTP/2 options resource.

#|
||Field | Description ||
|| maxConcurrentStreams | **string** (int64)

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects2}

A listener redirects resource.

#|
||Field | Description ||
|| httpToHttps | **boolean**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.

The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replaceScheme](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener2}

TLS-encrypted (HTTP or TCP stream) listener resource.

#|
||Field | Description ||
|| defaultHandler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler2)**

Required field. Settings for handling requests by default, with Server Name
Indication (SNI) not matching any of the `sniHandlers`. ||
|| sniHandlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch2)**

Settings for handling requests with Server Name Indication (SNI)
matching one of [SniMatch.serverNames](#yandex.cloud.apploadbalancer.v1.SniMatch2) values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler2}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2)**

HTTP handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2)**

Stream (TCP) handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| certificateIds[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler2}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request. ||
|| idleTimeout | **string** (duration)

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch2}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler2)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener2}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2)**

Required field. Settings for handling stream (TCP) requests. ||
|#

## AllocationPolicy {#yandex.cloud.apploadbalancer.v1.AllocationPolicy2}

A locality settings (allocation policy) resource.

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.apploadbalancer.v1.Location2)**

Availability zones and subnets that the application load balancer resides. ||
|#

## Location {#yandex.cloud.apploadbalancer.v1.Location2}

An application load balancer location resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location).

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the application load balancer resides.

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

## AutoScalePolicy {#yandex.cloud.apploadbalancer.v1.AutoScalePolicy2}

A resource for scaling settings of an application load balancer.

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Lower limit for the number of resource units in each availability zone.

If not specified previously (using other instruments such as management console), the default value is 2.
To revert to it, specify it explicitly.

The minimum value is 2. ||
|| maxSize | **string** (int64)

Upper limit for the total number of resource units across all availability zones.

If a positive value is specified, it must be at least `minZoneSize` multiplied by the size of
[AllocationPolicy.locations](#yandex.cloud.apploadbalancer.v1.AllocationPolicy2).

If the value is 0, there is no upper limit. ||
|#

## LogOptions {#yandex.cloud.apploadbalancer.v1.LogOptions2}

#|
||Field | Description ||
|| logGroupId | **string**

Cloud Logging log group ID to store access logs.
If not set then logs will be stored in default log group for the folder
where load balancer located. ||
|| discardRules[] | **[LogDiscardRule](#yandex.cloud.apploadbalancer.v1.LogDiscardRule2)**

ordered list of rules, first matching rule applies ||
|| disable | **boolean**

Do not send logs to Cloud Logging log group. ||
|#

## LogDiscardRule {#yandex.cloud.apploadbalancer.v1.LogDiscardRule2}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| httpCodes[] | **string** (int64)

HTTP codes that should be discarded. ||
|| httpCodeIntervals[] | **enum** (HttpCodeInterval)

Groups of HTTP codes like 4xx that should be discarded.

- `HTTP_CODE_INTERVAL_UNSPECIFIED`
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

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all ||
|#