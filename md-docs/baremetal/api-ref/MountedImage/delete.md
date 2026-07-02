[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > [REST (англ.)](../index.md) > [MountedImage](index.md) > Delete

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