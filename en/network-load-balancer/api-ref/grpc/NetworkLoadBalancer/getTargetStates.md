---
editable: false
sourcePath: en/_api-ref-grpc/loadbalancer/v1/api-ref/grpc/NetworkLoadBalancer/getTargetStates.md
---

# Network Load Balancer API, gRPC: NetworkLoadBalancerService.GetTargetStates {#GetTargetStates}

Gets states of target resources in the attached target group.

## gRPC request

**rpc GetTargetStates ([GetTargetStatesRequest](#yandex.cloud.loadbalancer.v1.GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#yandex.cloud.loadbalancer.v1.GetTargetStatesResponse))**

## GetTargetStatesRequest {#yandex.cloud.loadbalancer.v1.GetTargetStatesRequest}

```json
{
  "networkLoadBalancerId": "string",
  "targetGroupId": "string"
}
```

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

ID of the NetworkLoadBalancer resource with an attached target group. ||
|| targetGroupId | **string**

ID of the target group to get states of resources from. ||
|#

## GetTargetStatesResponse {#yandex.cloud.loadbalancer.v1.GetTargetStatesResponse}

```json
{
  "targetStates": [
    {
      "subnetId": "string",
      "address": "string",
      "status": "Status"
    }
  ]
}
```

#|
||Field | Description ||
|| targetStates[] | **[TargetState](#yandex.cloud.loadbalancer.v1.TargetState)**

List of states of targets within the target group that is specified in the [GetTargetStatesRequest](#yandex.cloud.loadbalancer.v1.GetTargetStatesRequest) message. ||
|#

## TargetState {#yandex.cloud.loadbalancer.v1.TargetState}

State of the target that was returned after the last health check.

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| address | **string**

IP address of the target. ||
|| status | enum **Status**

Status of the target.

- `STATUS_UNSPECIFIED`
- `INITIAL`: The network load balancer is setting up health checks for this target.
- `HEALTHY`: Health check passed and the target is ready to receive traffic.
- `UNHEALTHY`: Health check failed and the target is not receiving traffic.
- `DRAINING`: Target is being deleted and the network load balancer is no longer sending traffic to this target.
- `INACTIVE`: The network load balancer is stopped and not performing health checks on this target. ||
|#