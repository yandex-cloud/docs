---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/BackendGroup/update.md
---

# Application Load Balancer API, REST: BackendGroup.Update

Updates the specified backend group.

## HTTP request

```
PATCH https://alb.{{ api-host }}/apploadbalancer/v1/backendGroups/{backendGroupId}
```

## Path parameters

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group to update.

To get the backend group ID, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.UpdateBackendGroupRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `http`, `grpc`, `stream`
  "http": {
    "backends": [
      {
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
      }
    ],
    // Includes only one of the fields `connection`, `header`, `cookie`
    "connection": {
      "sourceIp": "boolean"
    },
    "header": {
      "headerName": "string"
    },
    "cookie": {
      "name": "string",
      "ttl": "string"
    }
    // end of the list of possible fields
  },
  "grpc": {
    "backends": [
      {
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
      }
    ],
    // Includes only one of the fields `connection`, `header`, `cookie`
    "connection": {
      "sourceIp": "boolean"
    },
    "header": {
      "headerName": "string"
    },
    "cookie": {
      "name": "string",
      "ttl": "string"
    }
    // end of the list of possible fields
  },
  "stream": {
    "backends": [
      {
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
    ],
    // Includes only one of the fields `connection`
    "connection": {
      "sourceIp": "boolean"
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
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

New name for the backend group.
The name must be unique within the folder. ||
|| description | **string**

New description of the backend group. ||
|| labels | **string**

Backend group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [BackendGroupService.Get](/docs/application-load-balancer/api-ref/BackendGroup/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| http | **[HttpBackendGroup](#yandex.cloud.apploadbalancer.v1.HttpBackendGroup)**

New list of HTTP backends that the backend group will consist of.

Includes only one of the fields `http`, `grpc`, `stream`.

New list of backends in the backend group.

Existing list of backends is completely replaced by the specified list, so if you just want to add or remove
a target, make a [BackendGroupService.AddBackend](/docs/application-load-balancer/api-ref/BackendGroup/addBackend#AddBackend) request or a [BackendGroupService.RemoveBackend](/docs/application-load-balancer/api-ref/BackendGroup/removeBackend#RemoveBackend) request. ||
|| grpc | **[GrpcBackendGroup](#yandex.cloud.apploadbalancer.v1.GrpcBackendGroup)**

New list of gRPC backends that the backend group will consist of.

Includes only one of the fields `http`, `grpc`, `stream`.

New list of backends in the backend group.

Existing list of backends is completely replaced by the specified list, so if you just want to add or remove
a target, make a [BackendGroupService.AddBackend](/docs/application-load-balancer/api-ref/BackendGroup/addBackend#AddBackend) request or a [BackendGroupService.RemoveBackend](/docs/application-load-balancer/api-ref/BackendGroup/removeBackend#RemoveBackend) request. ||
|| stream | **[StreamBackendGroup](#yandex.cloud.apploadbalancer.v1.StreamBackendGroup)**

New list of stream (TCP) backends that the backend group will consist of.

Includes only one of the fields `http`, `grpc`, `stream`.

New list of backends in the backend group.

Existing list of backends is completely replaced by the specified list, so if you just want to add or remove
a target, make a [BackendGroupService.AddBackend](/docs/application-load-balancer/api-ref/BackendGroup/addBackend#AddBackend) request or a [BackendGroupService.RemoveBackend](/docs/application-load-balancer/api-ref/BackendGroup/removeBackend#RemoveBackend) request. ||
|#

## HttpBackendGroup {#yandex.cloud.apploadbalancer.v1.HttpBackendGroup}

An HTTP backend group resource.

#|
||Field | Description ||
|| backends[] | **[HttpBackend](#yandex.cloud.apploadbalancer.v1.HttpBackend)**

List of HTTP backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## HttpBackend {#yandex.cloud.apploadbalancer.v1.HttpBackend}

An HTTP backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
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

Default value: `0`. ||
|| localityAwareRoutingPercent | **string** (int64)

Percentage of traffic that a load balancer node sends to healthy backends in its availability zone.
The rest is divided equally between other zones. For details about zone-aware routing, see
[documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If there are no healthy backends in an availability zone, all the traffic is divided between other zones.

If `strictLocality` is `true`, the specified value is ignored.
A load balancer node sends all the traffic within its availability zone, regardless of backends' health.

Default value: `0`. ||
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

To get the ID's of all available target groups, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request. ||
|#

## StorageBucketBackend {#yandex.cloud.apploadbalancer.v1.StorageBucketBackend}

A resource for Object Storage bucket used as a backend. For details about the concept,
see [documentation](/docs/storage/concepts/bucket).

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket. ||
|#

## HealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck}

A health check resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

#|
||Field | Description ||
|| timeout | **string** (duration)

Required field. Health check timeout.

The timeout is the time allowed for the target to respond to a check.
If the target doesn't respond in time, the check is considered failed. ||
|| interval | **string** (duration)

Required field. Base interval between consecutive health checks. ||
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

If not specified, the backend port ([HttpBackend.port](#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.port](#yandex.cloud.apploadbalancer.v1.GrpcBackend)) is used for health checks. ||
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

Required field. HTTP path used in requests to targets: request URI for HTTP/1.1 request line
or value for the HTTP/2 `:path` pseudo-header. ||
|| useHttp2 | **boolean**

Enables HTTP/2 usage in health checks.

Default value: `false`, HTTP/1.1 is used. ||
|| expectedStatuses[] | **string** (int64)

A list of HTTP response statuses considered healthy.
By default only 200 HTTP status code considered healthy. ||
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

## ConnectionSessionAffinity {#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity}

A resource for connection-based session affinity configuration.

#|
||Field | Description ||
|| sourceIp | **boolean**

Specifies whether an IP address of the client is used to define a connection for session affinity. ||
|#

## HeaderSessionAffinity {#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity}

A resource for HTTP-header-field-based session affinity configuration.

#|
||Field | Description ||
|| headerName | **string**

Name of the HTTP header field that is used for session affinity. ||
|#

## CookieSessionAffinity {#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity}

A resource for cookie-based session affinity configuration.

#|
||Field | Description ||
|| name | **string**

Name of the cookie that is used for session affinity. ||
|| ttl | **string** (duration)

Maximum age of cookies that are generated for sessions.

If set to `0`, session cookies are used, which are stored by clients in temporary memory and are deleted
on client restarts.

If not set, the balancer does not generate cookies and only uses incoming ones for establishing session affinity. ||
|#

## GrpcBackendGroup {#yandex.cloud.apploadbalancer.v1.GrpcBackendGroup}

A gRPC backend group resource.

#|
||Field | Description ||
|| backends[] | **[GrpcBackend](#yandex.cloud.apploadbalancer.v1.GrpcBackend)**

List of gRPC backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|#

## GrpcBackend {#yandex.cloud.apploadbalancer.v1.GrpcBackend}

A gRPC backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends of a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
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

## StreamBackendGroup {#yandex.cloud.apploadbalancer.v1.StreamBackendGroup}

A stream (TCP) backend group resource.

#|
||Field | Description ||
|| backends[] | **[StreamBackend](#yandex.cloud.apploadbalancer.v1.StreamBackend)**

List of stream (TCP) backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## StreamBackend {#yandex.cloud.apploadbalancer.v1.StreamBackend}

A stream (TCP) backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
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
    "backendGroupId": "string"
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
    // Includes only one of the fields `http`, `grpc`, `stream`
    "http": {
      "backends": [
        {
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
        }
      ],
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "sourceIp": "boolean"
      },
      "header": {
        "headerName": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "string"
      }
      // end of the list of possible fields
    },
    "grpc": {
      "backends": [
        {
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
        }
      ],
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "sourceIp": "boolean"
      },
      "header": {
        "headerName": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "string"
      }
      // end of the list of possible fields
    },
    "stream": {
      "backends": [
        {
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
      ],
      // Includes only one of the fields `connection`
      "connection": {
        "sourceIp": "boolean"
      }
      // end of the list of possible fields
    },
    // end of the list of possible fields
    "createdAt": "string"
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
|| metadata | **[UpdateBackendGroupMetadata](#yandex.cloud.apploadbalancer.v1.UpdateBackendGroupMetadata)**

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
|| response | **[BackendGroup](#yandex.cloud.apploadbalancer.v1.BackendGroup)**

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

## UpdateBackendGroupMetadata {#yandex.cloud.apploadbalancer.v1.UpdateBackendGroupMetadata}

#|
||Field | Description ||
|| backendGroupId | **string**

ID of the backend group that is being updated. ||
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

## BackendGroup {#yandex.cloud.apploadbalancer.v1.BackendGroup}

A backend group resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group).

#|
||Field | Description ||
|| id | **string**

ID of the backend group. Generated at creation time. ||
|| name | **string**

Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. ||
|| description | **string**

Description of the backend group. The string is 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the backend group belongs to. ||
|| labels | **string**

Backend group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).
The maximum number of labels is 64. ||
|| http | **[HttpBackendGroup](#yandex.cloud.apploadbalancer.v1.HttpBackendGroup2)**

List of HTTP backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| grpc | **[GrpcBackendGroup](#yandex.cloud.apploadbalancer.v1.GrpcBackendGroup2)**

List of gRPC backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| stream | **[StreamBackendGroup](#yandex.cloud.apploadbalancer.v1.StreamBackendGroup2)**

List of stream (TCP) backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## HttpBackendGroup {#yandex.cloud.apploadbalancer.v1.HttpBackendGroup2}

An HTTP backend group resource.

#|
||Field | Description ||
|| backends[] | **[HttpBackend](#yandex.cloud.apploadbalancer.v1.HttpBackend2)**

List of HTTP backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity2)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend2)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity2)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend2)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity2)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend2)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## HttpBackend {#yandex.cloud.apploadbalancer.v1.HttpBackend2}

An HTTP backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig2)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `targetGroups`, `storageBucket`.

Reference to targets that belong to the backend.

A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see
[documentation](/docs/application-load-balancer/concepts/backend-group#types). ||
|| storageBucket | **[StorageBucketBackend](#yandex.cloud.apploadbalancer.v1.StorageBucketBackend2)**

Object Storage bucket to use as the backend. For details about buckets, see
[documentation](/docs/storage/concepts/bucket).

If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly
accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability).

Includes only one of the fields `targetGroups`, `storageBucket`.

Reference to targets that belong to the backend.

A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see
[documentation](/docs/application-load-balancer/concepts/backend-group#types). ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck2)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls2)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets
and compares received certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls2).
If not specified, the load balancer establishes unencrypted HTTP connections with targets. ||
|| useHttp2 | **boolean**

Enables HTTP/2 usage in connections between load balancer nodes and backend targets.

Default value: `false`, HTTP/1.1 is used. ||
|#

## LoadBalancingConfig {#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig2}

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

Default value: `0`. ||
|| localityAwareRoutingPercent | **string** (int64)

Percentage of traffic that a load balancer node sends to healthy backends in its availability zone.
The rest is divided equally between other zones. For details about zone-aware routing, see
[documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If there are no healthy backends in an availability zone, all the traffic is divided between other zones.

If `strictLocality` is `true`, the specified value is ignored.
A load balancer node sends all the traffic within its availability zone, regardless of backends' health.

Default value: `0`. ||
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

## TargetGroupsBackend {#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2}

A resource for target groups that belong to the backend.

#|
||Field | Description ||
|| targetGroupIds[] | **string**

List of ID's of target groups that belong to the backend.

To get the ID's of all available target groups, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/TargetGroup/list#List) request. ||
|#

## StorageBucketBackend {#yandex.cloud.apploadbalancer.v1.StorageBucketBackend2}

A resource for Object Storage bucket used as a backend. For details about the concept,
see [documentation](/docs/storage/concepts/bucket).

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket. ||
|#

## HealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck2}

A health check resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

#|
||Field | Description ||
|| timeout | **string** (duration)

Required field. Health check timeout.

The timeout is the time allowed for the target to respond to a check.
If the target doesn't respond in time, the check is considered failed. ||
|| interval | **string** (duration)

Required field. Base interval between consecutive health checks. ||
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

If not specified, the backend port ([HttpBackend.port](#yandex.cloud.apploadbalancer.v1.HttpBackend2) or [GrpcBackend.port](#yandex.cloud.apploadbalancer.v1.GrpcBackend)) is used for health checks. ||
|| stream | **[StreamHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck2)**

TCP stream health check settings.

Includes only one of the fields `stream`, `http`, `grpc`.

Protocol-specific health check settings.

The protocols of the backend and of its health check may differ,
e.g. a gRPC health check may be specified for an HTTP backend. ||
|| http | **[HttpHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck2)**

HTTP health check settings.

Includes only one of the fields `stream`, `http`, `grpc`.

Protocol-specific health check settings.

The protocols of the backend and of its health check may differ,
e.g. a gRPC health check may be specified for an HTTP backend. ||
|| grpc | **[GrpcHealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck2)**

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
|| tls | **[SecureTransportSettings](#yandex.cloud.apploadbalancer.v1.SecureTransportSettings2)**

Includes only one of the fields `plaintext`, `tls`.

Optional transport protocol for health checks.
When not set, health checks use the same protocol as the proxied traffic.
Use this when health checks' protocol settings differ from their backend, e.g. plaintext health checks for a TLS backend. ||
|#

## StreamHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.StreamHealthCheck2}

A resource for TCP stream health check settings.

#|
||Field | Description ||
|| send | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload2)**

Message sent to targets during TCP data transfer.

If not specified, no data is sent to the target. ||
|| receive | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload2)**

Data that must be contained in the messages received from targets for a successful health check.

If not specified, no messages are expected from targets, and those that are received are not checked. ||
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

## HttpHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.HttpHealthCheck2}

A resource for HTTP health check settings.

#|
||Field | Description ||
|| host | **string**

Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. ||
|| path | **string**

Required field. HTTP path used in requests to targets: request URI for HTTP/1.1 request line
or value for the HTTP/2 `:path` pseudo-header. ||
|| useHttp2 | **boolean**

Enables HTTP/2 usage in health checks.

Default value: `false`, HTTP/1.1 is used. ||
|| expectedStatuses[] | **string** (int64)

A list of HTTP response statuses considered healthy.
By default only 200 HTTP status code considered healthy. ||
|#

## GrpcHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck2}

A resource for gRPC health check settings.

#|
||Field | Description ||
|| serviceName | **string**

Name of the gRPC service to be checked.

If not specified, overall health is checked.

For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). ||
|#

## SecureTransportSettings {#yandex.cloud.apploadbalancer.v1.SecureTransportSettings2}

Transport settings to be used instead of the settings configured per-cluster

#|
||Field | Description ||
|| sni | **string**

SNI string for TLS connections. ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext2)**

Validation context for backend TLS connections. ||
|#

## ValidationContext {#yandex.cloud.apploadbalancer.v1.ValidationContext2}

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

## BackendTls {#yandex.cloud.apploadbalancer.v1.BackendTls2}

A resource for backend TLS settings.

#|
||Field | Description ||
|| sni | **string**

Server Name Indication (SNI) string for TLS connections. ||
|| validationContext | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext2)**

Validation context for TLS connections. ||
|#

## ConnectionSessionAffinity {#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity2}

A resource for connection-based session affinity configuration.

#|
||Field | Description ||
|| sourceIp | **boolean**

Specifies whether an IP address of the client is used to define a connection for session affinity. ||
|#

## HeaderSessionAffinity {#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity2}

A resource for HTTP-header-field-based session affinity configuration.

#|
||Field | Description ||
|| headerName | **string**

Name of the HTTP header field that is used for session affinity. ||
|#

## CookieSessionAffinity {#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity2}

A resource for cookie-based session affinity configuration.

#|
||Field | Description ||
|| name | **string**

Name of the cookie that is used for session affinity. ||
|| ttl | **string** (duration)

Maximum age of cookies that are generated for sessions.

If set to `0`, session cookies are used, which are stored by clients in temporary memory and are deleted
on client restarts.

If not set, the balancer does not generate cookies and only uses incoming ones for establishing session affinity. ||
|#

## GrpcBackendGroup {#yandex.cloud.apploadbalancer.v1.GrpcBackendGroup2}

A gRPC backend group resource.

#|
||Field | Description ||
|| backends[] | **[GrpcBackend](#yandex.cloud.apploadbalancer.v1.GrpcBackend2)**

List of gRPC backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity2)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend2)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity2)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend2)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity2)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.GrpcBackend2)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|#

## GrpcBackend {#yandex.cloud.apploadbalancer.v1.GrpcBackend2}

A gRPC backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends of a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig2)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2)**

Target groups that belong to the backend.

Includes only one of the fields `targetGroups`.

Reference to targets that belong to the backend. For now, targets are referenced via target groups. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck2)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls2)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets
and compares received certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls2).
If not specified, the load balancer establishes unencrypted HTTP connections with targets. ||
|#

## StreamBackendGroup {#yandex.cloud.apploadbalancer.v1.StreamBackendGroup2}

A stream (TCP) backend group resource.

#|
||Field | Description ||
|| backends[] | **[StreamBackend](#yandex.cloud.apploadbalancer.v1.StreamBackend2)**

List of stream (TCP) backends. ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity2)**

Connection-based session affinity configuration.

For now, a connection is defined only by an IP address of the client.

Includes only one of the fields `connection`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backendWeight](#yandex.cloud.apploadbalancer.v1.HttpBackend2)), its [HttpBackend.backendType](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backendType) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## StreamBackend {#yandex.cloud.apploadbalancer.v1.StreamBackend2}

A stream (TCP) backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend. ||
|| backendWeight | **string** (int64)

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| loadBalancingConfig | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig2)**

Load balancing configuration for the backend. ||
|| port | **string** (int64)

Port used by all targets to receive traffic. ||
|| targetGroups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend2)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `targetGroups`.

Reference to targets that belong to the backend. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck2)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls2)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes TLS-encrypted TCP connections with targets and compares received
certificates with the one specified in [BackendTls.validationContext](#yandex.cloud.apploadbalancer.v1.BackendTls2).
If not specified, the load balancer establishes unencrypted TCP connections with targets. ||
|| enableProxyProtocol | **boolean**

If set, proxy protocol will be enabled for this backend. ||
|| keepConnectionsOnHostHealthFailure | **boolean**

If a backend host becomes unhealthy (as determined by the configured health checks),
keep connections to the failed host. ||
|#