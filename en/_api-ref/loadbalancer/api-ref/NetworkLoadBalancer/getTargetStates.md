---
editable: false
---

# Method getTargetStates
Gets states of target resources in the attached target group.
 

 
## HTTP request {#https-request}
```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:getTargetStates
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkLoadBalancerId | <p>ID of the NetworkLoadBalancer resource with an attached target group.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
targetGroupId | <p>ID of the target group to get states of resources from.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
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

 
Field | Description
--- | ---
targetStates[] | **object**<br><p>List of states of targets within the target group that is specified in the ``GetTargetStatesRequest`` message.</p> 
targetStates[].<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targetStates[].<br>address | **string**<br><p>IP address of the target.</p> 
targetStates[].<br>status | **string**<br><p>Status of the target.</p> <p>Status of the target.</p> <ul> <li>INITIAL: The network load balancer is setting up health checks for this target.</li> <li>HEALTHY: Health check passed and the target is ready to receive traffic.</li> <li>UNHEALTHY: Health check failed and the target is not receiving traffic.</li> <li>DRAINING: Target is being deleted and the network load balancer is no longer sending traffic to this target.</li> <li>INACTIVE: The network load balancer is stopped and not performing health checks on this target.</li> </ul> 