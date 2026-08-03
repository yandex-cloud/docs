[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [Image](index.md) > GetImage

# BareMetal API, gRPC: ImageService.GetImage

Returns the specific Image resource.
To get the list of resources, make a [ListImages](listImages.md#ListImages) request.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetImage ([GetImageRequest](#yandex.cloud.baremetal.v2.GetImageRequest)) returns ([Image](#yandex.cloud.baremetal.v2.Image))**

## GetImageRequest {#yandex.cloud.baremetal.v2.GetImageRequest}

```json
{
  "folder_id": "string",
  "image_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| image_id | **string**

ID of the Image resource to return.
To get the image ID, use a [ImageService.ListImages](listImages.md#ListImages) request.

The maximum string length in characters is 20. ||
|#

## Image {#yandex.cloud.baremetal.v2.Image}

```json
{
  "image_id": "string",
  "folder_id": "string",
  "name": "string",
  "family": "string",
  "state": "Status",
  "publish_time": "google.protobuf.Timestamp",
  "cloud_id": "string"
}
```

An Image resource.

#|
||Field | Description ||
|| image_id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image ||
|| family | **string**

Family of the image ||
|| state | enum **Status**

State of the image.

- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the image was published. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|#