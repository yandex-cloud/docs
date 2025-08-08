---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/ReservedInstancePool/update.md
---

# Compute Cloud API, gRPC: ReservedInstancePoolService.Update

Updates the specified reserved instance pool.

## gRPC request

**rpc Update ([UpdateReservedInstancePoolRequest](#yandex.cloud.compute.v1.UpdateReservedInstancePoolRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateReservedInstancePoolRequest {#yandex.cloud.compute.v1.UpdateReservedInstancePoolRequest}

```json
{
  "reserved_instance_pool_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "size": "int64",
  "allow_oversubscription": "bool",
  "allow_pending_slots": "bool"
}
```

#|
||Field | Description ||
|| reserved_instance_pool_id | **string**

Required field. ID of the reserved instance pool to update.
To get the reserved instance pool ID, use a [ReservedInstancePoolService.List](/docs/compute/api-ref/grpc/ReservedInstancePool/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the reserved instance pool should be updated. ||
|| name | **string**

New name for the reserved instance pool. ||
|| description | **string**

Description of the reserved instance pool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|| size | **int64**

Desired size of the pool. ||
|| allow_oversubscription | **bool**

Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
While running instances are still limited by available slots, stopped instances can exceed this limit.
Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|| allow_pending_slots | **bool**

This field affects only the current request and allows size-increasing operation to complete successfully even when there are not enough resources.
In such cases, some of the new pool slots become "pending", meaning they cannot be used until resources become available.
Pending slots automatically convert to normal slots when sufficient resources are available. ||
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
    "reserved_instance_pool_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "zone_id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
    "platform_id": "string",
    "resources_spec": {
      "memory": "int64",
      "cores": "int64",
      "core_fraction": "int64",
      "gpus": "int64"
    },
    "gpu_settings": {
      "gpu_cluster_id": "string"
    },
    "product_ids": [
      "string"
    ],
    "network_settings": {
      "type": "Type"
    },
    "size": "int64",
    "committed_size": "int64",
    "allow_oversubscription": "bool",
    "slot_stats": {
      "total": "int64",
      "used": "int64",
      "available": "int64",
      "unavailable": "int64",
      "pending": "int64"
    },
    "instance_stats": {
      "total": "int64"
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
|| metadata | **[UpdateReservedInstancePoolMetadata](#yandex.cloud.compute.v1.UpdateReservedInstancePoolMetadata)**

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
|| response | **[ReservedInstancePool](#yandex.cloud.compute.v1.ReservedInstancePool)**

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

## UpdateReservedInstancePoolMetadata {#yandex.cloud.compute.v1.UpdateReservedInstancePoolMetadata}

#|
||Field | Description ||
|| reserved_instance_pool_id | **string**

ID of the reserved instance pool that is being updated. ||
|#

## ReservedInstancePool {#yandex.cloud.compute.v1.ReservedInstancePool}

A Reserved Instance Pool resource.

#|
||Field | Description ||
|| id | **string**

ID of the pool. ||
|| zone_id | **string**

ID of the availability zone where the pool resides. ||
|| cloud_id | **string**

ID of the cloud that the pool belongs to. ||
|| folder_id | **string**

ID of the folder that the pool belongs to. ||
|| name | **string**

Name of the pool. 1-63 characters long. ||
|| description | **string**

Description of the pool. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| platform_id | **string**

ID of the hardware platform configuration for pool instances. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of pool instances, such as the amount of memory and number of cores. ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| product_ids[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network Settings. ||
|| size | **int64**

Desired size of the pool (number of slots for instances in this pool). ||
|| committed_size | **int64**

Equals to the size field except when updates occur with allow_pending=true. In those cases, committed_size equals only the number of non-pending slots. ||
|| allow_oversubscription | **bool**

Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
While running instances are still limited by available slots, stopped instances can exceed this limit.
Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|| slot_stats | **[SlotStats](#yandex.cloud.compute.v1.ReservedInstancePool.SlotStats)**

Statuses of the pool slots ||
|| instance_stats | **[InstanceStats](#yandex.cloud.compute.v1.ReservedInstancePool.InstanceStats)**

Stats for instances of the pool ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

Required field. The amount of memory available to the instance, specified in bytes. ||
|| cores | **int64**

Required field. The number of cores available to the instance. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpus | **int64**

The number of GPUs available to the instance. ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

Attach instance to specified GPU cluster. ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## SlotStats {#yandex.cloud.compute.v1.ReservedInstancePool.SlotStats}

#|
||Field | Description ||
|| total | **int64**

Equals to pool size (and equals to the sum of the following fields) ||
|| used | **int64**

Number of slots used by running instances ||
|| available | **int64**

Number of slots available for instances (but not currently used) ||
|| unavailable | **int64**

Number of slots unavailable for some reason (for example because of underlying host failure) ||
|| pending | **int64**

Number of slots requested for async update, but still waiting for resources and not yet available for usage ||
|#

## InstanceStats {#yandex.cloud.compute.v1.ReservedInstancePool.InstanceStats}

#|
||Field | Description ||
|| total | **int64**

Total number of instances linked to the pool ||
|#