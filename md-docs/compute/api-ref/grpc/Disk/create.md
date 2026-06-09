# Compute Cloud API, gRPC: DiskService.Create

Creates a disk in the specified folder.
You can create an empty disk or restore it from a snapshot or an image.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreateDiskRequest](#yandex.cloud.compute.v1.CreateDiskRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDiskRequest {#yandex.cloud.compute.v1.CreateDiskRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "type_id": "string",
  "zone_id": "string",
  "size": "int64",
  "block_size": "int64",
  // Includes only one of the fields `image_id`, `snapshot_id`
  "image_id": "string",
  "snapshot_id": "string",
  // end of the list of possible fields
  "disk_placement_policy": {
    "placement_group_id": "string",
    "placement_group_partition": "int64"
  },
  "snapshot_schedule_ids": [
    "string"
  ],
  "hardware_generation": {
    // Includes only one of the fields `legacy_features`, `generation2_features`
    "legacy_features": {
      "pci_topology": "PCITopology"
    },
    "generation2_features": "Generation2HardwareFeatures"
    // end of the list of possible fields
  },
  "kms_key_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a disk in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the disk.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| type_id | **string**

ID of the disk type.
To get a list of available disk types use the [yandex.cloud.compute.v1.DiskTypeService.List](../DiskType/list.md#List) request.
The length must be less than or equal to 50. ||
|| zone_id | **string**

ID of the availability zone where the disk resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](../Zone/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| size | **int64**

Size of the disk, specified in bytes.
If the disk was created from a image, this value should be more than the
[yandex.cloud.compute.v1.Image.min_disk_size](../Image/get.md#yandex.cloud.compute.v1.Image) value.
The value must be between 4194304 and 28587302322176.
This field is required. ||
|| block_size | **int64**

Block size used for disk, specified in bytes. The default is 4096. ||
|| image_id | **string**

ID of the image to create the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| snapshot_id | **string**

ID of the snapshot to restore the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| disk_placement_policy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| snapshot_schedule_ids[] | **string**

List of IDs of the snapshot schedules to attach the disk to. ||
|| hardware_generation | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

Specify the overrides to hardware_generation of a source disk, image or snapshot,
or to the default values if the source does not define it. ||
|| kms_key_id | **string**

ID of KMS key for disk encryption.
The length must be less than or equal to 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| placement_group_partition | **int64** ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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