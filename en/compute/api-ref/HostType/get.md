---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostType/get.md
---

# Compute Cloud API, REST: HostType.Get {#Get}

Returns information about specified host type.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostTypes/{hostTypeId}
```

## Path parameters

#|
||Field | Description ||
|| hostTypeId | **string**

Required field. ID of the host type to return.

To get a host type ID make a [HostTypeService.List](/docs/compute/api-ref/HostType/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.HostType}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cores": "string",
  "memory": "string",
  "disks": "string",
  "diskSize": "string"
}
```

Represents host resources.
Note: Platform can use hosts with different number of memory and cores.
TODO: Do we need sockets here?

#|
||Field | Description ||
|| id | **string**

Unique type identifier. ||
|| cores | **string** (int64)

Total number of cores available for instances. ||
|| memory | **string** (int64)

Ammount of memory available for instances. ||
|| disks | **string** (int64)

Number of local disks available for instances ||
|| diskSize | **string** (int64)

Size of each local disk ||
|#