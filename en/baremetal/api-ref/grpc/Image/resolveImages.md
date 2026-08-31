---
editable: false
---

# BareMetal API, gRPC: ImageService.ResolveImages

Resolves the latest published Image for each available family within the specified folder.
Returns one Image per family - the most recently published one.

https://google.aip.dev/130 --)

https://google.aip.dev/130 --)

https://google.aip.dev/130 --)

## gRPC request

**rpc ResolveImages ([ResolveImagesRequest](#yandex.cloud.baremetal.v2.ResolveImagesRequest)) returns ([ResolveImagesResponse](#yandex.cloud.baremetal.v2.ResolveImagesResponse))**

## ResolveImagesRequest {#yandex.cloud.baremetal.v2.ResolveImagesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the parent folder. "baremetal-standard-images" folder contains general images and used by default

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ResolveImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ResolveImagesResponse)
that can be used to get the next page of results in subsequent resolve requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ResolveImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ResolveImagesResponse) returned by a previous resolve request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"family desc"`.

Supported fields: `family`, `imageId`, `createTime`.
Default order: `family asc`. ||
|#

## ResolveImagesResponse {#yandex.cloud.baremetal.v2.ResolveImagesResponse}

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

List of resolved Image resources - one per family, the most recently published. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ResolveImagesRequest.page_size](#yandex.cloud.baremetal.v2.ResolveImagesRequest), use `next_page_token` as the value
for the [ResolveImagesRequest.page_token](#yandex.cloud.baremetal.v2.ResolveImagesRequest) parameter in the next resolve request.
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

- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the image was published. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|#