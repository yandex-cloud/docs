[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [PublicPrefixPool](index.md) > Get

# BareMetal API, gRPC: PublicPrefixPoolService.Get

Returns the specified public prefix pool.

## gRPC request

**rpc Get ([GetPublicPrefixPoolRequest](#yandex.cloud.baremetal.v1alpha.GetPublicPrefixPoolRequest)) returns ([PublicPrefixPool](#yandex.cloud.baremetal.v1alpha.PublicPrefixPool))**

## GetPublicPrefixPoolRequest {#yandex.cloud.baremetal.v1alpha.GetPublicPrefixPoolRequest}

```json
{
  "public_prefix_pool_id": "string"
}
```

#|
||Field | Description ||
|| public_prefix_pool_id | **string**

ID of the Public prefix pool resource to return.
To get the pool ID, use a [PublicPrefixPoolService.List](list.md#List) request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## PublicPrefixPool {#yandex.cloud.baremetal.v1alpha.PublicPrefixPool}

```json
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
```

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