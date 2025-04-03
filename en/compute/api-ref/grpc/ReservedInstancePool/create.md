---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/ReservedInstancePool/create.md
---

# Compute Cloud API, gRPC: ReservedInstancePoolService.Create

Creates an reserved instance pool in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreateReservedInstancePoolRequest](#yandex.cloud.compute.v1.CreateReservedInstancePoolRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateReservedInstancePoolRequest {#yandex.cloud.compute.v1.CreateReservedInstancePoolRequest}

```json
{
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone_id": "string",
  "folder_id": "string",
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
  "boot_disk_spec": {
    // Includes only one of the fields `disk_id`, `image_id`, `snapshot_id`, `product_ids`
    "disk_id": "string",
    "image_id": "string",
    "snapshot_id": "string",
    "product_ids": {
      "product_ids": [
        "string"
      ]
    }
    // end of the list of possible fields
  },
  "network_settings": {
    "type": "Type"
  },
  "size": "int64"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the reserved instance pool. ||
|| description | **string**

Description of the reserved instance pool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Required field. ID of the availability zone where the reserved instance pool resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request ||
|| folder_id | **string**

Required field. ID of the folder to create the reserved instance pool in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| platform_id | **string**

Required field. ID of the hardware platform configuration for the reserved instance pool.
This field affects the available values in `resources_spec` field.

For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Required field. Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| boot_disk_spec | **[BootDiskSpec](#yandex.cloud.compute.v1.BootDiskSpec)**

Spec is used to determine which License IDs should be allowed for instances created in the pool. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| size | **int64**

Desired size of the pool (number of slots for instances in this pool). ||
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

## BootDiskSpec {#yandex.cloud.compute.v1.BootDiskSpec}

Specification used to determine required product_ids
You can specify product ids explicitly or use disk_id|image_id|snapshot_id to infer products ids from them.

#|
||Field | Description ||
|| disk_id | **string**

Disk ID.

Includes only one of the fields `disk_id`, `image_id`, `snapshot_id`, `product_ids`. ||
|| image_id | **string**

Image ID.

Includes only one of the fields `disk_id`, `image_id`, `snapshot_id`, `product_ids`. ||
|| snapshot_id | **string**

Snapshot ID.

Includes only one of the fields `disk_id`, `image_id`, `snapshot_id`, `product_ids`. ||
|| product_ids | **[ProductIDs](#yandex.cloud.compute.v1.ProductIDs)**

Product IDs.

Includes only one of the fields `disk_id`, `image_id`, `snapshot_id`, `product_ids`. ||
|#

## ProductIDs {#yandex.cloud.compute.v1.ProductIDs}

#|
||Field | Description ||
|| product_ids[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
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
    "size": "int64"
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
|| metadata | **[CreateReservedInstancePoolMetadata](#yandex.cloud.compute.v1.CreateReservedInstancePoolMetadata)**

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

## CreateReservedInstancePoolMetadata {#yandex.cloud.compute.v1.CreateReservedInstancePoolMetadata}

#|
||Field | Description ||
|| reserved_instance_pool_id | **string**

ID of the reserved instance pool that is being created. ||
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
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec2)**

Computing resources of pool instances, such as the amount of memory and number of cores. ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings2)**

GPU settings. ||
|| product_ids[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings2)**

Network Settings. ||
|| size | **int64**

Desired size of the pool (number of slots for instances in this pool). ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec2}

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

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings2}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

Attach instance to specified GPU cluster. ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings2}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#