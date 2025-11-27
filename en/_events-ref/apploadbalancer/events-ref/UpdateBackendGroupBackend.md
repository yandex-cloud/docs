---
editable: false
---

# Application Load Balancer Audit Trails Events: UpdateBackendGroupBackend

## Event JSON schema {#yandex.cloud.audit.apploadbalancer.UpdateBackendGroupBackend2-schema}

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
    "backendGroupId": "string",
    "backendGroupName": "string",
    "backends": [
      {
        // Includes only one of the fields `http`, `grpc`, `stream`
        "http": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`, `storageBucket`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          "storageBucket": {
            "bucket": "string"
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          },
          "useHttp2": "boolean"
        },
        "grpc": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          }
        },
        "stream": {
          "name": "string",
          "backendWeight": "string",
          "loadBalancingConfig": {
            "panicThreshold": "string",
            "localityAwareRoutingPercent": "string",
            "strictLocality": "boolean",
            "mode": "string"
          },
          "port": "string",
          // Includes only one of the fields `targetGroups`
          "targetGroups": {
            "targetGroupIds": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "string",
              "interval": "string",
              "intervalJitterPercent": "string",
              "healthyThreshold": "string",
              "unhealthyThreshold": "string",
              "healthcheckPort": "string",
              // Includes only one of the fields `stream`, `http`, `grpc`
              "stream": {
                "send": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                },
                "receive": {
                  // Includes only one of the fields `text`
                  "text": "string"
                  // end of the list of possible fields
                }
              },
              "http": {
                "host": "string",
                "path": "string",
                "useHttp2": "boolean",
                "expectedStatuses": [
                  "string"
                ]
              },
              "grpc": {
                "serviceName": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "object",
              "tls": {
                "sni": "string",
                "validationContext": {
                  // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
                  "trustedCaId": "string",
                  "trustedCaBytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validationContext": {
              // Includes only one of the fields `trustedCaId`, `trustedCaBytes`
              "trustedCaId": "string",
              "trustedCaBytes": "string"
              // end of the list of possible fields
            }
          },
          "enableProxyProtocol": "boolean",
          "keepConnectionsOnHostHealthFailure": "boolean"
        }
        // end of the list of possible fields
      }
    ]
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.apploadbalancer.UpdateBackendGroupBackend2}

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
|| details | **[EventDetails](#yandex.cloud.audit.apploadbalancer.UpdateBackendGroupBackend.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.apploadbalancer.UpdateBackendGroupBackend.EventDetails}

#|
||Field | Description ||
|| backendGroupId | **string** ||
|| backendGroupName | **string** ||
|| backends[] | **[BackendOneOf](#yandex.cloud.audit.apploadbalancer.BackendOneOf)** ||
|#

## BackendOneOf {#yandex.cloud.audit.apploadbalancer.BackendOneOf}

#|
||Field | Description ||
|| http | **[HttpBackend](#yandex.cloud.apploadbalancer.v1.HttpBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|| grpc | **[GrpcBackend](#yandex.cloud.apploadbalancer.v1.GrpcBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|| stream | **[StreamBackend](#yandex.cloud.apploadbalancer.v1.StreamBackend)**

Includes only one of the fields `http`, `grpc`, `stream`. ||
|#

## HttpBackend {#yandex.cloud.apploadbalancer.v1.HttpBackend}

An HTTP backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend.

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic.

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `targetGroups`, `storageBucket`.

Reference to targets that belong to the backend.

A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see
[documentation](/docs/application-load-balancer/concepts/backend-group#types). ||
|| storageBucket | **[StorageBucketBackend](#yandex.cloud.apploadbalancer.v1.StorageBucketBackend)**

Object Storage bucket to use as the backend. For details about buckets, see
[documentation](/docs/storage/concepts/bucket).

If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly
accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability).

Includes only one of the fields `targetGroups`, `storageBucket`.

Reference to targets that belong to the backend.

A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see
[documentation](/docs/application-load-balancer/concepts/backend-group#types). ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets
and compares received certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls).
If not specified, the load balancer establishes unencrypted HTTP connections with targets. ||
|| useHttp2 | **boolean**

Enables HTTP/2 usage in connections between load balancer nodes and backend targets.

Default value: `false`, HTTP/1.1 is used. ||
|#

## LoadBalancingConfig {#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig}

A load balancing configuration resource.

#|
||Field | Description ||
|| panicThreshold | **string** (int64)

Threshold for panic mode.

If percentage of healthy backends in the group drops below threshold,
panic mode will be activated and traffic will be routed to all backends, regardless of their health check status.
This helps to avoid overloading healthy backends.
For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode).

If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times.

Default value: `0`.

Acceptable values are 0 to 100, inclusive. ||
|| localityAwareRoutingPercent | **string** (int64)

Percentage of traffic that a load balancer node sends to healthy backends in its availability zone.
The rest is divided equally between other zones. For details about zone-aware routing, see
[documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If there are no healthy backends in an availability zone, all the traffic is divided between other zones.

If `strictLocality` is `true`, the specified value is ignored.
A load balancer node sends all the traffic within its availability zone, regardless of backends' health.

Default value: `0`.

Acceptable values are 0 to 100, inclusive. ||
|| strictLocality | **boolean**

Specifies whether a load balancer node should only send traffic to backends in its availability zone,
regardless of their health, and ignore backends in other zones.

If set to `true` and there are no healthy backends in the zone, the node in this zone will respond
to incoming traffic with errors.
For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If `strict_locality` is `true`, the value specified in `localityAwareRoutingPercent` is ignored.

Default value: `false`. ||
|| mode | **enum** (LoadBalancingMode)

Load balancing mode for the backend.

For details about load balancing modes, see
[documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode).

- `ROUND_ROBIN`: Round robin load balancing mode.

  All endpoints of the backend take their turns to receive requests attributed to the backend.
- `RANDOM`: Random load balancing mode. Default value.

  For a request attributed to the backend, an endpoint that receives it is picked at random.
- `LEAST_REQUEST`: Least request load balancing mode.

  To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used;
that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active
requests.
- `MAGLEV_HASH`: Maglev hashing load balancing mode.

  Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies
the same amount of rows. An attribute of each request is also hashed by the same function (if session affinity is
enabled for the backend group, the attribute to hash is specified in session affinity configuration). The row
with the same number as the resulting value is looked up in the table to determine the endpoint that receives
the request.

  If the backend group with session affinity enabled contains more than one backend with positive weight, endpoints
for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead. ||
|#

## TargetGroupsBackend {#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend}

A resource for target groups that belong to the backend.

#|
||Field | Description ||
|| targetGroupIds[] | **string**

List of ID's of target groups that belong to the backend.

To get the ID's of all available target groups, make a [TargetGroupService.List] request.

The number of elements must be greater than 0. ||
|#

## StorageBucketBackend {#yandex.cloud.apploadbalancer.v1.StorageBucketBackend}

A resource for Object Storage bucket used as a backend. For details about the concept,
see [documentation](/docs/storage/concepts/bucket).

#|
||Field | Description ||
|| bucket | **string**

Name of the bucket. ||
|#

## HealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck}

A health check resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

#|
||Field | Description ||
|| timeout | **string** (duration)

Health check timeout.

The timeout is the time allowed for the target to respond to a check.
If the target doesn't respond in time, the check is considered failed. ||
|| interval | **string** (duration)

Base interval between consecutive health checks. ||
|| intervalJitterPercent | **string** ||
|| healthyThreshold | **string** (int64)

Number of consecutive successful health checks required to mark an unhealthy target as healthy.

Both `0` and `1` values amount to one successful check required.

The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.

Default value: `0`. ||
|| unhealthyThreshold | **string** (int64)

Number of consecutive failed health checks required to mark a healthy target as unhealthy.

Both `0` and `1` values amount to one unsuccessful check required.

The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target
(not applicable to TCP stream health checks). The target is immediately marked unhealthy.

Default value: `0`. ||
|| healthcheckPort | **string** (int64)

Port used for health checks.

If not specified, the backend port ([HttpBackend.port](#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.port](#yandex.cloud.apploadbalancer.v1.GrpcBackend)) is used for health checks.

Acceptable values are 0 to 65535, inclusive. ||
|| stream | **[StreamHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck)**

TCP stream health check settings.

Includes only one of the fields `stream`, `http`, `grpc`.

Protocol-specific health check settings.

The protocols of the backend and of its health check may differ,
e.g. a gRPC health check may be specified for an HTTP backend. ||
|| http | **[HttpHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck)**

HTTP health check settings.

Includes only one of the fields `stream`, `http`, `grpc`.

Protocol-specific health check settings.

The protocols of the backend and of its health check may differ,
e.g. a gRPC health check may be specified for an HTTP backend. ||
|| grpc | **[GrpcHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck)**

gRPC health check settings.

Includes only one of the fields `stream`, `http`, `grpc`.

Protocol-specific health check settings.

The protocols of the backend and of its health check may differ,
e.g. a gRPC health check may be specified for an HTTP backend. ||
|| plaintext | **object**

Includes only one of the fields `plaintext`, `tls`.

Optional transport protocol for health checks.
When not set, health checks use the same protocol as the proxied traffic.
Use this when health checks' protocol settings differ from their backend, e.g. plaintext health checks for a TLS backend. ||
|| tls | **[SecureTransportSettings](#yandex.cloud.apploadbalancer.v1.SecureTransportSettings)**

Includes only one of the fields `plaintext`, `tls`.

Optional transport protocol for health checks.
When not set, health checks use the same protocol as the proxied traffic.
Use this when health checks' protocol settings differ from their backend, e.g. plaintext health checks for a TLS backend. ||
|#

## StreamHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck}

A resource for TCP stream health check settings.

#|
||Field | Description ||
|| send | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**

Message sent to targets during TCP data transfer.

If not specified, no data is sent to the target. ||
|| receive | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**

Data that must be contained in the messages received from targets for a successful health check.

If not specified, no messages are expected from targets, and those that are received are not checked. ||
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

## HttpHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck}

A resource for HTTP health check settings.

#|
||Field | Description ||
|| host | **string**

Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. ||
|| path | **string**

HTTP path used in requests to targets: request URI for HTTP/1.1 request line
or value for the HTTP/2 `:path` pseudo-header. ||
|| useHttp2 | **boolean**

Enables HTTP/2 usage in health checks.

Default value: `false`, HTTP/1.1 is used. ||
|| expectedStatuses[] | **string** (int64)

A list of HTTP response statuses considered healthy.
By default only 200 HTTP status code considered healthy.

Acceptable values are 100 to 599, inclusive. ||
|#

## GrpcHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck}

A resource for gRPC health check settings.

#|
||Field | Description ||
|| serviceName | **string**

Name of the gRPC service to be checked.

If not specified, overall health is checked.

For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). ||
|#

## SecureTransportSettings {#yandex.cloud.apploadbalancer.v1.SecureTransportSettings}

Transport settings to be used instead of the settings configured per-cluster

#|
||Field | Description ||
|| sni | **string**

SNI string for TLS connections. ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)**

Validation context for backend TLS connections. ||
|#

## ValidationContext {#yandex.cloud.apploadbalancer.v1.ValidationContext}

A TLS validation context resource.

#|
||Field | Description ||
|| trustedCaId | **string**

Includes only one of the fields `trustedCaId`, `trustedCaBytes`.

TLS certificate issued by a trusted certificate authority (CA). ||
|| trustedCaBytes | **string**

X.509 certificate contents in PEM format.

Includes only one of the fields `trustedCaId`, `trustedCaBytes`.

TLS certificate issued by a trusted certificate authority (CA). ||
|#

## BackendTls {#yandex.cloud.apploadbalancer.v1.BackendTls}

A resource for backend TLS settings.

#|
||Field | Description ||
|| sni | **string**

Server Name Indication (SNI) string for TLS connections. ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)**

Validation context for TLS connections. ||
|#

## GrpcBackend {#yandex.cloud.apploadbalancer.v1.GrpcBackend}

A gRPC backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend.

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends of a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic.

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend.

Includes only one of the fields `targetGroups`.

Reference to targets that belong to the backend. For now, targets are referenced via target groups. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets
and compares received certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls).
If not specified, the load balancer establishes unencrypted HTTP connections with targets. ||
|#

## StreamBackend {#yandex.cloud.apploadbalancer.v1.StreamBackend}

A stream (TCP) backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend.

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic.

Acceptable values are 0 to 65535, inclusive. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `targetGroups`.

Reference to targets that belong to the backend. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes TLS-encrypted TCP connections with targets and compares received
certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls).
If not specified, the load balancer establishes unencrypted TCP connections with targets. ||
|| enableProxyProtocol | **boolean**

If set, proxy protocol will be enabled for this backend. ||
|| keepConnectionsOnHostHealthFailure | **boolean**

If a backend host becomes unhealthy (as determined by the configured health checks),
keep connections to the failed host. ||
|#