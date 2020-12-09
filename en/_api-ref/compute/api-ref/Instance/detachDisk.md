---
editable: false
---

# Method detachDisk
Detaches the disk from the instance.
 

 
## HTTP request {#https-request}
```
POST https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}:detachDisk
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | Required. ID of the instance to detach the disk from. To get the instance ID, use a [list](/docs/compute/api-ref/Instance/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{

  //  includes only one of the fields `diskId`, `deviceName`
  "diskId": "string",
  "deviceName": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
diskId | **string** <br> includes only one of the fields `diskId`, `deviceName`<br><br><p>ID of the disk that should be detached.</p> <p>The maximum string length in characters is 50.</p> 
deviceName | **string** <br> includes only one of the fields `diskId`, `deviceName`<br><br><p>Serial number of the disk that should be detached. This value is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>Value must match the regular expression `` [a-z][a-z0-9-_]{,19} ``.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 