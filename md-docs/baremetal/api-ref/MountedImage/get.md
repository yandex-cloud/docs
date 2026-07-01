# BareMetal API, REST: MountedImage.Get

Get mounted user image.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/mountedImages/{serverId}
```

## Path parameters

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to get mounted image from. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.GetMountedImageResponse}

**HTTP Code: 200 - OK**

```json
{
  "imageId": "string",
  "expiresAt": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

ID of the image that is mounted. ||
|| expiresAt | **string** (date-time)

When mounted image expires.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#