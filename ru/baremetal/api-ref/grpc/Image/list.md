---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Image/list.md
---

# BareMetal API, gRPC: ImageService.List

Retrieves the list of Image resources in the specified folder.

## gRPC request

**rpc List ([ListImagesRequest](#yandex.cloud.baremetal.v1alpha.ListImagesRequest)) returns ([ListImagesResponse](#yandex.cloud.baremetal.v1alpha.ListImagesResponse))**

## ListImagesRequest {#yandex.cloud.baremetal.v1alpha.ListImagesRequest}

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

ID of the folder to list images in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationsResponse.next_page_token](/docs/baremetal/api-ref/grpc/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationsResponse.next_page_token](/docs/baremetal/api-ref/grpc/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name", "createdAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name"].
Both snake_case and camelCase are supported for fields. ||
|#

## ListImagesResponse {#yandex.cloud.baremetal.v1alpha.ListImagesResponse}

```json
{
  "images": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "checksum": "string",
      "status": "Status",
      "created_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.baremetal.v1alpha.Image)**

List of Image resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListImagesRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListImagesRequest), use `next_page_token` as the value
for the [ListImagesRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListImagesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Image {#yandex.cloud.baremetal.v1alpha.Image}

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder. ||
|| description | **string**

Description of the image. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`: Unspecified image status.
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#