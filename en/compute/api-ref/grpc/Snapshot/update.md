---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Snapshot/update.md
---

# Compute Cloud API, gRPC: SnapshotService.Update {#Update}

Updates the specified snapshot.

Values of omitted parameters are not changed.

## gRPC request

**rpc Update ([UpdateSnapshotRequest](#yandex.cloud.compute.v1.UpdateSnapshotRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSnapshotRequest {#yandex.cloud.compute.v1.UpdateSnapshotRequest}

```json
{
  "snapshotId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string"
}
```

#|
||Field | Description ||
|| snapshotId | **string**

Required field. ID of the Snapshot resource to update.
To get the snapshot ID use a [SnapshotService.List](/docs/compute/api-ref/grpc/Snapshot/list#List) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Snapshot resource are going to be updated. ||
|| name | **string**

Name of the snapshot. ||
|| description | **string**

Description of the snapshot. ||
|| labels | **string**

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
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
    "snapshotId": "string"
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
    "storageSize": "int64",
    "diskSize": "int64",
    "productIds": [
      "string"
    ],
    "status": "Status",
    "sourceDiskId": "string",
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "PCITopology"
      },
      "generation2Features": "Generation2HardwareFeatures"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateSnapshotMetadata](#yandex.cloud.compute.v1.UpdateSnapshotMetadata)**

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
|| response | **[Snapshot](#yandex.cloud.compute.v1.Snapshot)**

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

## UpdateSnapshotMetadata {#yandex.cloud.compute.v1.UpdateSnapshotMetadata}

#|
||Field | Description ||
|| snapshotId | **string**

ID of the Snapshot resource that is being updated. ||
|#

## Snapshot {#yandex.cloud.compute.v1.Snapshot}

A Snapshot resource. For more information, see [Snapshots](/docs/compute/concepts/snapshot).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot. ||
|| folderId | **string**

ID of the folder that the snapshot belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the snapshot. 1-63 characters long. ||
|| description | **string**

Description of the snapshot. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| storageSize | **int64**

Size of the snapshot, specified in bytes. ||
|| diskSize | **int64**

Size of the disk when the snapshot was created, specified in bytes. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/Image/create#Create) request. ||
|| status | enum **Status**

Current status of the snapshot.

- `STATUS_UNSPECIFIED`
- `CREATING`: Snapshot is being created.
- `READY`: Snapshot is ready to use.
- `ERROR`: Snapshot encountered a problem and cannot operate.
- `DELETING`: Snapshot is being deleted. ||
|| sourceDiskId | **string**

ID of the source disk used to create this snapshot. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this snapshot as source for the boot disk. Otherwise the current default will be used. ||
|| kmsKey | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
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

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| keyId | **string**

ID of KMS symmetric key ||
|| versionId | **string**

Version of KMS symmetric key ||
|#