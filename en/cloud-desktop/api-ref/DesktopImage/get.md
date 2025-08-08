---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/images/{imageId}
    method: get
    path:
      type: object
      properties:
        imageId:
          description: |-
            **string**
            Required field. ID of the image to get.
          type: string
      required:
        - imageId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopImage/get.md
---

# Cloud Desktop API, REST: DesktopImage.Get

Returns the specified desktop image.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/images/{imageId}
```

## Path parameters

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the image to get. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.DesktopImage}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "labels": "object",
  "storageSize": "string",
  "minDiskSize": "string"
}
```

A desktop image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `ACTIVE`: Image is ready to use.
- `DELETING`: Image is being deleted. ||
|| name | **string**

Name of the image. ||
|| labels | **object** (map<**string**, **string**>)

Description of the image. ||
|| storageSize | **string** (int64)

Size of the image, specified in bytes. ||
|| minDiskSize | **string** (int64)

Minimum disk size in bytes required to use the image. ||
|#