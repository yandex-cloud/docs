---
editable: false
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/NetworkLoadBalancer/index.md
---

# Network Load Balancer API, REST: NetworkLoadBalancer methods
A set of methods for managing NetworkLoadBalancer resources.
## JSON Representation {#representation}
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
  ],
  "deletionProtection": true
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the network load balancer.</p> 
folderId | **string**<br><p>ID of the folder that the network load balancer belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the network load balancer. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the network load balancer. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
regionId | **string**<br><p>ID of the region that the network load balancer belongs to.</p> 
status | **string**<br><p>Status of the network load balancer.</p> <ul> <li>CREATING: Network load balancer is being created.</li> <li>STARTING: Network load balancer is being started.</li> <li>ACTIVE: Network load balancer is active and sends traffic to the targets.</li> <li>STOPPING: Network load balancer is being stopped.</li> <li>STOPPED: Network load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: Network load balancer is being deleted.</li> <li>INACTIVE: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li> </ul> 
type | **string**<br><p>Type of the network load balancer. Only external network load balancers are available now.</p> <ul> <li>EXTERNAL: External network load balancer.</li> <li>INTERNAL: Internal network load balancer.</li> </ul> 
sessionAffinity | **string**<br><p>Type of the session affinity. Only 5-tuple affinity is available now.</p> <p>Type of session affinity. Only 5-tuple affinity is currently available. For more information, see <a href="/docs/network-load-balancer/concepts/">Load Balancer concepts</a>.</p> <ul> <li>CLIENT_IP_PORT_PROTO: 5-tuple affinity.</li> </ul> 
listeners[] | **object**<br><p>List of listeners for the network load balancer.</p> 
listeners[].<br>name | **string**<br><p>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> 
listeners[].<br>address | **string**<br><p>IP address for the listener.</p> 
listeners[].<br>port | **string** (int64)<br><p>Port.</p> 
listeners[].<br>protocol | **string**<br><p>Network protocol for incoming traffic.</p> <p>Network protocol to use.</p> 
listeners[].<br>targetPort | **string** (int64)<br><p>Port of a target.</p> 
listeners[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
listeners[].<br>ipVersion | **string**<br><p>IP version of the external address.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
attachedTargetGroups[] | **object**<br><p>List of target groups attached to the network load balancer.</p> 
attachedTargetGroups[].<br>targetGroupId | **string**<br><p>Required. ID of the target group.</p> <p>The maximum string length in characters is 50.</p> 
attachedTargetGroups[].<br>healthChecks[] | **object**<br><p>Required. A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.</p> <p>Must contain exactly 1 element.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>name | **string**<br><p>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>timeout | **string**<br><p>Timeout for a target to return a response for the health check. The default is 1 second.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of failed health checks before changing the status to ``UNHEALTHY``. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of successful health checks required in order to set the ``HEALTHY`` status for the target. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions | **object**<br>Options for TCP health check. <br>`attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions | **object**<br>Options for HTTP health check. <br>`attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests for every target in the target group. For example ``/ping``. The default path is ``/``.</p> 
deletionProtection | **boolean** (boolean)<br><p>Specifies if network load balancer protected from deletion.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addListener](addListener.md) | Adds a listener to the specified network load balancer.
[attachTargetGroup](attachTargetGroup.md) | Attaches a target group to the specified network load balancer.
[create](create.md) | Creates a network load balancer in the specified folder using the data specified in the request.
[delete](delete.md) | Deletes the specified network load balancer.
[detachTargetGroup](detachTargetGroup.md) | Detaches the target group from the specified network load balancer.
[get](get.md) | Returns the specified NetworkLoadBalancer resource.
[getTargetStates](getTargetStates.md) | Gets states of target resources in the attached target group.
[list](list.md) | Retrieves the list of NetworkLoadBalancer resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified network load balancer.
[removeListener](removeListener.md) | Removes the listener from the specified network load balancer.
[start](start.md) | Starts load balancing and health checking with the specified network load balancer with specified settings. Changes network load balancer status to `` ACTIVE ``.
[stop](stop.md) | Stops load balancing and health checking with the specified network load balancer. Changes load balancer status to `` STOPPED ``.
[update](update.md) | Updates the specified network load balancer.