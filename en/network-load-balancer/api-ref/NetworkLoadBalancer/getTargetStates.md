---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:getTargetStates
    method: get
    path:
      type: object
      properties:
        networkLoadBalancerId:
          description: |-
            **string**
            ID of the NetworkLoadBalancer resource with an attached target group.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        targetGroupId:
          description: |-
            **string**
            ID of the target group to get states of resources from.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/NetworkLoadBalancer/getTargetStates.md
---

# Network Load Balancer API, REST: NetworkLoadBalancer.GetTargetStates

Gets states of target resources in the attached target group.

## HTTP request

```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:getTargetStates
```

## Path parameters

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

Required field. ID of the NetworkLoadBalancer resource with an attached target group. ||
|#

## Query parameters {#yandex.cloud.loadbalancer.v1.GetTargetStatesRequest}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group to get states of resources from. ||
|#

## Response {#yandex.cloud.loadbalancer.v1.GetTargetStatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "targetStates": [
    {
      "subnetId": "string",
      "address": "string",
      "status": "string"
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
|| status | **enum** (Status)

Status of the target.

- `STATUS_UNSPECIFIED`
- `INITIAL`: The network load balancer is setting up health checks for this target.
- `HEALTHY`: Health check passed and the target is ready to receive traffic.
- `UNHEALTHY`: Health check failed and the target is not receiving traffic.
- `DRAINING`: Target is being deleted and the network load balancer is no longer sending traffic to this target.
- `INACTIVE`: The network load balancer is stopped and not performing health checks on this target. ||
|#