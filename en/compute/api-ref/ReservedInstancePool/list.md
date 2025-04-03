---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/ReservedInstancePool/list.md
---

# Compute Cloud API, REST: ReservedInstancePool.List

Retrieves the list of reserved instance pool resources in the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/reservedInstancePools
```

## Query parameters {#yandex.cloud.compute.v1.ListReservedInstancePoolsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the Folder to list reserved instance pools in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListReservedInstancePoolsResponse.nextPageToken](#yandex.cloud.compute.v1.ListReservedInstancePoolsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListReservedInstancePoolsResponse.nextPageToken](#yandex.cloud.compute.v1.ListReservedInstancePoolsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted. ||
|#

## Response {#yandex.cloud.compute.v1.ListReservedInstancePoolsResponse}

**HTTP Code: 200 - OK**

```json
{
  "reservedInstancePools": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| reservedInstancePools[] | **[ReservedInstancePool](#yandex.cloud.compute.v1.ReservedInstancePool)**

List of reserved instance pool resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListReservedInstancePoolsRequest.pageSize](#yandex.cloud.compute.v1.ListReservedInstancePoolsRequest), use
the `nextPageToken` as the value
for the [ListReservedInstancePoolsRequest.pageToken](#yandex.cloud.compute.v1.ListReservedInstancePoolsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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