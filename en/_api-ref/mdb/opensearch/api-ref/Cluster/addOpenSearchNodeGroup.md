---
editable: false
---

# Method addOpenSearchNodeGroup
Add an OpenSearch node group
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/opensearch/node_groups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "nodeGroupSpec": {
    "name": "string",
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "hostsCount": "string",
    "zoneIds": [
      "string"
    ],
    "subnetIds": [
      "string"
    ],
    "assignPublicIp": true,
    "roles": [
      "string"
    ]
  }
}
```

 
Field | Description
--- | ---
nodeGroupSpec | **object**
nodeGroupSpec.<br>name | **string**<br><p>Required. Required. Name of the group to be created.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
nodeGroupSpec.<br>resources | **object**<br><p>Resources allocated to data node hosts.</p> 
nodeGroupSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
nodeGroupSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
nodeGroupSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
nodeGroupSpec.<br>hostsCount | **string** (int64)<br><p>Number of nodes in the group</p> <p>The minimum value is 1.</p> 
nodeGroupSpec.<br>zoneIds[] | **string**<br><p>IDs of the availability zone for hosts</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 50.</p> 
nodeGroupSpec.<br>subnetIds[] | **string**<br><p>IDs of the subnetworks in respective zones.</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 50.</p> 
nodeGroupSpec.<br>assignPublicIp | **boolean** (boolean)
nodeGroupSpec.<br>roles[] | **string**
 
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