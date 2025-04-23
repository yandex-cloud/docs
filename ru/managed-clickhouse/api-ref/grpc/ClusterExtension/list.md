---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/ClusterExtension/list.md
---

# Managed Service for ClickHouse API, gRPC: ClusterExtensionService.List

## gRPC request

**rpc List ([ListClusterExtensionsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsRequest)) returns ([ListClusterExtensionsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse))**

## ListClusterExtensionsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|| page_size | **int64** ||
|| page_token | **string** ||
|#

## ListClusterExtensionsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "cluster_id": "string",
      "version": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[ClusterExtension](#yandex.cloud.mdb.clickhouse.v1.ClusterExtension)** ||
|| next_page_token | **string** ||
|#

## ClusterExtension {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| cluster_id | **string**

Required field. Required. ID of the ClickHouse cluster. ||
|| version | **string**

Required field. Required. Extension version. ||
|#