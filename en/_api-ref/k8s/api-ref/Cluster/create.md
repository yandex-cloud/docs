---
editable: false
---

# Method create
Creates a Kubernetes cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "masterSpec": {
    "zonalMasterSpec": {
      "zoneId": "string",
      "internalV4AddressSpec": {
        "subnetId": "string"
      },
      "externalV4AddressSpec": {}
    }
  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "serviceIpv4CidrBlock": "string"
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "gatewayIpv4Address": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a Kubernetes cluster in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the Kubernetes cluster. The name must be unique within the folder.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Description of the Kubernetes cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
networkId | **string**<br><p>Required. ID of the network.</p> 
masterSpec | **object**<br>Required. IP allocation policy of the Kubernetes cluster.<br>
masterSpec.<br>zonalMasterSpec | **object**<br>Specification of the master availability zone.<br>
masterSpec.<br>zonalMasterSpec.<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec | **object**<br><p>Specification of parameters for internal IPv4 networking.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Specification of parameters for external IPv4 networking.</p> 
ipAllocationPolicy | **object**<br>IP allocation policy of the Kubernetes cluster.<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
serviceAccountId | **string**<br><p>Required. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have <code>edit</code> role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.</p> 
nodeServiceAccountId | **string**<br><p>Required. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 