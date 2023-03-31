---
editable: false
sourcePath: en/_api-ref/loadbalancer/api-ref/NetworkLoadBalancer/create.md
---

# Network Load Balancer API, REST: NetworkLoadBalancer.create
Creates a network load balancer in the specified folder using the data specified in the request.
 

 
## HTTP request {#https-request}
```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "type": "string",
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
  ],
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a network load balancer in. To get the folder ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the network load balancer. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the network load balancer.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
regionId | **string**<br><p>ID of the region where the network load balancer resides.</p> <p>The maximum string length in characters is 50.</p> 
type | **string**<br><p>Required. Type of the network load balancer.</p> <ul> <li>EXTERNAL: External network load balancer.</li> <li>INTERNAL: Internal network load balancer.</li> </ul> 
listenerSpecs[] | **object**<br><p>List of listeners and their specs for the network load balancer.</p> <p>The maximum number of elements is 1000.</p> 
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
attachedTargetGroups[] | **object**<br><p>List of attached target groups for the network load balancer.</p> <p>The maximum number of elements is 1000.</p> 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 