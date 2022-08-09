---
editable: false
---

# Method update
Updates the specified network load balancer.
 

 
## HTTP request {#https-request}
```
PATCH https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkLoadBalancerId | <p>Required. ID of the network load balancer to update. To get the network load balancer ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "listenerSpecs": [
    {
      "name": "string",
      "port": "string",
      "protocol": "string",
      "targetPort": "string",

      // `listenerSpecs[]` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`
      "externalAddressSpec": {
        "address": "string",
        "ipVersion": "string"
      },
      "internalAddressSpec": {
        "address": "string",
        "subnetId": "string",
        "ipVersion": "string"
      },
      // end of the list of possible fields`listenerSpecs[]`

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

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the NetworkLoadBalancer resource are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>Name of the network load balancer. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the network load balancer.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>The existing set of ``labels`` is completely replaced with the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
listenerSpecs[] | **object**<br><p>A list of listeners and their specs for the network load balancer.</p> <p>The maximum number of elements is 1000.</p> 
listenerSpecs[].<br>name | **string**<br><p>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
listenerSpecs[].<br>port | **string** (int64)<br><p>Port for incoming traffic.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpecs[].<br>protocol | **string**<br>Required. Protocol for incoming traffic.
listenerSpecs[].<br>targetPort | **string** (int64)<br><p>Port of a target. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpecs[].<br>externalAddressSpec | **object**<br>External IP address specification. <br>`listenerSpecs[]` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br>
listenerSpecs[].<br>externalAddressSpec.<br>address | **string**<br><p>Public IP address for a listener. If you provide a static public IP address for the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/update">update</a> method, it will replace the existing listener address.</p> 
listenerSpecs[].<br>externalAddressSpec.<br>ipVersion | **string**<br><p>IP version.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
listenerSpecs[].<br>internalAddressSpec | **object**<br>Internal IP address specification. <br>`listenerSpecs[]` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br>
listenerSpecs[].<br>internalAddressSpec.<br>address | **string**<br><p>Internal IP address for a listener.</p> 
listenerSpecs[].<br>internalAddressSpec.<br>subnetId | **string**<br><p>ID of the subnet.</p> 
listenerSpecs[].<br>internalAddressSpec.<br>ipVersion | **string**<br><p>IP version.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
attachedTargetGroups[] | **object**<br><p>A list of attached target groups for the network load balancer.</p> <p>The maximum number of elements is 1000.</p> 
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
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 