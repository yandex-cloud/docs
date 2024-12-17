---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Snapshot/create.md
---

# Compute Cloud API, gRPC: SnapshotService.Create

Creates a snapshot of the specified disk.

## gRPC request

**rpc Create ([CreateSnapshotRequest](#yandex.cloud.compute.v1.CreateSnapshotRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSnapshotRequest {#yandex.cloud.compute.v1.CreateSnapshotRequest}

```json
{
  "folder_id": "string",
  "disk_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "hardware_generation": {
    // Includes only one of the fields `legacy_features`, `generation2_features`
    "legacy_features": {
      "pci_topology": "PCITopology"
    },
    "generation2_features": "Generation2HardwareFeatures"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a snapshot in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| disk_id | **string**

Required field. ID of the disk to create the snapshot from.
To get the disk ID use a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/grpc/Disk/list#List) request. ||
|| name | **string**

Name of the snapshot. ||
|| description | **string**

Description of the snapshot. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| hardware_generation | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

Specify the overrides to hardware_generation of a source disk, image or snapshot,
or to the default values if the source does not define it. ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacy_features | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|| generation2_features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pci_topology | enum **PCITopology**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "snapshot_id": "string",
    "disk_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "storage_size": "int64",
    "disk_size": "int64",
    "product_ids": [
      "string"
    ],
    "status": "Status",
    "source_disk_id": "string",
    "hardware_generation": {
      // Includes only one of the fields `legacy_features`, `generation2_features`
      "legacy_features": {
        "pci_topology": "PCITopology"
      },
      "generation2_features": "Generation2HardwareFeatures"
      // end of the list of possible fields
    },
    "kms_key": {
      "key_id": "string",
      "version_id": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSnapshotMetadata](#yandex.cloud.compute.v1.CreateSnapshotMetadata)**

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

## CreateSnapshotMetadata {#yandex.cloud.compute.v1.CreateSnapshotMetadata}

#|
||Field | Description ||
|| snapshot_id | **string**

ID of the snapshot that is being created. ||
|| disk_id | **string**

ID of the source disk used to create this snapshot. ||
|#

## Snapshot {#yandex.cloud.compute.v1.Snapshot}

A Snapshot resource. For more information, see [Snapshots](/docs/compute/concepts/snapshot).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot. ||
|| folder_id | **string**

ID of the folder that the snapshot belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the snapshot. 1-63 characters long. ||
|| description | **string**

Description of the snapshot. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| storage_size | **int64**

Size of the snapshot, specified in bytes. ||
|| disk_size | **int64**

Size of the disk when the snapshot was created, specified in bytes. ||
|| product_ids[] | **string**

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
|| source_disk_id | **string**

ID of the source disk used to create this snapshot. ||
|| hardware_generation | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration2)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this snapshot as source for the boot disk. Otherwise the current default will be used. ||
|| kms_key | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration2}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacy_features | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures2)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|| generation2_features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures2)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures2}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pci_topology | enum **PCITopology**

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Generation2HardwareFeatures {#yandex.cloud.compute.v1.Generation2HardwareFeatures2}

A second hardware generation, which by default assumes PCI_TOPOLOGY_V2
and UEFI boot (with UEFI related features).

#|
||Field | Description ||
|| Empty | > ||
|#

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| key_id | **string**

ID of KMS symmetric key ||
|| version_id | **string**

Version of KMS symmetric key ||
|#