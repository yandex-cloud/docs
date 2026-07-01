# BareMetal API, gRPC: MountedImageService.Delete

Unmount user image.

## gRPC request

**rpc Delete ([DeleteMountedImageRequest](#yandex.cloud.baremetal.v1alpha.DeleteMountedImageRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## DeleteMountedImageRequest {#yandex.cloud.baremetal.v1alpha.DeleteMountedImageRequest}

```json
{
  "server_id": "string"
}
```

#|
||Field | Description ||
|| server_id | **string**

Required field. ID of the server to unmount image from. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#