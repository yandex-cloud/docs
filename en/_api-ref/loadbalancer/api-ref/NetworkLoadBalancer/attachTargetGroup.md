---
editable: false
---

# Method attachTargetGroup
Attaches a target group to the specified network load balancer.
 

 
## HTTP request {#https-request}
```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:attachTargetGroup
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkLoadBalancerId | <p>Required. ID of the network load balancer to attach the target group to. To get the network load balancer ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "attachedTargetGroup": {
    "targetGroupId": "string",
    "healthChecks": [
      {
        "name": "string",
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",

        // `attachedTargetGroup.healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        },
        // end of the list of possible fields`attachedTargetGroup.healthChecks[]`

      }
    ]
  }
}
```

 
Field | Description
--- | ---
attachedTargetGroup | **object**<br><p>Required. ID of the attached target group to attach to the network load balancer. To get the network load balancer ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>An AttachedTargetGroup resource. For more information, see <a href="/docs/network-load-balancer/concepts/target-resources">Targets and groups</a>.</p> 
attachedTargetGroup.<br>targetGroupId | **string**<br><p>Required. ID of the target group.</p> <p>The maximum string length in characters is 50.</p> 
attachedTargetGroup.<br>healthChecks[] | **object**<br><p>Required. A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.</p> <p>Must contain exactly 1 element.</p> 
attachedTargetGroup.<br>healthChecks[].<br>name | **string**<br><p>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
attachedTargetGroup.<br>healthChecks[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> 
attachedTargetGroup.<br>healthChecks[].<br>timeout | **string**<br><p>Timeout for a target to return a response for the health check. The default is 1 second.</p> 
attachedTargetGroup.<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of failed health checks before changing the status to ``UNHEALTHY``. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroup.<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of successful health checks required in order to set the ``HEALTHY`` status for the target. The default is 2.</p> <p>Acceptable values are 2 to 10, inclusive.</p> 
attachedTargetGroup.<br>healthChecks[].<br>tcpOptions | **object**<br>Options for TCP health check. <br>`attachedTargetGroup.healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
attachedTargetGroup.<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroup.<br>healthChecks[].<br>httpOptions | **object**<br>Options for HTTP health check. <br>`attachedTargetGroup.healthChecks[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
attachedTargetGroup.<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
attachedTargetGroup.<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests for every target in the target group. For example ``/ping``. The default path is ``/``.</p> 
 
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