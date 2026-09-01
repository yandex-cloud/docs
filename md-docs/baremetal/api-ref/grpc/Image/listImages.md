[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [Image](index.md) > ListImages

# BareMetal API, gRPC: ImageService.ListImages

Retrieves the list of Image resources.


## gRPC request

**rpc ListImages ([ListImagesRequest](#yandex.cloud.baremetal.v2.ListImagesRequest)) returns ([ListImagesResponse](#yandex.cloud.baremetal.v2.ListImagesResponse))**

## ListImagesRequest {#yandex.cloud.baremetal.v2.ListImagesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the parent folder. "baremetal-standard-images" folder contains general images and used by default

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListImagesResponse) returned by a previous list request. ||
|| order_by | **string**

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

## ListImagesResponse {#yandex.cloud.baremetal.v2.ListImagesResponse}

```json
{
  "images": [
    {
      "image_id": "string",
      "folder_id": "string",
      "name": "string",
      "family": "string",
      "state": "Status",
      "publish_time": "google.protobuf.Timestamp",
      "cloud_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.baremetal.v2.Image)**

List of StandardImage resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListImagesRequest.page_size](#yandex.cloud.baremetal.v2.ListImagesRequest), use `next_page_token` as the value
for the [ListImagesRequest.page_token](#yandex.cloud.baremetal.v2.ListImagesRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Image {#yandex.cloud.baremetal.v2.Image}

An Image resource.

#|
||Field | Description ||
|| image_id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image ||
|| family | **string**

Family of the image ||
|| state | enum **Status**

State of the image.

- `IMPORTING`: Image is being imported.
- `IMPORTED`: Image has been imported and is awaiting moderation.
- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers.
- `ERROR`: Image encountered an error during import. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the image was published. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|#