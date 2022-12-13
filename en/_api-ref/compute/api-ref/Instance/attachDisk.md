---
editable: false
---

# Compute Cloud API, REST: Instance.attachDisk
Attaches the disk to the instance.
 

 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:attachDisk
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | <p>Required. ID of the instance to attach the disk to. To get the instance ID, use a <a href="/docs/compute/api-ref/Instance/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "attachedDiskSpec": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,

    // `attachedDiskSpec` includes only one of the fields `diskSpec`, `diskId`
    "diskSpec": {
      "name": "string",
      "description": "string",
      "typeId": "string",
      "size": "string",
      "blockSize": "string",
      "diskPlacementPolicy": {
        "placementGroupId": "string"
      },

      // `attachedDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
      "imageId": "string",
      "snapshotId": "string",
      // end of the list of possible fields`attachedDiskSpec.diskSpec`

    },
    "diskId": "string",
    // end of the list of possible fields`attachedDiskSpec`

  }
}
```

 
Field | Description
--- | ---
attachedDiskSpec | **object**<br><p>Required. Disk that should be attached.</p> 
attachedDiskSpec.<br>mode | **string**<br>The mode in which to attach this disk.<br><ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access. Default value.</li> </ul> 
attachedDiskSpec.<br>deviceName | **string**<br><p>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated.</p> <p>Value must match the regular expression ``[a-z][a-z0-9-_]{,19}``.</p> 
attachedDiskSpec.<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
attachedDiskSpec.<br>diskSpec | **object**<br>Disk specification. <br>`attachedDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
attachedDiskSpec.<br>diskSpec.<br>name | **string**<br><p>Name of the disk.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
attachedDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
attachedDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>ID of the disk type. To get a list of available disk types, use the <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
attachedDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Required. Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
attachedDiskSpec.<br>diskSpec.<br>blockSize | **string** (int64)<br><p>Block size of the disk, specified in bytes. The default is 4096.</p> 
attachedDiskSpec.<br>diskSpec.<br>diskPlacementPolicy | **object**<br>Placement policy configuration.
attachedDiskSpec.<br>diskSpec.<br>diskPlacementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
attachedDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`attachedDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image to create the disk from.</p> <p>The maximum string length in characters is 50.</p> 
attachedDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`attachedDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot to restore the disk from.</p> <p>The maximum string length in characters is 50.</p> 
attachedDiskSpec.<br>diskId | **string** <br>`attachedDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br><br><p>ID of the disk that should be attached.</p> <p>The maximum string length in characters is 50.</p> 
 
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