---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/DiskType/get.md
---

# Compute Cloud API, REST: DiskType.Get

Returns the information about specified disk type.

To get the list of available disk types, make a [List](/docs/compute/api-ref/DiskType/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/diskTypes/{diskTypeId}
```

## Path parameters

#|
||Field | Description ||
|| diskTypeId | **string**

Required field. ID of the disk type to return information about.
To get the disk type ID use a [DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.DiskType}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "zoneIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| id | **string**

ID of the disk type. ||
|| description | **string**

Description of the disk type. 0-256 characters long. ||
|| zoneIds[] | **string**

Array of availability zones where the disk type is available. ||
|#