[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PublicPrefixPool](index.md) > ListPublicPrefixPools

# BareMetal API, gRPC: PublicPrefixPoolService.ListPublicPrefixPools

Lists public prefix pools in the specified folder.

https://google.aip.dev/130 --)

## gRPC request

**rpc ListPublicPrefixPools ([ListPublicPrefixPoolsRequest](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest)) returns ([ListPublicPrefixPoolsResponse](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse))**

## ListPublicPrefixPoolsRequest {#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest}

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
the service returns a [ListPublicPrefixPoolsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicPrefixPoolsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse) returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `publicPrefixPoolId`, `createTime`, `updateTime`.
Default order: `publicPrefixPoolId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `publicPrefixPoolId`, `name` - `=`, `!=`, `:` (contains)

Example: `name : "prod"`. ||
|#

## ListPublicPrefixPoolsResponse {#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsResponse}

```json
{
  "public_prefix_pools": [
    {
      "public_prefix_pool_id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "cidr": "string",
      "min_available_prefix": "google.protobuf.Int64Value",
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
|| public_prefix_pools[] | **[PublicPrefixPool](#yandex.cloud.baremetal.v2.PublicPrefixPool)**

List of PublicPrefixPool resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicPrefixPoolsRequest.page_size](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest), use `next_page_token` as the value
for the [ListPublicPrefixPoolsRequest.page_token](#yandex.cloud.baremetal.v2.ListPublicPrefixPoolsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v2.PublicPrefixPool}

#|
||Field | Description ||
|| public_prefix_pool_id | **string**

ID of the public prefix pool.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| cloud_id | **string**

ID of the cloud that the public prefix pool belongs to. ||
|| folder_id | **string**

ID of the folder that the public prefix pool belongs to. ||
|| name | **string**

Name of the public prefix pool.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the public prefix pool.

The maximum string length in characters is 1024. ||
|| cidr | **string**

CIDR block of the public prefix pool. ||
|| min_available_prefix | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimal prefix that could be used for subnet creation ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#