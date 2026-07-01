# BareMetal API, REST: MountedImage.Create

Mount user image.

## HTTP request

```
POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/mountedImages
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreateMountedImageRequest}

```json
{
  "serverId": "string",
  "imageId": "string"
}
```

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to mount image to. ||
|| imageId | **string**

Required field. ID of the image to mount. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**