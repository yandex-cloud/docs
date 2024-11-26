---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/LoadBalancer/getTargetStates.md
---

# Application Load Balancer API, REST: LoadBalancer.GetTargetStates

Returns the statuses of all targets of the specified backend group in all their availability zones.

## HTTP request

```
GET https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}/targetStates/{backendGroupId}/{targetGroupId}
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the application load balancer that the backend group is attributed to. ||
|| backendGroupId | **string**

Required field. ID of the backend group that the target group is attributed to. ||
|| targetGroupId | **string**

Required field. ID of the target group to get target states of. ||
|#

## Response {#yandex.cloud.apploadbalancer.v1.GetTargetStatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "targetStates": [
    {
      "status": {
        "zoneStatuses": [
          {
            "zoneId": "string",
            "status": "string",
            "failedActiveHc": "boolean"
          }
        ]
      },
      "target": {
        // Includes only one of the fields `ipAddress`
        "ipAddress": "string",
        // end of the list of possible fields
        "subnetId": "string",
        "privateIpv4Address": "boolean"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| targetStates[] | **[TargetState](#yandex.cloud.apploadbalancer.v1.TargetState)**

Target states of the specified target group. ||
|#

## TargetState {#yandex.cloud.apploadbalancer.v1.TargetState}

A target state resource.

#|
||Field | Description ||
|| status | **[HealthcheckStatus](#yandex.cloud.apploadbalancer.v1.TargetState.HealthcheckStatus)**

Health of the target, i.e. its statuses in all availability zones. ||
|| target | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

Required field. Target. ||
|#

## HealthcheckStatus {#yandex.cloud.apploadbalancer.v1.TargetState.HealthcheckStatus}

Health of the target.

#|
||Field | Description ||
|| zoneStatuses[] | **[ZoneHealthcheckStatus](#yandex.cloud.apploadbalancer.v1.TargetState.ZoneHealthcheckStatus)**

Statuses of the target in its availability zones. ||
|#

## ZoneHealthcheckStatus {#yandex.cloud.apploadbalancer.v1.TargetState.ZoneHealthcheckStatus}

Health of the target in the availability zone.

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone. ||
|| status | **enum** (Status)

Status of the target in the availability zone.

- `STATUS_UNSPECIFIED`
- `HEALTHY`: All of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) are passed
(the number depends on the [HealthCheck.healthyThreshold](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting) and the target is ready to receive traffic.
- `PARTIALLY_HEALTHY`: Some of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) failed
(the number depends on the [HealthCheck.unhealthyThreshold](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting).
The target is ready to receive traffic from the load balancer nodes which, based on their health checks,
consider the target healthy.
- `UNHEALTHY`: All of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) failed
(the number depends on the [HealthCheck.unhealthyThreshold](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting) and the target is not receiving traffic.
- `DRAINING`: Target is being deleted and the application load balancer is no longer sending traffic to this target.
- `TIMEOUT` ||
|| failedActiveHc | **boolean**

Indicates whether the target has been marked `UNHEALTHY` due to failing active health checks,
which determine target statuses as configured in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend).

Currently the only type of health checks is active, as described above.
Passive health checks, which determine the health of a target based on its responses to production requests
(HTTP 5xx status codes, connection errors etc.), are not implemented yet. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ipAddress | **string**

IP address of the target.

Includes only one of the fields `ipAddress`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| privateIpv4Address | **boolean**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#