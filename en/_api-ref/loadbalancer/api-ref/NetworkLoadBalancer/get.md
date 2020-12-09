---
editable: false
---

# Method get
Returns the specified NetworkLoadBalancer resource.
 
Get the list of available NetworkLoadBalancer resources by making a [list](/docs/load-balancer/api-ref/NetworkLoadBalancer/list) request.
 
## HTTP request {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/load-balancer/v1alpha/networkLoadBalancers/{networkLoadBalancerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkLoadBalancerId | ID of the NetworkLoadBalancer resource to return. To get the network load balancer ID, use a [list](/docs/load-balancer/api-ref/NetworkLoadBalancer/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
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
      "address": "string",
      "port": "string",
      "protocol": "string"
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

          // `attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`
          "tcpOptions": {
            "port": "string"
          },
          "httpOptions": {
            "port": "string",
            "path": "string"
          },
          // end of the list of possible fields`attachedTargetGroups[].healthChecks[]`

        }
      ]
    }
  ]
}
```
A NetworkLoadBalancer resource. For more information, see [Network Load Balancer](/docs/load-balancer/concepts).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the network load balancer.</p> 
folderId | **string**<br><p>ID of the folder that the network load balancer belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the network load balancer. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the network load balancer. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as `` key:value `` pairs. Мaximum of 64 per resource.</p> 
regionId | **string**<br><p>ID of the region that the network load balancer belongs to.</p> 
status | **string**<br><p>Status of the network load balancer.</p> <ul> <li>CREATING: Network load balancer is being created.</li> <li>STARTING: Network load balancer is being started.</li> <li>ACTIVE: Network load balancer is active and sends traffic to the targets.</li> <li>STOPPING: Network load balancer is being stopped.</li> <li>STOPPED: Network load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: Network load balancer is being deleted.</li> <li>INACTIVE: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li> </ul> 
type | **string**<br><p>Type of the network load balancer. Only external network load balancers are available now.</p> <p>Type of the load balancer. Only external load balancers are currently available.</p> <ul> <li>EXTERNAL: External network load balancer.</li> </ul> 
sessionAffinity | **string**<br><p>Type of the session affinity. Only 5-tuple affinity is available now.</p> <p>Type of session affinity. Only 5-tuple affinity is currently available. For more information, see <a href="/load-balancer/concepts/">Load Balancer concepts</a>.</p> <ul> <li>CLIENT_IP_PORT_PROTO: 5-tuple affinity.</li> </ul> 
listeners[] | **object**<br><p>A Listener resource. For more information, see <a href="/docs/load-balancer/concepts/listener">Listener</a></p> 
listeners[].<br>address | **string**<br><p>IP address for the listener.</p> 
listeners[].<br>port | **string** (int64)<br><p>Port.</p> 
listeners[].<br>protocol | **string**<br><p>Network protocol for incoming traffic.</p> <p>Network protocol to use.</p> 
attachedTargetGroups[] | **object**<br><p>An AttachedTargetGroup resource. For more information, see <a href="/load-balancer/concepts">Attached Target Groups</a></p> 
attachedTargetGroups[].<br>targetGroupId | **string**<br><p>Required. ID of the target group.</p> <p>The maximum string length in characters is 50.</p> 
attachedTargetGroups[].<br>healthChecks[] | **object**<br><p>A HealthCheck resource. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>name | **string**<br><p>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>timeout | **string**<br><p>Timeout for a target to return a response for the health check. The default is 1 second.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions | **object**<br>Options for TCP health check. <br>`attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br><p>Configuration option for a TCP health check.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions | **object**<br>Options for HTTP health check. <br>`attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br><p>Configuration option for an HTTP health check.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests for every target in the target group. For example `` /ping ``.</p> 