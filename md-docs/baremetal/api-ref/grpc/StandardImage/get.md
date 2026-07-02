[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [StandardImage](index.md) > Get

# BareMetal API, gRPC: StandardImageService.Get

Returns the specific standard Image resource.
To get the list of standard  resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetStandardImageRequest](#yandex.cloud.baremetal.v1alpha.GetStandardImageRequest)) returns ([StandardImage](#yandex.cloud.baremetal.v1alpha.StandardImage))**

## GetStandardImageRequest {#yandex.cloud.baremetal.v1alpha.GetStandardImageRequest}

```json
{
  "standard_image_id": "string"
}
```

#|
||Field | Description ||
|| standard_image_id | **string**

ID of the StandardImage resource to return.
To get the standard image ID, use a [StandardImageService.List](list.md#List) request.

The maximum string length in characters is 20. ||
|#

## StandardImage {#yandex.cloud.baremetal.v1alpha.StandardImage}

```json
{
  "id": "string",
  "name": "string",
  "folder_id": "string"
}
```

A Standard Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the standard image. ||
|| name | **string**

Name of the standard image. ||
|| folder_id | **string**

Folder of standard image. ||
|#