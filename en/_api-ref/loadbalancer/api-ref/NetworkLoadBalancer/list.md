---
editable: false
---

# Method list
Retrieves the list of NetworkLoadBalancer resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the network load balancer belongs to. To get the folder ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageSize</a>, the service returns a [<ResponseMessage>.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageToken</a> to the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can only filter by the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer#representation">NetworkLoadBalancer.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networkLoadBalancers": [
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

              // `networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`
              "tcpOptions": {
                "port": "string"
              },
              "httpOptions": {
                "port": "string",
                "path": "string"
              },
              // end of the list of possible fields`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]`

            }
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
networkLoadBalancers[] | **object**<br><p>List of NetworkLoadBalancer resources.</p> 
networkLoadBalancers[].<br>id | **string**<br><p>ID of the network load balancer.</p> 
networkLoadBalancers[].<br>folderId | **string**<br><p>ID of the folder that the network load balancer belongs to.</p> 
networkLoadBalancers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
networkLoadBalancers[].<br>name | **string**<br><p>Name of the network load balancer. The name is unique within the folder. 3-63 characters long.</p> 
networkLoadBalancers[].<br>description | **string**<br><p>Optional description of the network load balancer. 0-256 characters long.</p> 
networkLoadBalancers[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
networkLoadBalancers[].<br>regionId | **string**<br><p>ID of the region that the network load balancer belongs to.</p> 
networkLoadBalancers[].<br>status | **string**<br><p>Status of the network load balancer.</p> <ul> <li>CREATING: Network load balancer is being created.</li> <li>STARTING: Network load balancer is being started.</li> <li>ACTIVE: Network load balancer is active and sends traffic to the targets.</li> <li>STOPPING: Network load balancer is being stopped.</li> <li>STOPPED: Network load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: Network load balancer is being deleted.</li> <li>INACTIVE: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li> </ul> 
networkLoadBalancers[].<br>type | **string**<br><p>Type of the network load balancer. Only external network load balancers are available now.</p> <p>Type of the load balancer. Only external load balancers are currently available.</p> <ul> <li>EXTERNAL: External network load balancer.</li> <li>INTERNAL: Internal network load balancer.</li> </ul> 
networkLoadBalancers[].<br>sessionAffinity | **string**<br><p>Type of the session affinity. Only 5-tuple affinity is available now.</p> <p>Type of session affinity. Only 5-tuple affinity is currently available. For more information, see <a href="/docs/network-load-balancer/concepts/">Load Balancer concepts</a>.</p> <ul> <li>CLIENT_IP_PORT_PROTO: 5-tuple affinity.</li> </ul> 
networkLoadBalancers[].<br>listeners[] | **object**<br><p>List of listeners for the network load balancer.</p> 
networkLoadBalancers[].<br>listeners[].<br>name | **string**<br><p>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> 
networkLoadBalancers[].<br>listeners[].<br>address | **string**<br><p>IP address for the listener.</p> 
networkLoadBalancers[].<br>listeners[].<br>port | **string** (int64)<br><p>Port.</p> 
networkLoadBalancers[].<br>listeners[].<br>protocol | **string**<br><p>Network protocol for incoming traffic.</p> <p>Network protocol to use.</p> 
networkLoadBalancers[].<br>listeners[].<br>targetPort | **string** (int64)<br><p>Port of a target.</p> 
networkLoadBalancers[].<br>listeners[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
networkLoadBalancers[].<br>listeners[].<br>ipVersion | **string**<br><p>IP version of the external address.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
networkLoadBalancers[].<br>attachedTargetGroups[] | **object**<br><p>List of target groups attached to the network load balancer.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>targetGroupId | **string**<br><p>Required. ID of the target group.</p> <p>The maximum string length in characters is 50.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[] | **object**<br><p>Required. A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.</p> <p>Must contain exactly 1 element.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>name | **string**<br><p>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>timeout | **string**<br><p>Timeout for a target to return a response for the health check. The default is 1 second.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of failed health checks before changing the status to ``UNHEALTHY``. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of successful health checks required in order to set the ``HEALTHY`` status for the target. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions | **object**<br>Options for TCP health check. <br>`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions | **object**<br>Options for HTTP health check. <br>`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests for every target in the target group. For example ``/ping``. The default path is ``/``.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageSize</a>, use the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#responses">nextPageToken</a> as the value for the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#responses">nextPageToken</a> to continue paging through the results.</p> 