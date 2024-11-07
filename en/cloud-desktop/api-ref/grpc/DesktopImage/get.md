---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopImage/get.md
---

# Cloud Desktop API, gRPC: DesktopImageService.Get {#Get}

Returns the specified desktop image.

## gRPC request

**rpc Get ([GetDesktopImageRequest](#yandex.cloud.clouddesktop.v1.api.GetDesktopImageRequest)) returns ([DesktopImage](#yandex.cloud.clouddesktop.v1.api.DesktopImage))**

## GetDesktopImageRequest {#yandex.cloud.clouddesktop.v1.api.GetDesktopImageRequest}

```json
{
  "imageId": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the image to get. ||
|#

## DesktopImage {#yandex.cloud.clouddesktop.v1.api.DesktopImage}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "status": "Status",
  "name": "string",
  "labels": "string",
  "storageSize": "int64",
  "minDiskSize": "int64"
}
```

A desktop image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `ACTIVE`: Image is ready to use.
- `DELETING`: Image is being deleted. ||
|| name | **string**

Name of the image. ||
|| labels | **string**

Description of the image. ||
|| storageSize | **int64**

Size of the image, specified in bytes. ||
|| minDiskSize | **int64**

Minimum disk size in bytes required to use the image. ||
|#