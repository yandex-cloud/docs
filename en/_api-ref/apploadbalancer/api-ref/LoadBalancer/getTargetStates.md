---
editable: false
---

# Method getTargetStates
Returns the statuses of all targets of the specified backend group in all their availability zones.
 

 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers/{loadBalancerId}/targetStates/{backendGroupId}/{targetGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | Required. ID of the application load balancer that the backend group is attributed to.
backendGroupId | Required. ID of the backend group that the target group is attributed to.
targetGroupId | Required. ID of the target group to get target states of.
 
## Response {#responses}
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
            "failedActiveHc": true
          }
        ]
      },
      "target": {
        "subnetId": "string",
        "ipAddress": "string"
      }
    }
  ]
}
```

 
Field | Description
--- | ---
targetStates[] | **object**<br><p>A target state resource.</p> 
targetStates[].<br>status | **object**<br><p>Health of the target, i.e. its statuses in all availability zones.</p> <p>Health of the target.</p> 
targetStates[].<br>status.<br>zoneStatuses[] | **object**<br><p>Health of the target in the availability zone.</p> 
targetStates[].<br>status.<br>zoneStatuses[].<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
targetStates[].<br>status.<br>zoneStatuses[].<br>status | **string**<br><p>Status of the target in the availability zone.</p> <p>Supported target statuses.</p> <ul> <li>HEALTHY: All of the health checks specified in ``healthchecks`` or ``healthchecks`` are passed (the number depends on the ``healthyThreshold`` setting) and the target is ready to receive traffic.</li> <li>PARTIALLY_HEALTHY: Some of the health checks specified in ``healthchecks`` or ``healthchecks`` failed (the number depends on the ``unhealthyThreshold`` setting). The target is ready to receive traffic from the load balancer nodes which, based on their health checks, consider the target healthy.</li> <li>UNHEALTHY: All of the health checks specified in ``healthchecks`` or ``healthchecks`` failed (the number depends on the ``unhealthyThreshold`` setting) and the target is not receiving traffic.</li> <li>DRAINING: Target is being deleted and the application load balancer is no longer sending traffic to this target.</li> </ul> 
targetStates[].<br>status.<br>zoneStatuses[].<br>failedActiveHc | **boolean** (boolean)<br><p>Indicates whether the target has been marked ``UNHEALTHY`` due to failing active health checks, which determine target statuses as configured in ``healthchecks`` or ``healthchecks``.</p> <p>Currently the only type of health checks is active, as described above. Passive health checks, which determine the health of a target based on its responses to production requests (HTTP 5xx status codes, connection errors etc.), are not implemented yet.</p> 
targetStates[].<br>target | **object**<br><p>Required. Target.</p> <p>A target resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/target-group">documentation</a>.</p> 
targetStates[].<br>target.<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targetStates[].<br>target.<br>ipAddress | **string**<br><p>IP address of the target.</p> 