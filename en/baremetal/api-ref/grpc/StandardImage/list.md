---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/StandardImage/list.md
---

# BareMetal API, gRPC: StandardImageService.List

Retrieves the list of Image resources in the specified folder. Pass the "baremetal-standard-images" folder to get general images.

## gRPC request

**rpc List ([ListStandardImagesRequest](#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest)) returns ([ListStandardImagesResponse](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse))**

## ListStandardImagesRequest {#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListStandardImagesResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListStandardImagesResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name"].
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
|| folder_id | **string**

ID of the folder to return a StandardImage resource for.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. Pass the "baremetal-standard-images" folder to get general images. ||
|#

## ListStandardImagesResponse {#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse}

```json
{
  "standard_images": [
    {
      "id": "string",
      "name": "string",
      "folder_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| standard_images[] | **[StandardImage](#yandex.cloud.baremetal.v1alpha.StandardImage)**

List of StandardImage resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListStandardImagesRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest), use `next_page_token` as the value
for the [ListStandardImagesRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## StandardImage {#yandex.cloud.baremetal.v1alpha.StandardImage}

A Standard Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the standard image. ||
|| name | **string**

Name of the standard image. ||
|| folder_id | **string**

Folder of standard image. ||
|#