[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Instance](index.md) > AttachDisk

# Compute Cloud API, gRPC: InstanceService.AttachDisk

Attaches the disk to the instance.

## gRPC request

**rpc AttachDisk ([AttachInstanceDiskRequest](#yandex.cloud.compute.v1.AttachInstanceDiskRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AttachInstanceDiskRequest {#yandex.cloud.compute.v1.AttachInstanceDiskRequest}

```json
{
  "instance_id": "string",
  "attached_disk_spec": {
    "mode": "Mode",
    "device_name": "string",
    "auto_delete": "bool",
    // Includes only one of the fields `disk_spec`, `disk_id`
    "disk_spec": {
      "name": "string",
      "description": "string",
      "type_id": "string",
      "size": "int64",
      "block_size": "int64",
      "disk_placement_policy": {
        "placement_group_id": "string",
        "placement_group_partition": "int64"
      },
      // Includes only one of the fields `image_id`, `snapshot_id`
      "image_id": "string",
      "snapshot_id": "string",
      // end of the list of possible fields
      "kms_key_id": "string"
    },
    "disk_id": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| instance_id | **string**

ID of the instance to attach the disk to.
To get the instance ID, use a [InstanceService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| attached_disk_spec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Disk that should be attached.
This field is required. ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

The mode in which to attach this disk.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| device_name | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.
This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated.
The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`. ||
|| auto_delete | **bool**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| disk_spec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `disk_spec`, `disk_id`.

Only one field must by specified. ||
|| disk_id | **string**

ID of the disk that should be attached.
The length must be less than or equal to 50.

Includes only one of the fields `disk_spec`, `disk_id`.

Only one field must by specified. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| type_id | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](../DiskType/list.md#List) request.
The length must be less than or equal to 50. ||
|| size | **int64**

Size of the disk, specified in bytes.
The value must be between 4194304 and 4398046511104.
This field is required. ||
|| block_size | **int64**

Block size of the disk, specified in bytes. The default is 4096. ||
|| disk_placement_policy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| image_id | **string**

ID of the image to create the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| snapshot_id | **string**

ID of the snapshot to restore the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| kms_key_id | **string**

ID of KMS key for disk encryption
The length must be less than or equal to 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| placement_group_partition | **int64** ||
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