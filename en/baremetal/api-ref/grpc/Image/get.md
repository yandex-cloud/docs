---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Image/get.md
---

# BareMetal API, gRPC: ImageService.Get

Returns the specific Image resource.

To get the list of available Image resources, make a [List](/docs/baremetal/api-ref/grpc/Image/list#List) request.

## gRPC request

**rpc Get ([GetImageRequest](#yandex.cloud.baremetal.v1alpha.GetImageRequest)) returns ([Image](#yandex.cloud.baremetal.v1alpha.Image))**

## GetImageRequest {#yandex.cloud.baremetal.v1alpha.GetImageRequest}

```json
{
  "image_id": "string"
}
```

#|
||Field | Description ||
|| image_id | **string**

ID of the Image resource to return.

To get the image ID, use a [ImageService.List](/docs/baremetal/api-ref/grpc/Image/list#List) request. ||
|#

## Image {#yandex.cloud.baremetal.v1alpha.Image}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "checksum": "string",
  "status": "Status",
  "created_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder. ||
|| description | **string**

Description of the image. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`: Unspecified image status.
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#