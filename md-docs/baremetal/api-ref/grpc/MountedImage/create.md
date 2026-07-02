[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [MountedImage](index.md) > Create

# BareMetal API, gRPC: MountedImageService.Create

Mount user image.

## gRPC request

**rpc Create ([CreateMountedImageRequest](#yandex.cloud.baremetal.v1alpha.CreateMountedImageRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## CreateMountedImageRequest {#yandex.cloud.baremetal.v1alpha.CreateMountedImageRequest}

```json
{
  "server_id": "string",
  "image_id": "string"
}
```

#|
||Field | Description ||
|| server_id | **string**

Required field. ID of the server to mount image to. ||
|| image_id | **string**

Required field. ID of the image to mount. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#