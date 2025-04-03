---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/ReservedInstancePool/get.md
---

# Compute Cloud API, REST: ReservedInstancePool.Get

Returns the specified reserved instance pool resource.

To get the list of available reserved instance pool resources, make a [List](/docs/compute/api-ref/ReservedInstancePool/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/reservedInstancePools/{reservedInstancePoolId}
```

## Path parameters

#|
||Field | Description ||
|| reservedInstancePoolId | **string**

Required field. ID of the reserved instance pool resource to return.
To get the reserved instance pool ID, use a [ReservedInstancePoolService.List](/docs/compute/api-ref/ReservedInstancePool/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.ReservedInstancePool}

**HTTP Code: 200 - OK**

```json
{
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
  "size": "string"
}
```

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
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of pool instances, such as the amount of memory and number of cores. ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to resource.
License IDs are used to calculate additional charges for the use of the virtual machine. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network Settings. ||
|| size | **string** (int64)

Desired size of the pool (number of slots for instances in this pool). ||
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