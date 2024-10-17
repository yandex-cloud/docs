---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskType/get.md
---

# Compute Cloud API, gRPC: DiskTypeService.Get {#Get}

Returns the information about specified disk type.

To get the list of available disk types, make a [List](/docs/compute/api-ref/grpc/DiskType/list#List) request.

## gRPC request

**rpc Get ([GetDiskTypeRequest](#yandex.cloud.compute.v1.GetDiskTypeRequest)) returns ([DiskType](#yandex.cloud.compute.v1.DiskType))**

## GetDiskTypeRequest {#yandex.cloud.compute.v1.GetDiskTypeRequest}

```json
{
  "diskTypeId": "string"
}
```

#|
||Field | Description ||
|| diskTypeId | **string**

Required field. ID of the disk type to return information about.
To get the disk type ID use a [DiskTypeService.List](/docs/compute/api-ref/grpc/DiskType/list#List) request. ||
|#

## DiskType {#yandex.cloud.compute.v1.DiskType}

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