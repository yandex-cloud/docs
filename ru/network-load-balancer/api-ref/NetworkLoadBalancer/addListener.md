---
editable: false
sourcePath: en/_api-ref/loadbalancer/api-ref/NetworkLoadBalancer/addListener.md
---

# Method addListener
Adds a listener to the specified network load balancer.
 

 
## HTTP request {#https-request}
```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:addListener
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkLoadBalancerId | <p>Required. ID of the network load balancer to add a listener to. To get the network load balancer ID, use a <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "listenerSpec": {
    "name": "string",
    "port": "string",
    "protocol": "string",
    "targetPort": "string",

    // `listenerSpec` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`
    "externalAddressSpec": {
      "address": "string",
      "ipVersion": "string"
    },
    "internalAddressSpec": {
      "address": "string",
      "subnetId": "string",
      "ipVersion": "string"
    },
    // end of the list of possible fields`listenerSpec`

  }
}
```

 
Field | Description
--- | ---
listenerSpec | **object**<br><p>Required. Listener spec.</p> <p>Listener specification that will be used by a network load balancer.</p> 
listenerSpec.<br>name | **string**<br><p>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
listenerSpec.<br>port | **string** (int64)<br><p>Port for incoming traffic.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpec.<br>protocol | **string**<br>Required. Protocol for incoming traffic.
listenerSpec.<br>targetPort | **string** (int64)<br><p>Port of a target. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpec.<br>externalAddressSpec | **object**<br>External IP address specification. <br>`listenerSpec` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br>
listenerSpec.<br>externalAddressSpec.<br>address | **string**<br><p>Public IP address for a listener. If you provide a static public IP address for the <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/update">update</a> method, it will replace the existing listener address.</p> 
listenerSpec.<br>externalAddressSpec.<br>ipVersion | **string**<br><p>IP version.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
listenerSpec.<br>internalAddressSpec | **object**<br>Internal IP address specification. <br>`listenerSpec` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br>
listenerSpec.<br>internalAddressSpec.<br>address | **string**<br><p>Internal IP address for a listener.</p> 
listenerSpec.<br>internalAddressSpec.<br>subnetId | **string**<br><p>ID of the subnet.</p> 
listenerSpec.<br>internalAddressSpec.<br>ipVersion | **string**<br><p>IP version.</p> <p>IP version of the addresses that the load balancer works with. Only IPv4 is currently available.</p> <ul> <li>IPV4: IPv4</li> <li>IPV6: IPv6</li> </ul> 
 
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