---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Disk/update.md
---

# Compute Cloud API, gRPC: DiskService.Update {#Update}

Updates the specified disk.

## gRPC request

**rpc Update ([UpdateDiskRequest](#yandex.cloud.compute.v1.UpdateDiskRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDiskRequest {#yandex.cloud.compute.v1.UpdateDiskRequest}

```json
{
  "diskId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "size": "int64",
  "diskPlacementPolicy": {
    "placementGroupId": "string",
    "placementGroupPartition": "int64"
  }
}
```

#|
||Field | Description ||
|| diskId | **string**

Required field. ID of the Disk resource to update.
To get the disk ID use a [DiskService.List](/docs/compute/api-ref/grpc/Disk/list#List) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Disk resource are going to be updated. ||
|| name | **string**

Name of the disk. ||
|| description | **string**

Description of the disk. ||
|| labels | **string**

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **int64** ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "diskId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "typeId": "string",
    "zoneId": "string",
    "size": "int64",
    "blockSize": "int64",
    "productIds": [
      "string"
    ],
    "status": "Status",
    // Includes only one of the fields `sourceImageId`, `sourceSnapshotId`
    "sourceImageId": "string",
    "sourceSnapshotId": "string",
    // end of the list of possible fields
    "instanceIds": [
      "string"
    ],
    "diskPlacementPolicy": {
      "placementGroupId": "string",
      "placementGroupPartition": "int64"
    },
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "PCITopology"
      },
      "generation2Features": "Generation2HardwareFeatures"
      // end of the list of possible fields
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateDiskMetadata](#yandex.cloud.compute.v1.UpdateDiskMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## UpdateDiskMetadata {#yandex.cloud.compute.v1.UpdateDiskMetadata}

#|
||Field | Description ||
|| diskId | **string**

ID of the Disk resource that is being updated. ||
|#

## Disk {#yandex.cloud.compute.v1.Disk}

A Disk resource. For more information, see [Disks](/docs/compute/concepts/disk).

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| folderId | **string**

ID of the folder that the disk belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the disk. 1-63 characters long. ||
|| description | **string**

Description of the disk. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| typeId | **string**

ID of the disk type. ||
|| zoneId | **string**

ID of the availability zone where the disk resides. ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| blockSize | **int64**

Block size of the disk, specified in bytes. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/Image/create#Create) request. ||
|| status | enum **Status**

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
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy2)**

Placement policy configuration. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this disk as a boot one. Otherwise the current default will be used. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy2}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **int64** ||
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
|| generation2Features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | enum **PCITopology**

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Generation2HardwareFeatures {#yandex.cloud.compute.v1.Generation2HardwareFeatures}

A second hardware generation, which by default assumes PCI_TOPOLOGY_V2
and UEFI boot (with UEFI related features).

#|
||Field | Description ||
|| Empty | > ||
|#