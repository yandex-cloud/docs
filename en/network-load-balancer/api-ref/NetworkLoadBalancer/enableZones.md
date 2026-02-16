---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:enableZones
    method: post
    path:
      type: object
      properties:
        networkLoadBalancerId:
          description: |-
            **string**
            Required field. ID of the network load balancer to enable zones.
          type: string
      required:
        - networkLoadBalancerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        zoneIds:
          description: |-
            **string**
            Zone IDs to enable.
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/NetworkLoadBalancer/enableZones.md
---

# Network Load Balancer API, REST: NetworkLoadBalancer.EnableZones

Enable zones for the specified network load balancer.

## HTTP request

```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:enableZones
```

## Path parameters

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

Required field. ID of the network load balancer to enable zones. ||
|#

## Body parameters {#yandex.cloud.loadbalancer.v1.EnableZonesRequest}

```json
{
  "zoneIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| zoneIds[] | **string**

Zone IDs to enable. ||
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
    "networkLoadBalancerId": "string"
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
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "regionId": "string",
    "status": "string",
    "type": "string",
    "sessionAffinity": "string",
    "listeners": [
      {
        "name": "string",
        "address": "string",
        "port": "string",
        "protocol": "string",
        "targetPort": "string",
        "subnetId": "string",
        "ipVersion": "string"
      }
    ],
    "attachedTargetGroups": [
      {
        "targetGroupId": "string",
        "healthChecks": [
          {
            "name": "string",
            "interval": "string",
            "timeout": "string",
            "unhealthyThreshold": "string",
            "healthyThreshold": "string",
            // Includes only one of the fields `tcpOptions`, `httpOptions`
            "tcpOptions": {
              "port": "string"
            },
            "httpOptions": {
              "port": "string",
              "path": "string"
            }
            // end of the list of possible fields
          }
        ]
      }
    ],
    "deletionProtection": "boolean",
    "allowZonalShift": "boolean",
    "disableZoneStatuses": [
      {
        "zoneId": "string",
        "disabledUntil": "string"
      }
    ]
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
|| metadata | **[EnableZonesMetadata](#yandex.cloud.loadbalancer.v1.EnableZonesMetadata)**

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
|| response | **[NetworkLoadBalancer](#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer)**

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

## EnableZonesMetadata {#yandex.cloud.loadbalancer.v1.EnableZonesMetadata}

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

ID of the network load balancer on which the zones were enabled. ||
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

## NetworkLoadBalancer {#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer}

A NetworkLoadBalancer resource. For more information, see [Network Load Balancer](/docs/network-load-balancer/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the network load balancer. ||
|| folderId | **string**

ID of the folder that the network load balancer belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the network load balancer. The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Optional description of the network load balancer. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| regionId | **string**

ID of the region that the network load balancer belongs to. ||
|| status | **enum** (Status)

Status of the network load balancer.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network load balancer is being created.
- `STARTING`: Network load balancer is being started.
- `ACTIVE`: Network load balancer is active and sends traffic to the targets.
- `STOPPING`: Network load balancer is being stopped.
- `STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.
- `DELETING`: Network load balancer is being deleted.
- `INACTIVE`: The load balancer doesn't have any listeners or target groups, or
attached target groups are empty. The load balancer doesn't perform any health checks or
send traffic in this state. ||
|| type | **enum** (Type)

Type of the network load balancer. Only external network load balancers are available now.

- `TYPE_UNSPECIFIED`
- `EXTERNAL`: External network load balancer.
- `INTERNAL`: Internal network load balancer. ||
|| sessionAffinity | **enum** (SessionAffinity)

Type of the session affinity. Only 5-tuple affinity is available now.

- `SESSION_AFFINITY_UNSPECIFIED`
- `CLIENT_IP_PORT_PROTO`: 5-tuple affinity. ||
|| listeners[] | **[Listener](#yandex.cloud.loadbalancer.v1.Listener)**

List of listeners for the network load balancer. ||
|| attachedTargetGroups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

List of target groups attached to the network load balancer. ||
|| deletionProtection | **boolean**

Specifies if network load balancer protected from deletion. ||
|| allowZonalShift | **boolean**

Specifies if network load balancer available to zonal shift. ||
|| disableZoneStatuses[] | **[DisableZoneStatus](#yandex.cloud.loadbalancer.v1.DisableZoneStatus)**

List of disabled zones for the network load balancer. ||
|#

## Listener {#yandex.cloud.loadbalancer.v1.Listener}

A Listener resource. For more information, see [Listener](/docs/network-load-balancer/concepts/listener)

#|
||Field | Description ||
|| name | **string**

Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. ||
|| address | **string**

IP address for the listener. ||
|| port | **string** (int64)

Port. ||
|| protocol | **enum** (Protocol)

Network protocol for incoming traffic.

- `PROTOCOL_UNSPECIFIED`
- `TCP`
- `UDP` ||
|| targetPort | **string** (int64)

Port of a target. ||
|| subnetId | **string**

ID of the subnet. ||
|| ipVersion | **enum** (IpVersion)

IP version of the external address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup}

An AttachedTargetGroup resource. For more information, see [Targets and groups](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group. ||
|| healthChecks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck}

A HealthCheck resource. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. ||
|| healthyThreshold | **string** (int64)

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**

Options for TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**

Options for HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks. ||
|| path | **string**

URL path to set for health checking requests for every target in the target group.
For example `` /ping ``. The default path is `` / ``. ||
|#

## DisableZoneStatus {#yandex.cloud.loadbalancer.v1.DisableZoneStatus}

Status of the disabled zone.

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of zone. ||
|| disabledUntil | **string** (date-time)

Timestamp until which the zone will be disabled.
If not present then zone will be disabled until it is removed through a separate call.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#