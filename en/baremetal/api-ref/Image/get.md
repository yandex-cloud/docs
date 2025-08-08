---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/images/{imageId}
    method: get
    path:
      type: object
      properties:
        imageId:
          description: |-
            **string**
            ID of the Image resource to return.
            To get the image ID, use a [ImageService.List](/docs/baremetal/api-ref/Image/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Image/get.md
---

# BareMetal API, REST: Image.Get

Returns the specific Image resource.

To get the list of available Image resources, make a [List](/docs/baremetal/api-ref/Image/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/images/{imageId}
```

## Path parameters

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the Image resource to return.

To get the image ID, use a [ImageService.List](/docs/baremetal/api-ref/Image/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.Image}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "checksum": "string",
  "status": "string",
  "createdAt": "string",
  "labels": "object"
}
```

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder. ||
|| description | **string**

Description of the image. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| status | **enum** (Status)

Status of the image.

- `STATUS_UNSPECIFIED`: Unspecified image status.
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#