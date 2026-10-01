---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/folders/{folderId}/images/{imageId}
    method: get
    path:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the parent folder.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        imageId:
          description: |-
            **string**
            ID of the Image resource to return.
            To get the image ID, use a [ImageService.ListImages](/docs/baremetal/api-ref/Image/listImages#ListImages) request.
            The maximum string length in characters is 20.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: Image.GetImage

Returns the specific Image resource.
To get the list of resources, make a [ListImages](/docs/baremetal/api-ref/Image/listImages#ListImages) request.


## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/folders/{folderId}/images/{imageId}
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| imageId | **string**

Required field. ID of the Image resource to return.
To get the image ID, use a [ImageService.ListImages](/docs/baremetal/api-ref/Image/listImages#ListImages) request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v2.Image}

**HTTP Code: 200 - OK**

```json
{
  "imageId": "string",
  "folderId": "string",
  "name": "string",
  "family": "string",
  "state": "string",
  "publishTime": "string",
  "cloudId": "string"
}
```

An Image resource.

#|
||Field | Description ||
|| imageId | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image ||
|| family | **string**

Family of the image ||
|| state | **enum** (Status)

State of the image.

- `IMPORTING`: Image is being imported.
- `IMPORTED`: Image has been imported and is awaiting moderation.
- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers.
- `ERROR`: Image encountered an error during import. ||
|| publishTime | **string** (date-time)

Timestamp when the image was published.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cloudId | **string**

ID of the cloud that the image belongs to. ||
|#