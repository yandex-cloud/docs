---
editable: false
---

# Application Load Balancer Audit Trails Events: StartZonalShift

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.StartZonalShift2-schema}

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
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.StartZonalShift2}

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
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.StartZonalShift.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string** ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.StartZonalShift.EventDetails}

#|
||Field | Description ||
|| loadBalancerId | **string** ||
|| listenerName | **string** ||
|| sniMatchName | **string** ||
|| loadBalancerName | **string** ||
|| status | **enum** (Status)

- `CREATING`
- `STARTING`
- `ACTIVE`
- `STOPPING`
- `STOPPED`
- `DELETING` ||
|| regionId | **string** ||
|| networkId | **string** ||
|| listeners[] | **[Listener](#yandex.cloud.apploadbalancer.v1.Listener)** ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy)** ||
|| logGroupId | **string** ||
|| securityGroupIds[] | **string** ||
|| autoScalePolicy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy)** ||
|| logOptions | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions)** ||
|#

## Listener {#yandex.cloud.apploadbalancer.v1.Listener}

#|
||Field | Description ||
|| name | **string** ||
|| endpoints[] | **[Endpoint](#yandex.cloud.apploadbalancer.v1.Endpoint)** ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**

Includes only one of the fields `http`, `tls`, `stream`. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**

Includes only one of the fields `http`, `tls`, `stream`. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**

Includes only one of the fields `http`, `tls`, `stream`. ||
|#

## Endpoint {#yandex.cloud.apploadbalancer.v1.Endpoint}

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.apploadbalancer.v1.Address)**

The number of elements must be greater than 0. ||
|| ports[] | **string** (int64)

The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive. ||
|#

## Address {#yandex.cloud.apploadbalancer.v1.Address}

#|
||Field | Description ||
|| externalIpv4Address | **[ExternalIpv4Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address)**

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`. ||
|| internalIpv4Address | **[InternalIpv4Address](#yandex.cloud.apploadbalancer.v1.InternalIpv4Address)**

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`. ||
|| externalIpv6Address | **[ExternalIpv6Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address)**

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`. ||
|#

## ExternalIpv4Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address}

#|
||Field | Description ||
|| address | **string** ||
|#

## InternalIpv4Address {#yandex.cloud.apploadbalancer.v1.InternalIpv4Address}

#|
||Field | Description ||
|| address | **string** ||
|| subnetId | **string** ||
|#

## ExternalIpv6Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address}

#|
||Field | Description ||
|| address | **string** ||
|#

## HttpListener {#yandex.cloud.apploadbalancer.v1.HttpListener}

#|
||Field | Description ||
|| handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)** ||
|| redirects | **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects)** ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler}

#|
||Field | Description ||
|| httpRouterId | **string** ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

Includes only one of the fields `http2Options`, `allowHttp10`. ||
|| allowHttp10 | **boolean**

Includes only one of the fields `http2Options`, `allowHttp10`. ||
|| rewriteRequestId | **boolean** ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

#|
||Field | Description ||
|| maxConcurrentStreams | **string** (int64) ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects}

#|
||Field | Description ||
|| httpToHttps | **boolean** ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener}

#|
||Field | Description ||
|| defaultHandler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)** ||
|| sniHandlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch)** ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

#|
||Field | Description ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

Includes only one of the fields `httpHandler`, `streamHandler`. ||
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Includes only one of the fields `httpHandler`, `streamHandler`. ||
|| certificateIds[] | **string**

The number of elements must be greater than 0. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

#|
||Field | Description ||
|| backendGroupId | **string** ||
|| idleTimeout | **string** (duration) ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

#|
||Field | Description ||
|| name | **string** ||
|| serverNames[] | **string**

The number of elements must be greater than 0. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)** ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)** ||
|#

## AllocationPolicy {#yandex.cloud.apploadbalancer.v1.AllocationPolicy}

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.apploadbalancer.v1.Location)**

The minimum number of elements is 1. ||
|#

## Location {#yandex.cloud.apploadbalancer.v1.Location}

#|
||Field | Description ||
|| zoneId | **string** ||
|| subnetId | **string** ||
|| disableTraffic | **boolean** ||
|| zonalShiftActive | **boolean** ||
|| zonalTrafficDisabled | **boolean** ||
|#

## AutoScalePolicy {#yandex.cloud.apploadbalancer.v1.AutoScalePolicy}

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| maxSize | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|#

## LogOptions {#yandex.cloud.apploadbalancer.v1.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string** ||
|| discardRules[] | **[LogDiscardRule](#yandex.cloud.apploadbalancer.v1.LogDiscardRule)** ||
|| disable | **boolean** ||
|#

## LogDiscardRule {#yandex.cloud.apploadbalancer.v1.LogDiscardRule}

#|
||Field | Description ||
|| httpCodes[] | **string** (int64)

Acceptable values are 100 to 599, inclusive. ||
|| httpCodeIntervals[] | **enum** (HttpCodeInterval)

- `HTTP_1XX`
- `HTTP_2XX`
- `HTTP_3XX`
- `HTTP_4XX`
- `HTTP_5XX`
- `HTTP_ALL` ||
|| grpcCodes[] | **enum** (Code)

- `OK`
- `CANCELLED`
- `UNKNOWN`
- `INVALID_ARGUMENT`
- `DEADLINE_EXCEEDED`
- `NOT_FOUND`
- `ALREADY_EXISTS`
- `PERMISSION_DENIED`
- `UNAUTHENTICATED`
- `RESOURCE_EXHAUSTED`
- `FAILED_PRECONDITION`
- `ABORTED`
- `OUT_OF_RANGE`
- `UNIMPLEMENTED`
- `INTERNAL`
- `UNAVAILABLE`
- `DATA_LOSS` ||
|| discardPercent | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|#