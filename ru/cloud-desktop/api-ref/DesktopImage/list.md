---
editable: false
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopImage/list.md
---

# Cloud Desktop API, REST: DesktopImage.List {#List}

Lists desktop images in the specified folder.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/images
```

## Query parameters {#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list desktop images in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDesktopImagesRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDesktopImagesRequest.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [DesktopImage.name](#yandex.cloud.clouddesktop.v1.api.DesktopImage) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| orderBy | **string**

Sorting the list by [DesktopImage.name](#yandex.cloud.clouddesktop.v1.api.DesktopImage), [DesktopImage.createdAt](#yandex.cloud.clouddesktop.v1.api.DesktopImage) and [DesktopImage.status](#yandex.cloud.clouddesktop.v1.api.DesktopImage) fields.
The default sorting order is ascending. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "desktopImages": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "status": "string",
      "name": "string",
      "labels": "string",
      "storageSize": "string",
      "minDiskSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| desktopImages[] | **[DesktopImage](#yandex.cloud.clouddesktop.v1.api.DesktopImage)**

List of desktop images. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopImagesRequest.pageSize](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest), use
the `nextPageToken` as the value
for the [ListDesktopImagesRequest.pageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## DesktopImage {#yandex.cloud.clouddesktop.v1.api.DesktopImage}

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
|| labels | **string**

Description of the image. ||
|| storageSize | **string** (int64)

Size of the image, specified in bytes. ||
|| minDiskSize | **string** (int64)

Minimum disk size in bytes required to use the image. ||
|#