---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/folders/{folderId}/images
    method: get
    path:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the parent folder. "baremetal-standard-images" folder contains general images and used by default
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListImagesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListImagesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListImagesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListImagesResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
            `"field [asc|desc]"`, e.g. `"createTime desc"`.
            Supported fields: `imageId`, `createTime`.
            Default order: `imageId asc`.
          type: string
        filter:
          description: |-
            **string**
            Filter expression following [AIP-160](https://google.aip.dev/160).
            Supported fields and operators:
            - `imageId`, `name` - `=`, `!=`, `:` (contains)
            Example: `name : "ubuntu"`.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# BareMetal API, REST: Image.ListImages

Retrieves the list of Image resources.


## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/folders/{folderId}/images
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the parent folder. "baremetal-standard-images" folder contains general images and used by default

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Query parameters {#yandex.cloud.baremetal.v2.ListImagesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListImagesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListImagesResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListImagesResponse) returned by a previous list request. ||
|| orderBy | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `imageId`, `createTime`.
Default order: `imageId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `imageId`, `name` - `=`, `!=`, `:` (contains)

Example: `name : "ubuntu"`. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "images": [
    {
      "imageId": "string",
      "folderId": "string",
      "name": "string",
      "family": "string",
      "state": "string",
      "publishTime": "string",
      "cloudId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.baremetal.v2.Image)**

List of StandardImage resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListImagesRequest.pageSize](#yandex.cloud.baremetal.v2.ListImagesRequest), use `next_page_token` as the value
for the [ListImagesRequest.pageToken](#yandex.cloud.baremetal.v2.ListImagesRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Image {#yandex.cloud.baremetal.v2.Image}

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