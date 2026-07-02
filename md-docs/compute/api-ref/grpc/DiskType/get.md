[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [DiskType](index.md) > Get

# Compute Cloud API, gRPC: DiskTypeService.Get

Returns the information about specified disk type.
To get the list of available disk types, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetDiskTypeRequest](#yandex.cloud.compute.v1.GetDiskTypeRequest)) returns ([DiskType](#yandex.cloud.compute.v1.DiskType))**

## GetDiskTypeRequest {#yandex.cloud.compute.v1.GetDiskTypeRequest}

```json
{
  "disk_type_id": "string"
}
```

#|
||Field | Description ||
|| disk_type_id | **string**

ID of the disk type to return information about.
To get the disk type ID use a [DiskTypeService.List](list.md#List) request.
This field is required. ||
|#

## DiskType {#yandex.cloud.compute.v1.DiskType}

```json
{
  "id": "string",
  "description": "string",
  "zone_ids": [
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
|| zone_ids[] | **string**

Array of availability zones where the disk type is available. ||
|#