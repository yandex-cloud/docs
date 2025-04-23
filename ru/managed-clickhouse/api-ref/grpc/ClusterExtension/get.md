---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/ClusterExtension/get.md
---

# Managed Service for ClickHouse API, gRPC: ClusterExtensionService.Get

## gRPC request

**rpc Get ([GetClusterExtensionRequest](#yandex.cloud.mdb.clickhouse.v1.GetClusterExtensionRequest)) returns ([ClusterExtension](#yandex.cloud.mdb.clickhouse.v1.ClusterExtension))**

## GetClusterExtensionRequest {#yandex.cloud.mdb.clickhouse.v1.GetClusterExtensionRequest}

```json
{
  "cluster_id": "string",
  "extension_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|| extension_name | **string**

Required field.  ||
|#

## ClusterExtension {#yandex.cloud.mdb.clickhouse.v1.ClusterExtension}

```json
{
  "name": "string",
  "cluster_id": "string",
  "version": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| cluster_id | **string**

Required field. Required. ID of the ClickHouse cluster. ||
|| version | **string**

Required field. Required. Extension version. ||
|#