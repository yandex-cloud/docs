[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PublicPrefixPool](index.md) > GetPublicPrefixPool

# BareMetal API, gRPC: PublicPrefixPoolService.GetPublicPrefixPool

Returns the specified public prefix pool.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetPublicPrefixPool ([GetPublicPrefixPoolRequest](#yandex.cloud.baremetal.v2.GetPublicPrefixPoolRequest)) returns ([PublicPrefixPool](#yandex.cloud.baremetal.v2.PublicPrefixPool))**

## GetPublicPrefixPoolRequest {#yandex.cloud.baremetal.v2.GetPublicPrefixPoolRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "public_prefix_pool_id": "string"
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
|| public_prefix_pool_id | **string**

ID of the Public prefix pool resource to return.

To get the pool ID, use a [PublicPrefixPoolService.List] request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v2.PublicPrefixPool}

```json
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
```

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