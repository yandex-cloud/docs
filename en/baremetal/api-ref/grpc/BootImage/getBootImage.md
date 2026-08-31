---
editable: false
---

# BareMetal API, gRPC: BootImageService.GetBootImage

Returns the specific BootImage resource.
To get the list of available Image resources, make a [List] request.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetBootImage ([GetBootImageRequest](#yandex.cloud.baremetal.v2.GetBootImageRequest)) returns ([BootImage](#yandex.cloud.baremetal.v2.BootImage))**

## GetBootImageRequest {#yandex.cloud.baremetal.v2.GetBootImageRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "boot_image_id": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| boot_image_id | **string**

ID of the BootImage resource to return.
To get the boot image ID, use a [ImageService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## BootImage {#yandex.cloud.baremetal.v2.BootImage}

```json
{
  "boot_image_id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "uri": "string",
  "checksum": "string",
  "state": "State",
  "create_time": "google.protobuf.Timestamp",
  "update_time": "google.protobuf.Timestamp",
  "annotations": "map<string, string>"
}
```

An BootImage resource.

#|
||Field | Description ||
|| boot_image_id | **string**

ID of the image. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the image.

The maximum string length in characters is 1024. ||
|| uri | **string**

URI of the source image to create the new image from.
Currently only supports links to images that are stored in Object Storage.
Currently only supports ISO formats.

The maximum string length in characters is 1024. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| state | enum **State**

State of the image.

- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Updafe timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#