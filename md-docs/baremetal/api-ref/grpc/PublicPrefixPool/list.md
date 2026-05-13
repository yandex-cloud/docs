# BareMetal API, gRPC: PublicPrefixPoolService.List

Lists public prefix pools in the specified folder.

## gRPC request

**rpc List ([ListPublicPrefixPoolRequest](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest)) returns ([ListPublicPrefixPoolResponse](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse))**

## ListPublicPrefixPoolRequest {#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest}

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

ID of the folder to list public prefix pools in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicPrefixPoolResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicPrefixPoolResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "createdAt", "updatedAt"].
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

## ListPublicPrefixPoolResponse {#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolResponse}

```json
{
  "public_prefix_pools": [
    {
      "id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "cidr": "string",
      "min_available_prefix": "google.protobuf.Int64Value",
      "created_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| public_prefix_pools[] | **[PublicPrefixPool](#yandex.cloud.baremetal.v1alpha.PublicPrefixPool)**

List of public prefix pool resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicPrefixPoolRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest), use `next_page_token` as the value
for the [ListPublicPrefixPoolRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListPublicPrefixPoolRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v1alpha.PublicPrefixPool}

#|
||Field | Description ||
|| id | **string**

ID of the public prefix pool. ||
|| cloud_id | **string**

ID of the cloud that the public prefix pool belongs to. ||
|| folder_id | **string**

ID of the folder that the public prefix pool belongs to. ||
|| name | **string**

Name of the public prefix pool. ||
|| description | **string**

Description of the public prefix pool. ||
|| cidr | **string**

CIDR block of the public prefix pool. ||
|| min_available_prefix | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal prefix that could be used for subnet creation
Read only. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#