---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopImage/list.md
---

# Cloud Desktop API, gRPC: DesktopImageService.List

Lists desktop images in the specified folder.

## gRPC request

**rpc List ([ListDesktopImagesRequest](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest)) returns ([ListDesktopImagesResponse](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesResponse))**

## ListDesktopImagesRequest {#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list desktop images in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDesktopImagesRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDesktopImagesRequest.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [DesktopImage.name](#yandex.cloud.clouddesktop.v1.api.DesktopImage) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| order_by | **string**

Sorting the list by [DesktopImage.name](#yandex.cloud.clouddesktop.v1.api.DesktopImage), [DesktopImage.created_at](#yandex.cloud.clouddesktop.v1.api.DesktopImage) and [DesktopImage.status](#yandex.cloud.clouddesktop.v1.api.DesktopImage) fields.
The default sorting order is ascending. ||
|#

## ListDesktopImagesResponse {#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesResponse}

```json
{
  "desktop_images": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "status": "Status",
      "name": "string",
      "labels": "string",
      "storage_size": "int64",
      "min_disk_size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| desktop_images[] | **[DesktopImage](#yandex.cloud.clouddesktop.v1.api.DesktopImage)**

List of desktop images. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopImagesRequest.page_size](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest), use
the `next_page_token` as the value
for the [ListDesktopImagesRequest.page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## DesktopImage {#yandex.cloud.clouddesktop.v1.api.DesktopImage}

A desktop image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `ACTIVE`: Image is ready to use.
- `DELETING`: Image is being deleted. ||
|| name | **string**

Name of the image. ||
|| labels | **string**

Description of the image. ||
|| storage_size | **int64**

Size of the image, specified in bytes. ||
|| min_disk_size | **int64**

Minimum disk size in bytes required to use the image. ||
|#