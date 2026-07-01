# BareMetal API, REST: MountedImage.Delete

Unmount user image.

## HTTP request

```
DELETE https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/mountedImages/{serverId}
```

## Path parameters

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to unmount image from. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**