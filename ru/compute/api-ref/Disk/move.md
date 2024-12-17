---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Disk/move.md
---

# Compute Cloud API, REST: Disk.Move

Moves the specified disk to another folder of the same cloud.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/disks/{diskId}:move
```

## Path parameters

#|
||Field | Description ||
|| diskId | **string**

Required field. ID of the disk to move.

To get the disk ID, make a [DiskService.List](/docs/compute/api-ref/Disk/list#List) request. ||
|#

## Body parameters {#yandex.cloud.compute.v1.MoveDiskRequest}

```json
{
  "destinationFolderId": "string"
}
```

#|
||Field | Description ||
|| destinationFolderId | **string**

Required field. ID of the folder to move the disk to.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "diskId": "string",
    "sourceFolderId": "string",
    "destinationFolderId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "typeId": "string",
    "zoneId": "string",
    "size": "string",
    "blockSize": "string",
    "productIds": [
      "string"
    ],
    "status": "string",
    // Includes only one of the fields `sourceImageId`, `sourceSnapshotId`
    "sourceImageId": "string",
    "sourceSnapshotId": "string",
    // end of the list of possible fields
    "instanceIds": [
      "string"
    ],
    "diskPlacementPolicy": {
      "placementGroupId": "string",
      "placementGroupPartition": "string"
    },
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "string"
      },
      "generation2Features": "object"
      // end of the list of possible fields
    },
    "kmsKey": {
      "keyId": "string",
      "versionId": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[MoveDiskMetadata](#yandex.cloud.compute.v1.MoveDiskMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Disk](#yandex.cloud.compute.v1.Disk)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## MoveDiskMetadata {#yandex.cloud.compute.v1.MoveDiskMetadata}

#|
||Field | Description ||
|| diskId | **string**

ID of the disk that is being moved. ||
|| sourceFolderId | **string**

ID of the folder that the disk is being moved from. ||
|| destinationFolderId | **string**

ID of the folder that the disk is being moved to. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Disk {#yandex.cloud.compute.v1.Disk}

A Disk resource. For more information, see [Disks](/docs/compute/concepts/disk).

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| folderId | **string**

ID of the folder that the disk belongs to. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the disk. 1-63 characters long. ||
|| description | **string**

Description of the disk. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| typeId | **string**

ID of the disk type. ||
|| zoneId | **string**

ID of the availability zone where the disk resides. ||
|| size | **string** (int64)

Size of the disk, specified in bytes. ||
|| blockSize | **string** (int64)

Block size of the disk, specified in bytes. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/Image/create#Create) request. ||
|| status | **enum** (Status)

Current status of the disk.

- `STATUS_UNSPECIFIED`
- `CREATING`: Disk is being created.
- `READY`: Disk is ready to use.
- `ERROR`: Disk encountered a problem and cannot operate.
- `DELETING`: Disk is being deleted. ||
|| sourceImageId | **string**

ID of the image that was used for disk creation.

Includes only one of the fields `sourceImageId`, `sourceSnapshotId`. ||
|| sourceSnapshotId | **string**

ID of the snapshot that was used for disk creation.

Includes only one of the fields `sourceImageId`, `sourceSnapshotId`. ||
|| instanceIds[] | **string**

Array of instances to which the disk is attached. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this disk as a boot one. Otherwise the current default will be used. ||
|| kmsKey | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacyFeatures | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|| generation2Features | **object**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | **enum** (PCITopology)

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| keyId | **string**

ID of KMS symmetric key ||
|| versionId | **string**

Version of KMS symmetric key ||
|#