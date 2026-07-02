[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [MountedImage](index.md) > Get

# BareMetal API, gRPC: MountedImageService.Get

Get mounted user image.

## gRPC request

**rpc Get ([GetMountedImageRequest](#yandex.cloud.baremetal.v1alpha.GetMountedImageRequest)) returns ([GetMountedImageResponse](#yandex.cloud.baremetal.v1alpha.GetMountedImageResponse))**

## GetMountedImageRequest {#yandex.cloud.baremetal.v1alpha.GetMountedImageRequest}

```json
{
  "server_id": "string"
}
```

#|
||Field | Description ||
|| server_id | **string**

Required field. ID of the server to get mounted image from. ||
|#

## GetMountedImageResponse {#yandex.cloud.baremetal.v1alpha.GetMountedImageResponse}

```json
{
  "image_id": "string",
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| image_id | **string**

ID of the image that is mounted. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

When mounted image expires. ||
|#