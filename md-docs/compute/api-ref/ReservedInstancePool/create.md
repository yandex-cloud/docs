# Compute Cloud API, REST: ReservedInstancePool.Create

Creates an reserved instance pool in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://compute.api.cloud.yandex.net/compute/v1/reservedInstancePools
```

## Body parameters {#yandex.cloud.compute.v1.CreateReservedInstancePoolRequest}

```json
{
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "folderId": "string",
  "platformId": "string",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string",
    "gpus": "string"
  },
  "gpuSettings": {
    "gpuClusterId": "string"
  },
  "bootDiskSpec": {
    // Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`
    "diskId": "string",
    "imageId": "string",
    "snapshotId": "string",
    "productIds": {
      "productIds": [
        "string"
      ]
    }
    // end of the list of possible fields
  },
  "networkSettings": {
    "type": "string"
  },
  "size": "string",
  "allowOversubscription": "boolean"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the reserved instance pool.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the reserved instance pool.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| zoneId | **string**

ID of the availability zone where the reserved instance pool resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](../Zone/list.md#List) request
The length must be less than or equal to 50.
This field is required. ||
|| folderId | **string**

ID of the folder to create the reserved instance pool in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| platformId | **string**

ID of the hardware platform configuration for the reserved instance pool.
This field affects the available values in `resourcesSpec` field.
For more information, see [Platforms](../../concepts/vm-platforms.md).
This field is required. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](../../concepts/performance-levels.md).
This field is required. ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| bootDiskSpec | **[BootDiskSpec](#yandex.cloud.compute.v1.BootDiskSpec)**

Spec is used to determine which License IDs should be allowed for instances created in the pool. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| size | **string** (int64)

Desired size of the pool (number of slots for instances in this pool).
The value must be between 0 and 1048576. ||
|| allowOversubscription | **boolean**

Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
While running instances are still limited by available slots, stopped instances can exceed this limit.
Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

The amount of memory available to the instance, specified in bytes.
The value must be less than or equal to 274877906944.
This field is required. ||
|| cores | **string** (int64)

The number of cores available to the instance.
The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
This field is required. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](../../concepts/performance-levels.md).
The value must satisfy: 0,5,20,50,100. ||
|| gpus | **string** (int64)

The number of GPUs available to the instance.
The value must satisfy: 0,1,2,4. ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string**

Attach instance to specified GPU cluster. ||
|#

## BootDiskSpec {#yandex.cloud.compute.v1.BootDiskSpec}

Specification used to determine required product_ids
You can specify product ids explicitly or use disk_id|image_id|snapshot_id to infer products ids from them.

#|
||Field | Description ||
|| diskId | **string**

Disk ID.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.

Only one field must by specified. ||
|| imageId | **string**

Image ID.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.

Only one field must by specified. ||
|| snapshotId | **string**

Snapshot ID.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.

Only one field must by specified. ||
|| productIds | **[ProductIDs](#yandex.cloud.compute.v1.ProductIDs)**

Product IDs.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.

Only one field must by specified. ||
|#

## ProductIDs {#yandex.cloud.compute.v1.ProductIDs}

#|
||Field | Description ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Network Type

- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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