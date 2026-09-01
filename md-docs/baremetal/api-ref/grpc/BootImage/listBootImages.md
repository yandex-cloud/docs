[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [BootImage](index.md) > ListBootImages

# BareMetal API, gRPC: BootImageService.ListBootImages

Retrieves the list of BootImage resources in the specified folder.


## gRPC request

**rpc ListBootImages ([ListBootImagesRequest](#yandex.cloud.baremetal.v2.ListBootImagesRequest)) returns ([ListBootImagesResponse](#yandex.cloud.baremetal.v2.ListBootImagesResponse))**

## ListBootImagesRequest {#yandex.cloud.baremetal.v2.ListBootImagesRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListBootImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListBootImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBootImagesResponse.next_page_token](#yandex.cloud.baremetal.v2.ListBootImagesResponse) returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `bootImageId`, `createTime`, `updateTime`.
Default order: `bootImageId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `bootImageId`, `name` - `=`, `!=`, `:` (contains)
- `state` - `=`, `!=`

Example: `state = "READY" AND name : "ubuntu"`. ||
|#

## ListBootImagesResponse {#yandex.cloud.baremetal.v2.ListBootImagesResponse}

```json
{
  "boot_images": [
    {
      "boot_image_id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "uri": "string",
      "checksum": "string",
      "state": "State",
      "create_time": "google.protobuf.Timestamp",
      "update_time": "google.protobuf.Timestamp",
      "annotations": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| boot_images[] | **[BootImage](#yandex.cloud.baremetal.v2.BootImage)**

List of BootImage resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListBootImagesRequest.page_size](#yandex.cloud.baremetal.v2.ListBootImagesRequest), use `next_page_token` as the value
for the [ListBootImagesRequest.page_token](#yandex.cloud.baremetal.v2.ListBootImagesRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## BootImage {#yandex.cloud.baremetal.v2.BootImage}

An BootImage resource.

#|
||Field | Description ||
|| boot_image_id | **string**

ID of the image. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the image.

The maximum string length in characters is 1024. ||
|| uri | **string**

URI of the source image to create the new image from.
Currently only supports links to images that are stored in Object Storage.
Currently only supports ISO formats.

The maximum string length in characters is 1024. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| state | enum **State**

State of the image.

- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Updafe timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#