---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/ReservedInstancePool/get.md
---

# Compute Cloud API, gRPC: ReservedInstancePoolService.Get

Returns the specified reserved instance pool resource.

To get the list of available reserved instance pool resources, make a [List](/docs/compute/api-ref/grpc/ReservedInstancePool/list#List) request.

## gRPC request

**rpc Get ([GetReservedInstancePoolRequest](#yandex.cloud.compute.v1.GetReservedInstancePoolRequest)) returns ([ReservedInstancePool](#yandex.cloud.compute.v1.ReservedInstancePool))**

## GetReservedInstancePoolRequest {#yandex.cloud.compute.v1.GetReservedInstancePoolRequest}

```json
{
  "reserved_instance_pool_id": "string"
}
```

#|
||Field | Description ||
|| reserved_instance_pool_id | **string**

Required field. ID of the reserved instance pool resource to return.
To get the reserved instance pool ID, use a [ReservedInstancePoolService.List](/docs/compute/api-ref/grpc/ReservedInstancePool/list#List) request. ||
|#

## ReservedInstancePool {#yandex.cloud.compute.v1.ReservedInstancePool}

```json
{
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
```

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