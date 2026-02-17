---
editable: false
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

Required field.

The maximum string length in characters is 50. ||
|| extension_name | **string**

Required field.

The maximum string length in characters is 63. ||
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

Required field. Required. Extension name.

The maximum string length in characters is 63. ||
|| cluster_id | **string**

Required field. Required. ID of the ClickHouse cluster.

The maximum string length in characters is 50. ||
|| version | **string**

Required field. Required. Extension version. ||
|#