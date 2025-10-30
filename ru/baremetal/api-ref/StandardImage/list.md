---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/standardImages
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListStandardImagesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListStandardImagesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            By which column the listing should be ordered and in which direction,
            format is "createdAt desc". "id asc" if omitted.
            Supported fields: ["id", "name"].
            Both snake_case and camelCase are supported for fields.
          type: string
        filter:
          description: |-
            **string**
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
            Both snake_case and camelCase are supported for fields.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder to return a StandardImage resource for.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. Pass the "baremetal-standard-images" folder to get general images.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/StandardImage/list.md
---

# BareMetal API, REST: StandardImage.List

Retrieves the list of Image resources in the specified folder. Pass the "baremetal-standard-images" folder to get general images.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/standardImages
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListStandardImagesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListStandardImagesResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse) returned by a previous list request. ||
|| orderBy | **string**

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
|| folderId | **string**

ID of the folder to return a StandardImage resource for.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. Pass the "baremetal-standard-images" folder to get general images. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListStandardImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "standardImages": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| standardImages[] | **[StandardImage](#yandex.cloud.baremetal.v1alpha.StandardImage)**

List of StandardImage resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListStandardImagesRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest), use `next_page_token` as the value
for the [ListStandardImagesRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListStandardImagesRequest) parameter in the next list request.

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
|| folderId | **string**

Folder of standard image. ||
|#