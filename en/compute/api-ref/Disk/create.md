---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Disk/create.md
---

# Compute Cloud API, REST: Disk.create
Creates a disk in the specified folder.
 
You can create an empty disk or restore it from a snapshot or an image.
Method starts an asynchronous operation that can be cancelled while it is in progress.
 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/disks
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "blockSize": "string",
  "diskPlacementPolicy": {
    "placementGroupId": "string",
    "placementGroupPartition": "string"
  },
  "snapshotScheduleIds": [
    "string"
  ],
  "hardwareGeneration": {

    // `hardwareGeneration` includes only one of the fields `legacyFeatures`, `generation2Features`
    "legacyFeatures": {
      "pciTopology": "string"
    },
    "generation2Features": {},
    // end of the list of possible fields`hardwareGeneration`

  },

  //  includes only one of the fields `imageId`, `snapshotId`
  "imageId": "string",
  "snapshotId": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a disk in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the disk.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
typeId | **string**<br><p>ID of the disk type. To get a list of available disk types use the <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
zoneId | **string**<br><p>Required. ID of the availability zone where the disk resides. To get a list of available zones use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
size | **string** (int64)<br><p>Required. Size of the disk, specified in bytes. If the disk was created from a image, this value should be more than the <a href="/docs/compute/api-ref/Image#representation">Image.minDiskSize</a> value.</p> <p>Acceptable values are 4194304 to 28587302322176, inclusive.</p> 
blockSize | **string** (int64)<br><p>Block size used for disk, specified in bytes. The default is 4096.</p> 
diskPlacementPolicy | **object**<br>Placement policy configuration.
diskPlacementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
diskPlacementPolicy.<br>placementGroupPartition | **string** (int64)
snapshotScheduleIds[] | **string**<br><p>List of IDs of the snapshot schedules to attach the disk to.</p> 
hardwareGeneration | **object**<br>Specify the overrides to hardware_generation of a source disk, image or snapshot, or to the default values if the source does not define it.
hardwareGeneration.<br>legacyFeatures | **object** <br>`hardwareGeneration` includes only one of the fields `legacyFeatures`, `generation2Features`<br><br><p>A first hardware generation, by default compatible with all legacy images. Allows switching to PCI_TOPOLOGY_V2 and back.</p> 
hardwareGeneration.<br>legacyFeatures.<br>pciTopology | **string**
hardwareGeneration.<br>generation2Features | **object** <br>`hardwareGeneration` includes only one of the fields `legacyFeatures`, `generation2Features`<br><br><p>A second hardware generation, which by default assumes PCI_TOPOLOGY_V2 and UEFI boot (with UEFI related features).</p> 
imageId | **string** <br> includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image to create the disk from.</p> <p>The maximum string length in characters is 50.</p> 
snapshotId | **string** <br> includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot to restore the disk from.</p> <p>The maximum string length in characters is 50.</p> 
 
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