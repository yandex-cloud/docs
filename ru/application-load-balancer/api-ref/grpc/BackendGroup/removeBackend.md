---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/BackendGroup/removeBackend.md
---

# Application Load Balancer API, gRPC: BackendGroupService.RemoveBackend

Removes backends from the specified backend group.

## gRPC request

**rpc RemoveBackend ([RemoveBackendRequest](#yandex.cloud.apploadbalancer.v1.RemoveBackendRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RemoveBackendRequest {#yandex.cloud.apploadbalancer.v1.RemoveBackendRequest}

```json
{
  "backend_group_id": "string",
  "backend_name": "string"
}
```

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. ID of the backend group to remove a backend from.

To get the backend group ID, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/grpc/BackendGroup/list#List) request. ||
|| backend_name | **string**

Required field. Name of the backend to remove.

To get the backend name, make a [BackendGroupService.Get](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#Get) request. ||
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
    "backend_group_id": "string",
    "backend_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folder_id": "string",
    "labels": "map<string, string>",
    // Includes only one of the fields `http`, `grpc`, `stream`
    "http": {
      "backends": [
        {
          "name": "string",
          "backend_weight": "google.protobuf.Int64Value",
          "load_balancing_config": {
            "panic_threshold": "int64",
            "locality_aware_routing_percent": "int64",
            "strict_locality": "bool",
            "mode": "LoadBalancingMode"
          },
          "port": "int64",
          // Includes only one of the fields `target_groups`, `storage_bucket`
          "target_groups": {
            "target_group_ids": [
              "string"
            ]
          },
          "storage_bucket": {
            "bucket": "string"
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "google.protobuf.Duration",
              "interval": "google.protobuf.Duration",
              "interval_jitter_percent": "double",
              "healthy_threshold": "int64",
              "unhealthy_threshold": "int64",
              "healthcheck_port": "int64",
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
                "use_http2": "bool",
                "expected_statuses": [
                  "int64"
                ]
              },
              "grpc": {
                "service_name": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "PlaintextTransportSettings",
              "tls": {
                "sni": "string",
                "validation_context": {
                  // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
                  "trusted_ca_id": "string",
                  "trusted_ca_bytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validation_context": {
              // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
              "trusted_ca_id": "string",
              "trusted_ca_bytes": "string"
              // end of the list of possible fields
            }
          },
          "use_http2": "bool"
        }
      ],
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "source_ip": "bool"
      },
      "header": {
        "header_name": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "google.protobuf.Duration"
      }
      // end of the list of possible fields
    },
    "grpc": {
      "backends": [
        {
          "name": "string",
          "backend_weight": "google.protobuf.Int64Value",
          "load_balancing_config": {
            "panic_threshold": "int64",
            "locality_aware_routing_percent": "int64",
            "strict_locality": "bool",
            "mode": "LoadBalancingMode"
          },
          "port": "int64",
          // Includes only one of the fields `target_groups`
          "target_groups": {
            "target_group_ids": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "google.protobuf.Duration",
              "interval": "google.protobuf.Duration",
              "interval_jitter_percent": "double",
              "healthy_threshold": "int64",
              "unhealthy_threshold": "int64",
              "healthcheck_port": "int64",
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
                "use_http2": "bool",
                "expected_statuses": [
                  "int64"
                ]
              },
              "grpc": {
                "service_name": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "PlaintextTransportSettings",
              "tls": {
                "sni": "string",
                "validation_context": {
                  // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
                  "trusted_ca_id": "string",
                  "trusted_ca_bytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validation_context": {
              // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
              "trusted_ca_id": "string",
              "trusted_ca_bytes": "string"
              // end of the list of possible fields
            }
          }
        }
      ],
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "source_ip": "bool"
      },
      "header": {
        "header_name": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "google.protobuf.Duration"
      }
      // end of the list of possible fields
    },
    "stream": {
      "backends": [
        {
          "name": "string",
          "backend_weight": "google.protobuf.Int64Value",
          "load_balancing_config": {
            "panic_threshold": "int64",
            "locality_aware_routing_percent": "int64",
            "strict_locality": "bool",
            "mode": "LoadBalancingMode"
          },
          "port": "int64",
          // Includes only one of the fields `target_groups`
          "target_groups": {
            "target_group_ids": [
              "string"
            ]
          },
          // end of the list of possible fields
          "healthchecks": [
            {
              "timeout": "google.protobuf.Duration",
              "interval": "google.protobuf.Duration",
              "interval_jitter_percent": "double",
              "healthy_threshold": "int64",
              "unhealthy_threshold": "int64",
              "healthcheck_port": "int64",
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
                "use_http2": "bool",
                "expected_statuses": [
                  "int64"
                ]
              },
              "grpc": {
                "service_name": "string"
              },
              // end of the list of possible fields
              // Includes only one of the fields `plaintext`, `tls`
              "plaintext": "PlaintextTransportSettings",
              "tls": {
                "sni": "string",
                "validation_context": {
                  // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
                  "trusted_ca_id": "string",
                  "trusted_ca_bytes": "string"
                  // end of the list of possible fields
                }
              }
              // end of the list of possible fields
            }
          ],
          "tls": {
            "sni": "string",
            "validation_context": {
              // Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`
              "trusted_ca_id": "string",
              "trusted_ca_bytes": "string"
              // end of the list of possible fields
            }
          },
          "enable_proxy_protocol": "bool",
          "keep_connections_on_host_health_failure": "bool"
        }
      ],
      // Includes only one of the fields `connection`
      "connection": {
        "source_ip": "bool"
      }
      // end of the list of possible fields
    },
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp"
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
|| metadata | **[RemoveBackendMetadata](#yandex.cloud.apploadbalancer.v1.RemoveBackendMetadata)**

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

## RemoveBackendMetadata {#yandex.cloud.apploadbalancer.v1.RemoveBackendMetadata}

#|
||Field | Description ||
|| backend_group_id | **string**

ID of the backend group that the backend is being removed from. ||
|| backend_name | **string**

Name of the backend that is being removed. ||
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
|| folder_id | **string**

ID of the folder that the backend group belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Backend group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).
The maximum number of labels is 64. ||
|| http | **[HttpBackendGroup](#yandex.cloud.apploadbalancer.v1.HttpBackendGroup)**

List of HTTP backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| grpc | **[GrpcBackendGroup](#yandex.cloud.apploadbalancer.v1.GrpcBackendGroup)**

List of gRPC backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| stream | **[StreamBackendGroup](#yandex.cloud.apploadbalancer.v1.StreamBackendGroup)**

List of stream (TCP) backends that the backend group consists of.

Includes only one of the fields `http`, `grpc`, `stream`.

Backends that the backend group consists of. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
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
[HttpBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backend_type](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backend_type) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backend_type](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backend_type) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[HttpBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backend_type](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backend_type) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## HttpBackend {#yandex.cloud.apploadbalancer.v1.HttpBackend}

An HTTP backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| load_balancing_config | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **int64**

Port used by all targets to receive traffic. ||
|| target_groups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `target_groups`, `storage_bucket`.

Reference to targets that belong to the backend.

A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see
[documentation](/docs/application-load-balancer/concepts/backend-group#types). ||
|| storage_bucket | **[StorageBucketBackend](#yandex.cloud.apploadbalancer.v1.StorageBucketBackend)**

Object Storage bucket to use as the backend. For details about buckets, see
[documentation](/docs/storage/concepts/bucket).

If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly
accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability).

Includes only one of the fields `target_groups`, `storage_bucket`.

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
and compares received certificates with the one specified in [BackendTls.validation_context](#yandex.cloud.apploadbalancer.v1.BackendTls).
If not specified, the load balancer establishes unencrypted HTTP connections with targets. ||
|| use_http2 | **bool**

Enables HTTP/2 usage in connections between load balancer nodes and backend targets.

Default value: `false`, HTTP/1.1 is used. ||
|#

## LoadBalancingConfig {#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig}

A load balancing configuration resource.

#|
||Field | Description ||
|| panic_threshold | **int64**

Threshold for panic mode.

If percentage of healthy backends in the group drops below threshold,
panic mode will be activated and traffic will be routed to all backends, regardless of their health check status.
This helps to avoid overloading healthy backends.
For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode).

If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times.

Default value: `0`. ||
|| locality_aware_routing_percent | **int64**

Percentage of traffic that a load balancer node sends to healthy backends in its availability zone.
The rest is divided equally between other zones. For details about zone-aware routing, see
[documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If there are no healthy backends in an availability zone, all the traffic is divided between other zones.

If `strict_locality` is `true`, the specified value is ignored.
A load balancer node sends all the traffic within its availability zone, regardless of backends' health.

Default value: `0`. ||
|| strict_locality | **bool**

Specifies whether a load balancer node should only send traffic to backends in its availability zone,
regardless of their health, and ignore backends in other zones.

If set to `true` and there are no healthy backends in the zone, the node in this zone will respond
to incoming traffic with errors.
For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality).

If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored.

Default value: `false`. ||
|| mode | enum **LoadBalancingMode**

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
|| target_group_ids[] | **string**

List of ID's of target groups that belong to the backend.

To get the ID's of all available target groups, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/grpc/TargetGroup/list#List) request. ||
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
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Health check timeout.

The timeout is the time allowed for the target to respond to a check.
If the target doesn't respond in time, the check is considered failed. ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Base interval between consecutive health checks. ||
|| interval_jitter_percent | **double** ||
|| healthy_threshold | **int64**

Number of consecutive successful health checks required to mark an unhealthy target as healthy.

Both `0` and `1` values amount to one successful check required.

The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.

Default value: `0`. ||
|| unhealthy_threshold | **int64**

Number of consecutive failed health checks required to mark a healthy target as unhealthy.

Both `0` and `1` values amount to one unsuccessful check required.

The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target
(not applicable to TCP stream health checks). The target is immediately marked unhealthy.

Default value: `0`. ||
|| healthcheck_port | **int64**

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
|| plaintext | **[PlaintextTransportSettings](#yandex.cloud.apploadbalancer.v1.PlaintextTransportSettings)**

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
|| use_http2 | **bool**

Enables HTTP/2 usage in health checks.

Default value: `false`, HTTP/1.1 is used. ||
|| expected_statuses[] | **int64**

A list of HTTP response statuses considered healthy.
By default only 200 HTTP status code considered healthy. ||
|#

## GrpcHealthCheck {#yandex.cloud.apploadbalancer.v1.HealthCheck.GrpcHealthCheck}

A resource for gRPC health check settings.

#|
||Field | Description ||
|| service_name | **string**

Name of the gRPC service to be checked.

If not specified, overall health is checked.

For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). ||
|#

## PlaintextTransportSettings {#yandex.cloud.apploadbalancer.v1.PlaintextTransportSettings}

Transport settings to be used instead of the settings configured per-cluster

#|
||Field | Description ||
|| Empty | > ||
|#

## SecureTransportSettings {#yandex.cloud.apploadbalancer.v1.SecureTransportSettings}

Transport settings to be used instead of the settings configured per-cluster

#|
||Field | Description ||
|| sni | **string**

SNI string for TLS connections. ||
|| validation_context | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)**

Validation context for backend TLS connections. ||
|#

## ValidationContext {#yandex.cloud.apploadbalancer.v1.ValidationContext}

A TLS validation context resource.

#|
||Field | Description ||
|| trusted_ca_id | **string**

Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`.

TLS certificate issued by a trusted certificate authority (CA). ||
|| trusted_ca_bytes | **string**

X.509 certificate contents in PEM format.

Includes only one of the fields `trusted_ca_id`, `trusted_ca_bytes`.

TLS certificate issued by a trusted certificate authority (CA). ||
|#

## BackendTls {#yandex.cloud.apploadbalancer.v1.BackendTls}

A resource for backend TLS settings.

#|
||Field | Description ||
|| sni | **string**

Server Name Indication (SNI) string for TLS connections. ||
|| validation_context | **[ValidationContext](#yandex.cloud.apploadbalancer.v1.ValidationContext)**

Validation context for TLS connections. ||
|#

## ConnectionSessionAffinity {#yandex.cloud.apploadbalancer.v1.ConnectionSessionAffinity}

A resource for connection-based session affinity configuration.

#|
||Field | Description ||
|| source_ip | **bool**

Specifies whether an IP address of the client is used to define a connection for session affinity. ||
|#

## HeaderSessionAffinity {#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity}

A resource for HTTP-header-field-based session affinity configuration.

#|
||Field | Description ||
|| header_name | **string**

Name of the HTTP header field that is used for session affinity. ||
|#

## CookieSessionAffinity {#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity}

A resource for cookie-based session affinity configuration.

#|
||Field | Description ||
|| name | **string**

Name of the cookie that is used for session affinity. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

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
[GrpcBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.apploadbalancer.v1.HeaderSessionAffinity)**

HTTP-header-field-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.apploadbalancer.v1.CookieSessionAffinity)**

Cookie-based session affinity configuration.

Includes only one of the fields `connection`, `header`, `cookie`.

Session affinity configuration for the backend group.

For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity).

If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive
[GrpcBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of
these conditions are not met, session affinity will not work. ||
|#

## GrpcBackend {#yandex.cloud.apploadbalancer.v1.GrpcBackend}

A gRPC backend resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the backend. ||
|| backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends of a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| load_balancing_config | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **int64**

Port used by all targets to receive traffic. ||
|| target_groups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend.

Includes only one of the fields `target_groups`.

Reference to targets that belong to the backend. For now, targets are referenced via target groups. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets
and compares received certificates with the one specified in [BackendTls.validation_context](#yandex.cloud.apploadbalancer.v1.BackendTls).
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
[HttpBackend.backend_weight](#yandex.cloud.apploadbalancer.v1.HttpBackend)), its [HttpBackend.backend_type](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend.backend_type) should be [TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend), and its
[LoadBalancingConfig.load_balancing_mode] should be `MAGLEV_HASH`. If any of these conditions are not met, session
affinity will not work. ||
|#

## StreamBackend {#yandex.cloud.apploadbalancer.v1.StreamBackend}

A stream (TCP) backend resource.

#|
||Field | Description ||
|| name | **string**

Name of the backend. ||
|| backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Backend weight. Traffic is distributed between backends of a backend group according to their weights.

Weights must be set either for all backends in a group or for none of them.
Setting no weights is the same as setting equal non-zero weights for all backends.

If the weight is non-positive, traffic is not sent to the backend. ||
|| load_balancing_config | **[LoadBalancingConfig](#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig)**

Load balancing configuration for the backend. ||
|| port | **int64**

Port used by all targets to receive traffic. ||
|| target_groups | **[TargetGroupsBackend](#yandex.cloud.apploadbalancer.v1.TargetGroupsBackend)**

Target groups that belong to the backend. For details about target groups, see
[documentation](/docs/application-load-balancer/concepts/target-group).

Includes only one of the fields `target_groups`.

Reference to targets that belong to the backend. ||
|| healthchecks[] | **[HealthCheck](#yandex.cloud.apploadbalancer.v1.HealthCheck)**

Health checks to perform on targets from target groups.
For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks).

If no health checks are specified, active health checking is not performed. ||
|| tls | **[BackendTls](#yandex.cloud.apploadbalancer.v1.BackendTls)**

Settings for TLS connections between load balancer nodes and backend targets.

If specified, the load balancer establishes TLS-encrypted TCP connections with targets and compares received
certificates with the one specified in [BackendTls.validation_context](#yandex.cloud.apploadbalancer.v1.BackendTls).
If not specified, the load balancer establishes unencrypted TCP connections with targets. ||
|| enable_proxy_protocol | **bool**

If set, proxy protocol will be enabled for this backend. ||
|| keep_connections_on_host_health_failure | **bool**

If a backend host becomes unhealthy (as determined by the configured health checks),
keep connections to the failed host. ||
|#