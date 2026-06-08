---
editable: false
---

# Compute Cloud API, gRPC: DiskService.Relocate

Moves the specified disk to another availability zone
Disk must be detached from instances. To move attached
disk use [InstanceService.Relocate](/docs/compute/api-ref/grpc/Instance/relocate#Relocate) request.

## gRPC request

**rpc Relocate ([RelocateDiskRequest](#yandex.cloud.compute.v1.RelocateDiskRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RelocateDiskRequest {#yandex.cloud.compute.v1.RelocateDiskRequest}

```json
{
  "disk_id": "string",
  "destination_zone_id": "string",
  "disk_placement_policy": {
    "placement_group_id": "string",
    "placement_group_partition": "int64"
  }
}
```

#|
||Field | Description ||
|| disk_id | **string**

ID of the disk to move.
To get the disk ID, make a [DiskService.List](/docs/compute/api-ref/grpc/Disk/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| destination_zone_id | **string**

ID of the availability zone to move the disk to.
To get the zone ID, make a [ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| disk_placement_policy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration in target zone. Must be specified if disk has placement policy. ||
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