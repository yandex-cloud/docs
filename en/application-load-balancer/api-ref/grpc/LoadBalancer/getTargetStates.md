---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/LoadBalancer/getTargetStates.md
---

# Application Load Balancer API, gRPC: LoadBalancerService.GetTargetStates

Returns the statuses of all targets of the specified backend group in all their availability zones.

## gRPC request

**rpc GetTargetStates ([GetTargetStatesRequest](#yandex.cloud.apploadbalancer.v1.GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#yandex.cloud.apploadbalancer.v1.GetTargetStatesResponse))**

## GetTargetStatesRequest {#yandex.cloud.apploadbalancer.v1.GetTargetStatesRequest}

```json
{
  "load_balancer_id": "string",
  "backend_group_id": "string",
  "target_group_id": "string"
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the application load balancer that the backend group is attributed to. ||
|| backend_group_id | **string**

Required field. ID of the backend group that the target group is attributed to. ||
|| target_group_id | **string**

Required field. ID of the target group to get target states of. ||
|#

## GetTargetStatesResponse {#yandex.cloud.apploadbalancer.v1.GetTargetStatesResponse}

```json
{
  "target_states": [
    {
      "status": {
        "zone_statuses": [
          {
            "zone_id": "string",
            "status": "Status",
            "failed_active_hc": "bool"
          }
        ]
      },
      "target": {
        // Includes only one of the fields `ip_address`
        "ip_address": "string",
        // end of the list of possible fields
        "subnet_id": "string",
        "private_ipv4_address": "bool"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| target_states[] | **[TargetState](#yandex.cloud.apploadbalancer.v1.TargetState)**

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
|| zone_statuses[] | **[ZoneHealthcheckStatus](#yandex.cloud.apploadbalancer.v1.TargetState.ZoneHealthcheckStatus)**

Statuses of the target in its availability zones. ||
|#

## ZoneHealthcheckStatus {#yandex.cloud.apploadbalancer.v1.TargetState.ZoneHealthcheckStatus}

Health of the target in the availability zone.

#|
||Field | Description ||
|| zone_id | **string**

Required field. ID of the availability zone. ||
|| status | enum **Status**

Status of the target in the availability zone.

- `STATUS_UNSPECIFIED`
- `HEALTHY`: All of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) are passed
(the number depends on the [HealthCheck.healthy_threshold](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting) and the target is ready to receive traffic.
- `PARTIALLY_HEALTHY`: Some of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) failed
(the number depends on the [HealthCheck.unhealthy_threshold](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting).
The target is ready to receive traffic from the load balancer nodes which, based on their health checks,
consider the target healthy.
- `UNHEALTHY`: All of the health checks specified in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend) failed
(the number depends on the [HealthCheck.unhealthy_threshold](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) setting) and the target is not receiving traffic.
- `DRAINING`: Target is being deleted and the application load balancer is no longer sending traffic to this target.
- `TIMEOUT` ||
|| failed_active_hc | **bool**

Indicates whether the target has been marked `UNHEALTHY` due to failing active health checks,
which determine target statuses as configured in [HttpBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HttpBackend) or [GrpcBackend.healthchecks](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.GrpcBackend).

Currently the only type of health checks is active, as described above.
Passive health checks, which determine the health of a target based on its responses to production requests
(HTTP 5xx status codes, connection errors etc.), are not implemented yet. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ip_address | **string**

IP address of the target.

Includes only one of the fields `ip_address`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnet_id | **string**

ID of the subnet that the target is connected to. ||
|| private_ipv4_address | **bool**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#