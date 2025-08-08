---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/reservedInstancePools
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Name of the reserved instance pool.
          pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the reserved instance pool.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        zoneId:
          description: |-
            **string**
            Required field. ID of the availability zone where the reserved instance pool resides.
            To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request
          type: string
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the reserved instance pool in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        platformId:
          description: |-
            **string**
            Required field. ID of the hardware platform configuration for the reserved instance pool.
            This field affects the available values in `resourcesSpec` field.
            For more information, see [Platforms](/docs/compute/concepts/vm-platforms).
          type: string
        resourcesSpec:
          description: |-
            **[ResourcesSpec](/docs/compute/api-ref/Instance/create#yandex.cloud.compute.v1.ResourcesSpec)**
            Required field. Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores.
            To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels).
          $ref: '#/definitions/ResourcesSpec'
        gpuSettings:
          description: |-
            **[GpuSettings](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.GpuSettings)**
            GPU settings.
          $ref: '#/definitions/GpuSettings'
        bootDiskSpec:
          description: |-
            **[BootDiskSpec](/docs/compute/api-ref/ReservedInstancePool/create#yandex.cloud.compute.v1.BootDiskSpec)**
            Spec is used to determine which License IDs should be allowed for instances created in the pool.
          oneOf:
            - type: object
              properties:
                diskId:
                  description: |-
                    **string**
                    Disk ID.
                    Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.
                  type: string
                imageId:
                  description: |-
                    **string**
                    Image ID.
                    Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.
                  type: string
                snapshotId:
                  description: |-
                    **string**
                    Snapshot ID.
                    Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.
                  type: string
                productIds:
                  description: |-
                    **[ProductIDs](/docs/compute/api-ref/ReservedInstancePool/create#yandex.cloud.compute.v1.ProductIDs)**
                    Product IDs.
                    Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`.
                  $ref: '#/definitions/ProductIDs'
        networkSettings:
          description: |-
            **[NetworkSettings](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.NetworkSettings)**
            Network settings.
          $ref: '#/definitions/NetworkSettings'
        size:
          description: |-
            **string** (int64)
            Desired size of the pool (number of slots for instances in this pool).
          type: string
          format: int64
        allowOversubscription:
          description: |-
            **boolean**
            Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
            While running instances are still limited by available slots, stopped instances can exceed this limit.
            Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error.
          type: boolean
      required:
        - zoneId
        - folderId
        - platformId
        - resourcesSpec
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Required field. The amount of memory available to the instance, specified in bytes.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              Required field. The number of cores available to the instance.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the ability to burst performance above that baseline level.
              This field sets baseline performance for each core.
              For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
              For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels).
            type: string
            format: int64
          gpus:
            description: |-
              **string** (int64)
              The number of GPUs available to the instance.
            type: string
            format: int64
        required:
          - memory
          - cores
      GpuSettings:
        type: object
        properties:
          gpuClusterId:
            description: |-
              **string**
              Attach instance to specified GPU cluster.
            type: string
      ProductIDs:
        type: object
        properties:
          productIds:
            description: |-
              **string**
              License IDs that indicate which licenses are attached to resource.
              License IDs are used to calculate additional charges for the use of the virtual machine.
            type: array
            items:
              type: string
      NetworkSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Network Type
              - `TYPE_UNSPECIFIED`
              - `STANDARD`: Standard network.
              - `SOFTWARE_ACCELERATED`: Software accelerated network.
              - `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - STANDARD
              - SOFTWARE_ACCELERATED
              - HARDWARE_ACCELERATED
sourcePath: en/_api-ref/compute/v1/api-ref/ReservedInstancePool/create.md
---

# Compute Cloud API, REST: ReservedInstancePool.Create

Creates an reserved instance pool in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/reservedInstancePools
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

Name of the reserved instance pool. ||
|| description | **string**

Description of the reserved instance pool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Required field. ID of the availability zone where the reserved instance pool resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request ||
|| folderId | **string**

Required field. ID of the folder to create the reserved instance pool in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the reserved instance pool.
This field affects the available values in `resourcesSpec` field.

For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Required field. Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| bootDiskSpec | **[BootDiskSpec](#yandex.cloud.compute.v1.BootDiskSpec)**

Spec is used to determine which License IDs should be allowed for instances created in the pool. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| size | **string** (int64)

Desired size of the pool (number of slots for instances in this pool). ||
|| allowOversubscription | **boolean**

Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
While running instances are still limited by available slots, stopped instances can exceed this limit.
Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

Required field. The amount of memory available to the instance, specified in bytes. ||
|| cores | **string** (int64)

Required field. The number of cores available to the instance. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpus | **string** (int64)

The number of GPUs available to the instance. ||
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

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`. ||
|| imageId | **string**

Image ID.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`. ||
|| snapshotId | **string**

Snapshot ID.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`. ||
|| productIds | **[ProductIDs](#yandex.cloud.compute.v1.ProductIDs)**

Product IDs.

Includes only one of the fields `diskId`, `imageId`, `snapshotId`, `productIds`. ||
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

- `TYPE_UNSPECIFIED`
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
  "metadata": {
    "reservedInstancePoolId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "zoneId": "string",
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdAt": "string",
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
    "productIds": [
      "string"
    ],
    "networkSettings": {
      "type": "string"
    },
    "size": "string",
    "committedSize": "string",
    "allowOversubscription": "boolean",
    "slotStats": {
      "total": "string",
      "used": "string",
      "available": "string",
      "unavailable": "string",
      "pending": "string"
    },
    "instanceStats": {
      "total": "string"
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
|| metadata | **[CreateReservedInstancePoolMetadata](#yandex.cloud.compute.v1.CreateReservedInstancePoolMetadata)**

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
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that is being created. ||
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

## ReservedInstancePool {#yandex.cloud.compute.v1.ReservedInstancePool}

A Reserved Instance Pool resource.

#|
||Field | Description ||
|| id | **string**

ID of the pool. ||
|| zoneId | **string**

ID of the availability zone where the pool resides. ||
|| cloudId | **string**

ID of the cloud that the pool belongs to. ||
|| folderId | **string**

ID of the folder that the pool belongs to. ||
|| name | **string**

Name of the pool. 1-63 characters long. ||
|| description | **string**

Description of the pool. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| platformId | **string**

ID of the hardware platform configuration for pool instances. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec2)**

Computing resources of pool instances, such as the amount of memory and number of cores. ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings2)**

GPU settings. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings2)**

Network Settings. ||
|| size | **string** (int64)

Desired size of the pool (number of slots for instances in this pool). ||
|| committedSize | **string** (int64)

Equals to the size field except when updates occur with allow_pending=true. In those cases, committed_size equals only the number of non-pending slots. ||
|| allowOversubscription | **boolean**

Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
While running instances are still limited by available slots, stopped instances can exceed this limit.
Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|| slotStats | **[SlotStats](#yandex.cloud.compute.v1.ReservedInstancePool.SlotStats)**

Statuses of the pool slots ||
|| instanceStats | **[InstanceStats](#yandex.cloud.compute.v1.ReservedInstancePool.InstanceStats)**

Stats for instances of the pool ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec2}

#|
||Field | Description ||
|| memory | **string** (int64)

Required field. The amount of memory available to the instance, specified in bytes. ||
|| cores | **string** (int64)

Required field. The number of cores available to the instance. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpus | **string** (int64)

The number of GPUs available to the instance. ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings2}

#|
||Field | Description ||
|| gpuClusterId | **string**

Attach instance to specified GPU cluster. ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings2}

#|
||Field | Description ||
|| type | **enum** (Type)

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## SlotStats {#yandex.cloud.compute.v1.ReservedInstancePool.SlotStats}

#|
||Field | Description ||
|| total | **string** (int64)

Equals to pool size (and equals to the sum of the following fields) ||
|| used | **string** (int64)

Number of slots used by running instances ||
|| available | **string** (int64)

Number of slots available for instances (but not currently used) ||
|| unavailable | **string** (int64)

Number of slots unavailable for some reason (for example because of underlying host failure) ||
|| pending | **string** (int64)

Number of slots requested for async update, but still waiting for resources and not yet available for usage ||
|#

## InstanceStats {#yandex.cloud.compute.v1.ReservedInstancePool.InstanceStats}

#|
||Field | Description ||
|| total | **string** (int64)

Total number of instances linked to the pool ||
|#