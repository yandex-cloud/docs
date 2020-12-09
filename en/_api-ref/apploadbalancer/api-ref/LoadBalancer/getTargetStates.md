---
editable: false
---

# Method getTargetStates
Returns zonal state of each target within target group
for a given backend group and load balancer.
 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers/{loadBalancerId}/targetStates/{backendGroupId}/{targetGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | Required.
backendGroupId | Required.
targetGroupId | Required.
 
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
targetStates[] | **object**<br>
targetStates[].<br>status | **object**<br><p>Statuses of the target for all known zones.</p> 
targetStates[].<br>status.<br>zoneStatuses[] | **object**<br>
targetStates[].<br>status.<br>zoneStatuses[].<br>zoneId | **string**<br><p>Required.</p> 
targetStates[].<br>status.<br>zoneStatuses[].<br>status | **string**<br><p>Healthcheck status of target for the specific zone.</p> 
targetStates[].<br>status.<br>zoneStatuses[].<br>failedActiveHc | **boolean** (boolean)<br><p>Whether UNHEALTHY status was set due to failed active checks or not.</p> 
targetStates[].<br>target | **object**<br><p>Required.</p> 
targetStates[].<br>target.<br>subnetId | **string**<br><p>ID of the subnet that target connected to.</p> 
targetStates[].<br>target.<br>ipAddress | **string**<br>